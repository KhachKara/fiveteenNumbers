import Common 43.21
import QtQuick 2.2

Rectangle {
    id: winPage

    visible: false

    opacity: 0.8

    radius: 15
    color: "#FFFFFF"

    Text {
        id: youWin

        text: qsTr("You'r win!")
        color: "#845EC2"
        font {
            family: "Ubuntu"
            bold: true
            pixelSize: 32
        }

        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: 36
        }
    }

    ScoreBoard {
        id: scoreBoard

        anchors {
            horizontalCenter: winPage.horizontalCenter
            top: youWin.bottom
            topMargin: 31

        }
    }

    Rectangle {
        id: continueBtn

        height: 51

        radius: 8
        color: "#845EC2"

        anchors {
            top: scoreBoard.bottom
            left: parent.left
            right: parent.right
            leftMargin: 30
            rightMargin: 30
            topMargin: 20
        }

        Text {
            id: contiueTxt

            text: qsTr("Continue")
            color: "#FFFFFF"
            font {
                family: "Ubuntu"
                pixelSize: 32
            }

            anchors.centerIn: parent
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
                winPage.visible = false
                newGamePage.visible = true
                gameArea.enabled = true
                txtTimeValue.text = "00:00"
            }
        }
    }

    Rectangle {
        id: rateBtn

        height: 51

        radius: 8
        color: "#845EC2"

        anchors {
            top: continueBtn.bottom
            left: parent.left
            right: parent.right
            leftMargin: 30
            rightMargin: 30
            topMargin: 10
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
                ratePage.visible = true
            }
        }

        Rectangle {
            radius: 5
            color: "#FFFFFF"
            anchors {
                fill: parent
                margins: 3
            }

            Text {
                text: qsTr("Rate")
                font {
                    family: "Ubuntu"
                    pixelSize: 32
                }
                anchors.centerIn: parent
            }
        }
    }

    Rectangle {
        id: quitBtn

        height: 51

        radius: 8
        color: "#845EC2"

        anchors {
            top: rateBtn.bottom
            left: parent.left
            right: parent.right
            leftMargin: 30
            rightMargin: 30
            topMargin: 10
        }

        Text {
            text: qsTr("Quit")
            color: "#FFFFFF"
            font {
                family: "Ubuntu"
                pixelSize: 32
            }
            anchors.centerIn: parent
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
}
