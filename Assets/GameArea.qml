import QtQuick 2.0
import Common 43.21

Item {
    id: root    // всегда пишем айди у корневого элемента и всегда называем его root.

    // Наша матрица объектов.
    property var squares: []
    property int size: 4

    readonly property int squareWidth: gameArea.width / size

    onSquareWidthChanged: updateSquaresWidth()

    implicitWidth: gameArea.implicitWidth
    implicitHeight: gameArea.implicitHeight

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
        return true;
    }

    // Инициализирует игру.
    function initGame(size) {
        initGameRandom(size);
    }

    // Инициализирует игру по последовательности array.
    function initGameArray(array) {
        root.size = Math.sqrt(array.length);
        for (let j = 0; j < size; ++j) {
            squares.push([]);
            for (let i = 0; i < size; ++i) {
                let sq = squareComponent.incubateObject(gameArea, {
                                                            number: array[j * size + i]
                                                        }, Qt.Synchronous);
                squares[j].push(sq.object);
            }
        }
        updateSquaresWidth();
        p.initOtherFields();
    }

    // Инициализирует начальное положение клеток по порядку.
    function initGameDemo(size) {
        let array = iota(Array(size * size), 1);
        array[array.length - 1] = 0;
        initGameArray(array);
    }

    // Инициализация игры с размешанными клетками.
    function initGameRandom(size) {
        let randomArray = shuffle(iota(Array(size * size)));
        if (!checkArrayForGame(randomArray)
                && !tryToFixArray(randomArray)) {
            console.log("Не смог исправить игру");
            console.log(randomArray);
        }

        initGameArray(randomArray);
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

    // Проверяет игру на наличие решения.
    function checkArrayForGame(arrayOrig) {
        let size = Math.sqrt(arrayOrig.length);
        let indZero = arrayOrig.indexOf(0);
        if (size !== parseInt(size) || indZero === -1) {
            console.log('Не верный формат аргументов');
            return false;
        }

        let array = arrayOrig.slice(); // make copy array;

        let N = parseInt(indZero / size); // на какой строке пустая клетка
        array.splice(indZero, 1); // удалил нолик из массива.
        for(let i = 0; i < array.length; ++i) {
            for (let j = 0; j < i; ++j) {
                N += array[i] < array[j];
            }
        }
        return ((size % 2) && !(N % 2))
                || (!(size % 2) && (N % 2));
    }

    // Попытка исправить игру. (Исли изначально игра с решением, то он делает ее нерешаемой)
    function tryToFixArray(array) {
        let v = 1 + parseInt(Math.random() * (array.length - 2)); // 1..length - 1
        let indOfv1 = array.indexOf(v);
        let indOfv2 = array.indexOf(v + 1);
        [array[indOfv1], array[indOfv2]] = [
          array[indOfv2], array[indOfv1]];
        return checkArrayForGame(array);
    }

    QtObject {
        id: p
        property int stepsCount
        property date gameStart
        property date gameFinish

        function initOtherFields() {
            p.stepsCount = 0;
            p.gameStart = Date.now();
            p.gameFinish = null;
        }
    }

    Component {
        id: squareComponent
        Square { }
    }

    Rectangle {
        id: gameArea

        implicitWidth: ProjectStyles.gameSide
        implicitHeight: ProjectStyles.gameSide
        anchors.centerIn: parent
        width: Math.min(root.width, root.height)
        height: width

        color: 'skyblue'

        MouseArea {
            id: ma

            anchors.fill: gameArea

            onClicked: {
                let r = parseInt(mouseY / root.squareWidth);
                let c = parseInt(mouseX / root.squareWidth);
                root.gameStep(Qt.point(c, r));
            }
        }
    }
}
