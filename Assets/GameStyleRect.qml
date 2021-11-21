import QtQuick 2.0
import QtQuick.Controls 2.5
import Common 43.21


Rectangle {
    property int gameSize: 3
    property int spacingMargin: 2
    property alias txtGameMode: txtGameMode.text

    id: gameMode
    width: 128
    height: width
    color: "#845EC2"

    Column {
        spacing: spacingMargin
        anchors {
            verticalCenter: parent.verticalCenter
        }
        Repeater {
            model: gameSize
            Row {
                spacing: spacingMargin
                anchors {
                    horizontalCenter: parent.horizontalCenter
                }
                Repeater {
                    model: gameSize
                    Rectangle {
                        id: rectGameMode
                        width: (gameMode.width - gameSize * spacingMargin) / gameSize
                        height: width
                        color: "#B0A8B9"
                    }
                }
            }
        }
    }

    Text {
        id: txtGameMode

        color: "#FFFFFF"
        font {
            family: "Ubuntu"
            pixelSize: 30
        }
        anchors.centerIn: parent

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true

            onEntered: {
                txtGameMode.color = "#8400C2"
                cursorShape = Qt.PointingHandCursor
            }

            onExited: {
                txtGameMode.color = "#FFFFFF"
                cursorShape = Qt.ArrowCursor
            }
        }
    }
}
