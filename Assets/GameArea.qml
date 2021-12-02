import QtQuick 2.0
import Common 43.21

Item {
    id: root    // всегда пишем айди у корневого элемента и всегда называем его root.

    readonly property alias stepCount: p.stepsCount
    readonly property alias gameStart: p.gameStart
    readonly property alias gameFinish: p.gameFinish
    readonly property alias size: p.size

    // При окончании игры.
    signal finished()

    implicitWidth: gameArea.implicitWidth
    implicitHeight: gameArea.implicitHeight

    // Инициализирует игру.
    function initGame(size) {
        initGameRandom(size);
    }

    // Инициализирует игру по последовательности array.
    function initGameArray(array) {
        p.clearGame();
        console.log('init game', array.join(' '))
        if (!checkArrayForGame(array)){
            return;
        }

        p.size = Math.sqrt(array.length);
        for (let j = 0; j < p.size; ++j) {
            p.squares.push([]);
            for (let i = 0; i < p.size; ++i) {
                let sq = squareComponent.incubateObject(gameArea, {
                                                            number: array[j * p.size + i]
                                                        }, Qt.Synchronous);
                p.squares[j].push(sq.object);
            }
        }
        p.updateSquaresWidth();
        p.initOtherFields();
        p.checkToFinish();
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
            console.log("Не смог исправить игру");
            console.log(randomArray);
        }

        initGameArray(randomArray);
    }

    // Проверяет игру на наличие решения.
    function checkArrayForGame(arrayOrig) {
        let size = Math.sqrt(arrayOrig.length);
        let indZero = arrayOrig.indexOf(0);
        if (size !== parseInt(size) || indZero === -1) {
            console.log('Не верный формат аргументов');
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
        console.log(size, e, rightPart, summ, result);
        return result % 2;
    }

    // Возвращает время игры от начала (до финиша, если был финиш) в формате h:mm
    function gameTime() {
        if (!p.gameStart) {
            return '00:00';
        }

        if (!p.gameFinish) {
            p.gameFinish = new Date;
        }
        let different = p.gameFinish - p.gameStart;
        let m = Math.floor(different / 60000);
        let s = Math.round((different % 60000) / 1000);

        return '%1:%2'.arg(m).arg(s > 9 ? s : '0' + s)
    }

    QtObject {
        id: p
        // Наша матрица объектов.
        property var squares: []
        property int size
        readonly property int squareWidth: size === 0 ? 0 : gameArea.width / size
        property int stepsCount
        property date gameStart
        property date gameFinish

        onSquareWidthChanged: updateSquaresWidth()

        function initOtherFields() {
            p.stepsCount = 0;
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
            p.gameFinish = new Date;
            root.finished();
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
            console.log('Не смог найти пустую строку')
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
            let nullPoint = findFreePosition();
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
//                p.clearGame();
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
            let v = 1 + parseInt(Math.random() * (array.length - 2)); // 1..length - 1
            let indOfv1 = array.indexOf(v);
            let indOfv2 = array.indexOf(v + 1);
            [array[indOfv1], array[indOfv2]] = [
              array[indOfv2], array[indOfv1]];
            return checkArrayForGame(array);
        }

        function clearGame() {
            for (let i = 0; i < size; ++i) {
                for (let j = 0; j < size; ++ j) {
                    squares[i][j].destroy();
                }
            }

            squares = []
        }
    }

    Component {
        id: squareComponent
        Square { }
    }

    Rectangle {
        id: gameArea

        anchors.centerIn: parent

        width: Math.min(root.width, root.height)
        height: width

        color: 'skyblue'

        MouseArea {
            id: ma

            anchors.fill: gameArea

            onClicked: {
                let r = parseInt(mouseY / p.squareWidth);
                let c = parseInt(mouseX / p.squareWidth);
                p.gameStep(Qt.point(c, r));
            }
        }
    }
}
