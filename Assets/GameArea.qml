import QtQuick 2.0

Item {
    id: root

    // Имя компонента!
    property string squareUrl   // \todo in qt6 required
    property bool pause: false
    readonly property alias stepCount: p.stepsCount
    readonly property alias gameTimeSec: p.gameTimeSec
    readonly property alias size: p.size
    readonly property alias areaSize: gameArea.width

    signal started()
    signal continued()
    signal finished()

    function getGamePosition() {
        let arr = [];
        for (let i = 0; i < p.squares.length; ++i) {
            for (let j = 0; j < p.squares.length; ++j) {
                arr.push(p.squares[i][j].number);
            }
        }
        return arr.join(",");
    }

    implicitWidth: gameArea.implicitWidth
    implicitHeight: gameArea.implicitHeight
    focus: true

    Keys.onPressed: {
        if (pause) {
            return;
        }

        const keysArray = [Qt.Key_Left, Qt.Key_Right, Qt.Key_Up, Qt.Key_Down];
        const indOfKey = keysArray.indexOf(event.key);
        if (indOfKey === -1) {
            return;
        }
        const funcsArray = [p.toLeft, p.toRight, p.toUp, p.toDown];
        const funcsArrayInversion = [p.toRight, p.toLeft, p.toDown, p.toUp];
        funcsArray[indOfKey]();
        event.accepted = true;
    }

    // Инициализирует игру.
    function initGame(size) {
        initGameRandom(size);
    }

    // Инициализирует игру по последовательности array.
    function initGameArray(array, steps = 0, timeSec = 0) {
        if (root.squareUrl === '') {
            console.error('Квадрат не объявлен!')
            return
        }

        p.clearGame();
        if (!checkArrayForGame(array)){
            return;
        }

        p.size = Math.sqrt(array.length);
        p.array = array;
        p.squareComponent = Qt.createComponent(root.squareUrl);
        p.stepsCount = steps;
        p.gameTimeSec = timeSec;
        if (p.squareComponent.status === Component.Error) {
            console.error('Ошибка в коде квадрата');
            return;
        } else if (p.squareComponent.status === Component.Ready) {
            p.createObjects();
        } else {
            p.squareComponent.statusChanged.connect(p.createObjects);
        }
        if (steps) {
            continued()
        } else {
            started();
        }
    }

    // Инициализирует начальное положение клеток по порядку.
    function initGameDemo(size) {
        let array = p.iota(Array(size * size), 1);
        array[array.length - 1] = 0;
        initGameArray(array);
    }

    // Инициализация игры с размешанными клетками.
    function initGameRandom(size) {
        let randomArray = p.shuffle(p.iota(Array(size * size)));
        if (!checkArrayForGame(randomArray)
                && !p.tryToFixArray(randomArray)) {
            console.error("Не смог исправить игру");
            console.error(randomArray);
        }

        initGameArray(randomArray);
    }

    // Проверяет игру на наличие решения.
    function checkArrayForGame(arrayOrig) {
        let size = Math.sqrt(arrayOrig.length);
        let indZero = arrayOrig.indexOf(0);
        if (size !== parseInt(size) || indZero === -1) {
            console.error('Не верный формат аргументов');
            return false;
        }
        let e = parseInt(indZero / size); // на какой строке пустая клетка начиная с 0

        let rightPart = (size - 1) * (e - 1) + 1;

        let array = arrayOrig.slice(); // make copy array;
        array.splice(indZero, 1); // удалил нолик из массива.

        let summ = 0;

        for (let i = 0; i < array.length - 1; ++i) {
            for (let j = i; j < array.length; ++j) {
                summ += array[i] > array[j];
            }
        }
        let result = summ + rightPart;
        return result % 2;
    }

    QtObject {
        id: p

        property var squares: []
        property int size
        property var array
        property var squareComponent
        readonly property int squareWidth: p.size === 0 ? 0 : gameArea.width / p.size
        property int stepsCount: 0
        property int gameTimeSec: 0
        property date gameStart
        property date gameFinish

        onSquareWidthChanged: updateSquaresWidth()

        function createObjects() {
            if (!p.squareComponent || p.squareComponent.status !== Component.Ready) {
                console.error('что то не так с squareComponent', p.squareComponent);
                return
            }

            for (let j = 0; j < p.size; ++j) {
                p.squares.push([]);
                for (let i = 0; i < p.size; ++i) {
                    let sq = p.squareComponent.incubateObject(gameArea, {
                                                                number: p.array[j * p.size + i]
                                                            }, Qt.Synchronous);
                    p.squares[j].push(sq.object);
                }
            }
            p.updateSquaresWidth();
            p.initOtherFields();
            if (p.checkToFinish()) {
                root.pause = true;
                p.gameFinish = new Date;
                root.finished();
            }
        }

        function initOtherFields() {
            root.pause = false;
            p.gameStart = new Date;
            p.gameFinish = new Date(0);
        }

        function checkToFinish() {
            let i, j;
            for (i = 0; i < p.size; ++i) {
                for (j = 0; j < p.size; ++j) {
                    if (squares[i][j].number !== i * p.size + j + 1) {
                        if (i === p.size - 1 && j === p.size - 1 && squares[i][j].number === 0) {
                            continue;
                        }
                        return false;
                    }
                }
            }
            return true;
        }

        // Находим пустую клетку.
        // Возвращает точку, где х - столбец, у - строка.
        function findFreePosition () {
            for (let i = 0; i < squares.length; ++i) {
                for (let j = 0; j < squares.length; ++j) {
                    if (squares[i][j].number === 0) {
                        return Qt.point(j, i);
                    }
                }
            }
            console.error('Не смог найти пустую строку')
            console.assert(false);
        }

        // Определяет соседние клетки.
        // На вход принимает 2 точки.
        // Возвращает true если точки соседи, иначе false.
        function isNeighbour(p1, p2) {
            if (p1.x === p2.x) {
                return Math.abs(p1.y - p2.y) === 1;
            }
            if (p1.y === p2.y) {
                return Math.abs(p1.x - p2.x) === 1;
            }
            return false;
        }

        // Возвращает true если на одной линии.
        function isInOneLine(p1, p2) {
            return p1.x === p2.x || p1.y === p2.y;
        }

        // Обновление размера квадратов.
        function updateSquaresWidth() {
            for (let i = 0; i < squares.length; ++i) {
                for (let j = 0; j < squares.length; ++j) {
                    squares[i][j].width = squareWidth;
                }
            }
            updateSquaresPositions();
        }

        // Обновление позиции квадрата.
        function updateOneSquarePositions(square, row, column) {
            squares[row][column].x = column * squareWidth
            squares[row][column].y = row * squareWidth
        }

        // Обновление позиций квадратов в соотвествии с матрицей.
        function updateSquaresPositions() {
            for (let i = 0; i < squares.length; ++i) {
                for (let j = 0; j < squares.length; ++j) {
                    updateOneSquarePositions(squares[i][j], i, j);
                }
            }
        }

        // Поменять местами квадраты и обновить позиции.
        function swap2squares(p1, p2) {
            [squares[p1.y][p1.x], squares[p2.y][p2.x]] = [
              squares[p2.y][p2.x], squares[p1.y][p1.x]];
            updateOneSquarePositions(squares[p1.y][p1.x], p1.y, p1.x);
            updateOneSquarePositions(squares[p2.y][p2.x], p2.y, p2.x);
        }

        // Проверяет возможность шага и делает шаг при необходимости.
        // На входе принимает точку клика.
        // Возвращает true если шаг доступен.
        function gameStep(stepPoint) {
            const nullPoint = findFreePosition();
            if (stepPoint === nullPoint) {
                // Клик на пустую клетку.
                return false;
            }

            let i; // для циклов
            if (isNeighbour(nullPoint, stepPoint)) {
                // Если соседние клетки.
                swap2squares(nullPoint, stepPoint);
            } else if (isInOneLine(nullPoint, stepPoint)) {
                // Если на одной линии.
                const isVertical = nullPoint.x === stepPoint.x;
                if (isVertical) {
                    const xX = nullPoint.x;
                    const toBottom = nullPoint.y > stepPoint.y;
                    if (toBottom) {
                        for (i = nullPoint.y; i > stepPoint.y; --i) {
                            swap2squares(Qt.point(xX, i),
                                         Qt.point(xX, i - 1));
                        }
                    } else {
                        for (i = nullPoint.y; i < stepPoint.y; ++i) {
                            swap2squares(Qt.point(xX, i),
                                         Qt.point(xX, i + 1));
                        }
                    }
                } else {
                    const yY = nullPoint.y;
                    const toRight = nullPoint.x > stepPoint.x;
                    if (toRight) {
                        for (i = nullPoint.x; i > stepPoint.x; --i) {
                            swap2squares(Qt.point(i, yY),
                                         Qt.point(i - 1, yY));
                        }
                    } else {
                        for (i = nullPoint.x; i < stepPoint.x; ++i) {
                            swap2squares(Qt.point(i, yY),
                                         Qt.point(i + 1, yY));
                        }
                    }
                }
            } else {
                return false;
            }
            ++p.stepsCount;
            if (p.checkToFinish()) {
                root.pause = 1;
                p.gameFinish = new Date;
                root.finished();
            }

            return true;
        }

        // Размешивает массив.
        // from https://stackoverflow.com/questions/2450954/how-to-randomize-shuffle-a-javascript-array
        function shuffle(array) {
            let currentIndex = array.length,  randomIndex;

            // While there remain elements to shuffle...
            while (currentIndex !== 0) {

                // Pick a remaining element...
                randomIndex = Math.floor(Math.random() * currentIndex);
                currentIndex--;

                // And swap it with the current element.
                [array[currentIndex], array[randomIndex]] = [
                  array[randomIndex], array[currentIndex]];
            }

            return array;
        }

        // Инициализирует последовательно массив начиная с startNum.
        function iota(array, startNum = 0) {
            for (let i = 0; i < array.length; ++i) {
                array[i] = startNum + i;
            }
            return array;
        }

        // Попытка исправить игру. (Если изначально игра с решением, то он делает ее нерешаемой)
        function tryToFixArray(array) {
            const v = 1 + parseInt(Math.random() * (array.length - 2)); // 1..length - 1
            const indOfv1 = array.indexOf(v);
            const indOfv2 = array.indexOf(v + 1);
            [array[indOfv1], array[indOfv2]] = [
              array[indOfv2], array[indOfv1]];
            return checkArrayForGame(array);
        }

        // Очищает динамически созданные квадраты.
        function clearGame() {
            for (let i = 0; i < size; ++i) {
                for (let j = 0; j < size; ++ j) {
                    squares[i][j].destroy();
                }
            }
            squares = []
        }

        // Перемещает квадрат влево (если слево свободно)
        function toLeft() {
            const freePoint = findFreePosition();
            if (freePoint.x === p.size - 1) {
                return false;
            }
            gameStep(Qt.point(freePoint.x + 1, freePoint.y));
            return true;
        }

        function toRight() {
            const freePoint = findFreePosition();
            if (freePoint.x === 0) {
                return false;
            }
            gameStep(Qt.point(freePoint.x - 1, freePoint.y));
            return true;
        }

        function toUp() {
            const freePoint = findFreePosition();
            if (freePoint.y === p.size - 1) {
                return false;
            }
            gameStep(Qt.point(freePoint.x, freePoint.y + 1));
            return true;
        }

        function toDown() {
            const freePoint = findFreePosition();
            if (freePoint.y === 0) {
                return false;
            }
            gameStep(Qt.point(freePoint.x, freePoint.y - 1));
            return true;
        }

    }

    Timer {
        id: timer
        interval: 1000
        repeat: true
        running: !pause && stepCount > 0
        onTriggered: {
            ++p.gameTimeSec;
        }
    }

    Item {
        id: gameArea

        anchors.centerIn: parent
        width: Math.min(root.width, root.height)
        height: width

        MouseArea {
            id: ma
            enabled: !pause

            anchors.fill: gameArea

            onClicked: {
                const r = parseInt(mouseY / p.squareWidth);
                const c = parseInt(mouseX / p.squareWidth);
                p.gameStep(Qt.point(c, r));
            }
        }
    }
}
