import QtQuick 2.0
import QtQuick.Controls 2.5

Item {
    id: root

    signal startGameClicked(int size)
    property alias topM: col.anchors.topMargin

    Rectangle {
        id: newGamePage

        anchors.fill: parent
        color: "#4B4453"

        Column {
            id: col
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                topMargin: 100
            }
            spacing: 8
            Repeater {
                model: 3
                GameStyleRect {
                    id: gameStyle

                    width: 140

                    gameSize: index + 2
                    txtGameMode: gameSize + "x" + gameSize

                    CursorShapeMouseArea {
                        anchors.fill: parent
                        onClicked: {
                            root.startGameClicked(gameStyle.gameSize)
                        }
                    }
                }
            }
        }
    }
}
