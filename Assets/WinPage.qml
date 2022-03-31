import QtQuick 2.2
import QtQuick.Controls 2.2

Item {
    id: root

    property var gameObj

    signal continueClicked()

    function showWinPage() {
        scoreBoard.updateScore(gameObj.areaSize,
                               gameObj.steps,
                               gameObj.time);
        visible = true;
    }

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
                mBtn.clicked();
            }
        }
    }

    MouseArea {
        anchors.fill: parent // Не позволяет прожимать сквозь "заклятие"
    }
    Rectangle {
        anchors.fill: parent
        color: "#1b0a37"
        opacity: 0.8
    }
    Rectangle {
        id: popupRect
        anchors {
            bottom: parent.bottom
            left: parent.left
            right: parent.right
            margins: 30
            bottomMargin: 60
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
            Item { width: 1; height: 36 }
        }
    }
}
