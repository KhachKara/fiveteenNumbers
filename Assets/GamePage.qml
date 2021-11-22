import QtQuick 2.0
import QtQuick.Controls 2.5
import Common 43.21

Item {
    id: root

    implicitWidth: gamePage.implicitWidth
    implicitHeight: gamePage.implicitHeight

    function startGame(size) {
        gameArea.initGame(size);
    }

    function startGameArray(array) {
        gameArea.initGameArray(array);
    }


    Rectangle {
        id: gamePage

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
                    newGamePage.visible = true
                }
            }
        }

        Text {
            id: txtNewGame
            text: qsTr("Home")
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
                    welcomePage.visible = true
                }
            }

        }

        GameArea {
            id: gameArea

            anchors {
                fill: parent
                leftMargin: 30
                rightMargin: 30
                topMargin: 259
                bottomMargin: 81
            }
        }
    }
}
