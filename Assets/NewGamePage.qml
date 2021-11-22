import QtQuick 2.0
import QtQuick.Controls 2.5
import Common 43.21

Item {
    id: root

    implicitWidth: newGamePage.implicitWidth
    implicitHeight: newGamePage.implicitHeight

    GamePage {
        id: gamePage
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
                }
            }
        }

        Row {
            id: firstRow
            spacing: 10

            anchors {
                horizontalCenter: parent.horizontalCenter
                top: gameStyle3X3.bottom
                topMargin: 8
            }
            GameStyleRect {
                id: gameStyle4X4

                gameSize: 4
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
                }
            }

            GameStyleRect {
                id: gameStyle5X5

                gameSize: 5
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
                }
            }
        }

        Row {
            id: secondRow

            anchors {
                horizontalCenter: parent.horizontalCenter
                top: firstRow.bottom
                topMargin: 10
            }

            spacing: 11

            anchors {
                horizontalCenter: parent.horizontalCenter
                top: gameStyle3X3.bottom
                topMargin: 10
            }
            GameStyleRect {
                id: gameStyle6X6

                gameSize: 6
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
                }
            }

            GameStyleRect {
                id: gameStyle7X7

                gameSize: 7
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
                }
            }
        }
    }

}
