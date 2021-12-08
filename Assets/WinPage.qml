import QtQuick 2.2

Rectangle {
    id: winPage

    property alias steps: scoreBoard.steps
    property alias time: scoreBoard.time

    radius: 15
    color: "#FFFFFF"

    Text {
        id: youWinTxt

        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: 36
        }
        text: qsTr("You'r win!")
        color: "#845EC2"
        font {
            family: "Ubuntu"
            bold: true
            pixelSize: 32
        }

    }

    ScoreBoard {
        id: scoreBoard

        anchors {
            horizontalCenter: winPage.horizontalCenter
            top: youWinTxt.bottom
            topMargin: 31
        }
    }

    Rectangle {
        id: continueBtn

        anchors {
            top: scoreBoard.bottom
            left: parent.left
            right: parent.right
            leftMargin: 30
            rightMargin: 30
            topMargin: 26
        }
        height: 71
        radius: 8
        color: "#845EC2"

        Text {
            id: contiueTxt

            anchors.centerIn: parent
            text: qsTr("Continue")
            color: "#FFFFFF"
            font {
                family: "Ubuntu"
                pixelSize: 32
            }

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

            }
        }
    }

    Rectangle {
        id: rateBtn

        height: 71

        radius: 8
        color: "#845EC2"

        anchors {
            top: continueBtn.bottom
            left: parent.left
            right: parent.right
            leftMargin: 30
            rightMargin: 30
            topMargin: 12
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

                }
            }
        }
    }
}
