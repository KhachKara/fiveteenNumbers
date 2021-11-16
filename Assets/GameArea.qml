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
    function isNeighbour(a, b) {
        if (a.x === b.x) {
            return Math.abs(a.y - b.y) === 1;
        }
        if (a.y === b.y) {
            return Math.abs(a.x - b.x) === 1;
        }
        return false;
    }

    function updateOneSquarePositions(square, row, column) {
        squares[row][column].x = column * ProjectStyles.sizeSquare
        squares[row][column].y = row * ProjectStyles.sizeSquare
    }

    // Обновление позиций квадратов в соотвествии с матрицей.
    function updateSquaresPositions() {
        for (let i = 0; i < squares.length; ++i) {
            for (let j = 0; j < squares.length; ++j) {
                updateOneSquarePositions(squares[i][j], i, j);
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
        // swap
        [squares[nullPoint.y][nullPoint.x], squares[stepPoint.y][stepPoint.x]] = [
          squares[stepPoint.y][stepPoint.x], squares[nullPoint.y][nullPoint.x]];
        updateOneSquarePositions(squares[nullPoint.y][nullPoint.x], nullPoint.y, nullPoint.x);
        updateOneSquarePositions(squares[stepPoint.y][stepPoint.x], stepPoint.y, stepPoint.x);
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
        ProjectStyles.columnRowCount = size
        for (let j = 0; j < size; ++j) {
            squares.push([]);
            for (let i = 0; i < size; ++i) {
                let sq = squareComponent.incubateObject(root, {
                                                            number: array[j * size + i]
                                                        }, Qt.Synchronous);
                squares[j].push(sq.object);
            }
        }
        updateSquaresPositions();
    }

    // Инициализирует начальное положение клеток по порядку.
    function initGameDemo(size) {
        let array = iota(Array(size * size), 1);
        array[array.length - 1] = 0;
        initGameArray(array);
    }

    // Инициализация игры с размешанными клетками.
    function initGameRandom(size) {
        // Эту строку можно разбить на 3 строки, что бы было понятнее.
        let randomArray = shuffle(iota(Array(size * size)));
        initGameArray(randomArray);
    }

    // *****************************************************
    // Выдает рандомные числа в диапазоне размернсти игры
    function makeNumbersList(size) {
        let numbers = []
        for (let i = 1; i <= size * size; ++i) {
            numbers.push(i);
        }
        return numbers
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
