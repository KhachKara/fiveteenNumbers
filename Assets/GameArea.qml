import QtQuick 2.0
import Common 43.21

Item {
    id: root    // всегда пишем айди у корневого элемента и всегда называем его root.

    // Наша матрица объектов.
    property var squares: []

    implicitWidth: gameArea.implicitWidth
    implicitHeight: gameArea.implicitHeight

    // Находим пустую клетку.
    // Возвращает точку, где х - столбец, у - строка.
    function findFreePosition () {
        for (let i = 0; i < squares.length; ++i) {
            for (let j = 0; j < squares.length; ++j) {
                if (squares[i][j] === null) {
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
    function isNeighbour(a, b) {
        if (a.x === b.x) {
            return Math.abs(a.y - b.y) === 1;
        }
        if (a.y === b.y) {
            return Math.abs(a.x - b.x) === 1;
        }
        return false;
    }

    // Обновление позиций квадратов в соотвествии с матрицей.
    function updateSquaresPositions() {
        for (let i = 0; i < squares.length; ++i) {
            for (let j = 0; j < squares.length; ++j) {
                if (squares[i][j] === null) { continue; }
                squares[i][j].x = j * ProjectStyles.sizeSquare
                squares[i][j].y = i * ProjectStyles.sizeSquare
            }
        }
    }

    // Проверяет возможность шага и делает шаг при необходимости.
    // На входе принимает точку клика.
    // Возвращает true если шаг доступен.
    function gameStep(stepPoint) {
        let nullPoint = findFreePosition();
        if (!isNeighbour(nullPoint, stepPoint)) {
            console.log('Шаг не возможен');
            return false;
        }
        squares[nullPoint.y][nullPoint.x] = squares[stepPoint.y][stepPoint.x];
        squares[stepPoint.y][stepPoint.x] = null;
        updateSquaresPositions();
    }

    // Инициализирует начальное положение клеток по порядку.
    function initGameDemo(size) {
        ProjectStyles.columnRowCount = size;
        let k = randomSquareNumber(size);
        for (let j = 0; j < size; ++j) {
            squares.push([]);
            for (let i = 0; i < size; ++i) {
                let sq = squareComponent.incubateObject(root, {
                                                            squareNumber: k
                                                        }, Qt.Synchronous);
                squares[j].push(sq.object)
                ++k;
                if (k === size * size) {
                    squares[j].push(null)
                    break
                }
            }
        }
        updateSquaresPositions();
    }

    // Выдает рандомные числа в диапазоне размернсти игры -1
    function randomSquareNumber (n) {
        return parseInt(Math.random() * n)
    }

    Component {
        id: squareComponent
        Square {}
    }

    Rectangle {
        id: gameArea

        implicitWidth: ProjectStyles.gameSide
        implicitHeight: ProjectStyles.gameSide

        MouseArea {
            id: ma

            anchors.fill: gameArea

            onClicked: {
                let r = parseInt(mouseY / ProjectStyles.sizeSquare);
                let c = parseInt(mouseX / ProjectStyles.sizeSquare);
                root.gameStep(Qt.point(c, r));
            }
        }
    }
}
