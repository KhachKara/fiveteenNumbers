import QtQuick 2.2
import QtQuick.Controls 2.15

Rectangle {
    id: root

    property int steps: 0
    property string time: ""

    signal continueClicked()
    signal rateClicked()

    property alias topY: youWinTxt.anchors.topMargin
    property alias topS: scoreBoard.anchors.topMargin

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

        steps: root.steps
        time: root.time

        anchors {
            horizontalCenter: parent.horizontalCenter
            top: youWinTxt.bottom
            topMargin: 26
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
        CursorShapeMouseArea {
            anchors.fill: parent

            onClicked: {
                continueClicked()
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
            CursorShapeMouseArea {
                anchors.fill: parent

                onClicked: {
                    rateClicked()
                }
            }
        }
    }
}
