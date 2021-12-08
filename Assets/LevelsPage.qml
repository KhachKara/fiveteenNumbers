import QtQuick 2.0
import QtQuick.Controls 2.5

Item {
    id: root

    signal gameStyleClicked()

    anchors.fill: parent

    Rectangle {
        id: newGamePage

        anchors.fill: parent
        color: "#4B4453"


        Column {
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

                    gameSize: index + 3
                    txtGameMode: gameSize + "x" + gameSize

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true

                        onEntered: {
                            cursorShape = Qt.PointingHandCursor
                        }

                        onExited: {
                            cursorShape = Qt.ArrowCursor
                        }
                        onClicked: {
                            gamePage.startGame(gameStyle.gameSize)
                            gamePage.gameSize = gameStyle.gameSize
                            gamePage.visible = true
                        }
                    }
                }
            }
        }
    }
}
