import QtQuick 2.0

Item {
    Component {
        id: squareComponent

        Square {}
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
                for (let i = 0; i < rowQuantity; ++i) {
                    let sq = squareComponent.incubateObject(root, {
                                                                x: i * ProjectStyles.gameSide / ProjectStyles.columnRow,
                                                                y: j * ProjectStyles.gameSide / ProjectStyles.columnRow,
                                                                squareNumber: k
                                                            });
                    gameArea.squares.push(sq)
                    k = k + 1;
                    if (k === ProjectStyles.columnRow * ProjectStyles.columnRow) {
                        break
                    }
                }
            }
        }
    }
}
