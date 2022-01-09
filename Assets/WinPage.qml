import QtQuick 2.2
import QtQuick.Controls 2.2

Rectangle {
    id: root

    property int steps: 0
    property string time: ""

    signal continueClicked()
    signal rateMeClicked()

    component MyButton: Rectangle {
        id: mBtn
        property alias text: txt.text
        property alias textColor: txt.color
        signal clicked()

        height: 71
        radius: 8

        Text {
            id: txt

            anchors.centerIn: parent
            font {
                family: "Ubuntu"
                pixelSize: 32
            }
        }
        CursorShapeMouseArea {
            anchors.fill: parent

            onClicked: {
                mBtn.clicked()
            }
        }
    }

    color: "#1b0a37"
    opacity: 0.8
    MouseArea {
        anchors.fill: parent // Не позволяет прожимать сквозь "заклятие"
    }
    Rectangle {
        id: popupRect
        anchors {
            bottom: parent.bottom
            left: parent.left
            right: parent.right
            margins: 30
        }
        radius: 15
        height: contentColumn.height
        Column {
            id: contentColumn
            width: parent.width
            Item { width: 10; height: 36 }
            Text {
                id: youWinTxt
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("You'r win!")
                color: "#845EC2"
                font {
                    family: "Ubuntu"
                    bold: true
                    pixelSize: 32
                }
            }
            Item { width: 10; height: 26 }
            ScoreBoard {
                id: scoreBoard
                anchors.horizontalCenter: parent.horizontalCenter
                steps: root.steps
                time: root.time
            }
            Item { width: 10; height: 26 }
            MyButton {
                id: continueBtn
                anchors {
                    left: parent.left
                    right: parent.right
                    leftMargin: 30
                    rightMargin: 30
                }
                color: "#845EC2"
                text: qsTr("Continue")
                textColor: "#FFFFFF"
                onClicked: {
                    root.visible = false;
                    continueClicked();
                }
            }
            Item { width: 1; height: 12 }
            MyButton {
                id: rateBtn
                anchors {
                    left: parent.left
                    right: parent.right
                    leftMargin: 30
                    rightMargin: 30
                }
                border {
                    width: 3
                    color: "#845EC2"
                }
                text: qsTr("Rate your game")
                textColor: "#845EC2"
                onClicked: {
                    root.visible = false;
                    rateMeClicked();
                }
            }
            Item { width: 1; height: 36 }
        }
    }
}
