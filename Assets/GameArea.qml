import QtQuick 2.0

Item {
    Component {
        id: squareComponent

        Square {}
    }

    function findFreePosition () {
        if (gameArea.squares[i][j] === null) {
            return console.log(Qt.point(i, j))
        }
    }

    Rectangle {
        id: gameArea

        implicitWidth: parent.width
        implicitHeight: parent.height

        property int rowQuantity: ProjectStyles.columnRow
        property var squares: []

        Component.onCompleted: {
                    console.log('squareComponent.status', squareComponent.status)
                    let k = 1
                    for (let j = 0; j < rowQuantity; ++j) {
                        gameArea.squares.push([]);
                        for (let i = 0; i < rowQuantity; ++i) {
                            let sq = squareComponent.incubateObject(root, {
                                                                        x: i * ProjectStyles.gameSide / ProjectStyles.columnRow,
                                                                        y: j * ProjectStyles.gameSide / ProjectStyles.columnRow,
                                                                        squareNumber: k
                                                                    });
                            gameArea.squares[j].push(sq)
                            findFreePosition()
                            k = k + 1;
                            if (k === ProjectStyles.columnRow * ProjectStyles.columnRow) {
                                gameArea.squares[j].push(null)
                                break
                            }
                        }
                    }
                    findFreePosition()
                    console.log(squares)
                }
    }
//    MouseArea {
//        id: ma
//        anchors.fill: gameArea
//        signal selectRect(int row, int col)
//        onClicked: {
//            let r = parseInt(mouseY / 100);
//            let c = parseInt(mouseX / 100);
//            ma.selectRect(r, c);

//            console.log(r, c)
//        }
//    }
}
