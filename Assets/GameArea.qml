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
            return;
        }

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
                    for (let i = nullPoint.y; i > stepPoint.y; --i) {
                        swap2squares(Qt.point(xX, i),
                                     Qt.point(xX, i - 1));
                    }
                } else {
                    for (let i = nullPoint.y; i < stepPoint.y; ++i) {
                        swap2squares(Qt.point(xX, i),
                                     Qt.point(xX, i + 1));
                    }
                }
            } else {
                const yY = nullPoint.y;
                const toRight = nullPoint.x > stepPoint.x;
                if (toRight) {
                    for (let i = nullPoint.x; i > stepPoint.x; --i) {
                        swap2squares(Qt.point(i, yY),
                                     Qt.point(i - 1, yY));
                    }
                } else {
                    for (let i = nullPoint.x; i < stepPoint.x; ++i) {
                        swap2squares(Qt.point(i, yY),
                                     Qt.point(i + 1, yY));
                    }
                }
            }
        }
        return false;
    }

    // Инициализирует игру.
    function initGame(size) {
        initGameRandom(size);
    }

    function initGameArray(array) {
        let size = Math.sqrt(array.length)
        if (size !== parseInt(size)) {
            console.log('Не верный формат аргументов');
            return;
        }
        root.size = size
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
