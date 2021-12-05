import QtQuick 2.0
import QtQuick.Controls 2.5
import Common 43.21

Item {
    id: root

    implicitWidth: newGamePage.implicitWidth
    implicitHeight: newGamePage.implicitHeight

    GamePage {
        id: gamePage
        anchors.fill: parent
        visible: true
    }

    Rectangle {
        id: newGamePage

        anchors.fill: parent
        color: "#4B4453"

        Image {
            id: back
            source: "./icons/back.svg"
            anchors {
                left: parent.left
                leftMargin: 30
                verticalCenter: txtNewGame.verticalCenter
            }
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
                    console.log("back")
                    welcomePage.visible = true
                    visible = false
                }
            }
        }

        Image {
            id: exit
            source: "./icons/exit.svg"
            anchors {
                top: parent.top
                right: parent.right
                rightMargin: 30
                topMargin: 32
            }
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
                    Qt.quit()
                }
            }
        }

        Text {
            id: txtNewGame
            text: qsTr("New game")
            color: "#B0A8B9"
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                topMargin: 32
            }
            font {
                family: "Ubuntu"
                pixelSize: 22
            }
        }

        // 3x3
        GameStyleRect {
            id: gameStyle3X3

            gameSize: 3
            txtGameMode: gameSize + "x" + gameSize

            anchors {
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                topMargin: 100
            }
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
                    gamePage.visible = true
                    newGamePage.visible = false
                    gamePage.startGame(gameStyle3X3.gameSize)
                    gamePage.gameSize = gameStyle3X3.gameSize
                }
            }
        }

        // 4x4
        GameStyleRect {
            id: gameStyle4X4

            gameSize: 4
            txtGameMode: gameSize + "x" + gameSize

            anchors {
                horizontalCenter: parent.horizontalCenter
                top: gameStyle3X3.bottom
                topMargin: 8
            }

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
                    gamePage.visible = true
                    newGamePage.visible = false
                    gamePage.startGame(gameStyle4X4.gameSize)
                    gamePage.gameSize = gameStyle4X4.gameSize
                }
            }
        }

        // 4x4
        GameStyleRect {
            id: gameStyle5X5

            gameSize: 5
            txtGameMode: gameSize + "x" + gameSize

            anchors {
                horizontalCenter: parent.horizontalCenter
                top: gameStyle4X4.bottom
                topMargin: 8
            }

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
                    gamePage.visible = true
                    newGamePage.visible = false
                    gamePage.startGame(gameStyle5X5.gameSize)
                    gamePage.gameSize = gameStyle5X5.gameSize
                }
            }
        }
    }
}
