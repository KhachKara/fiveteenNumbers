import QtQuick 2.0
import QtQuick.Controls 2.5


Rectangle {
    id: gameMode

    property int gameSize: 3
    property int spacingMargin: 6
    property alias txtGameMode: txtGameMode.text


    height: width
    color: "#845EC2"
    radius: 8

    Column {
        id: col
        anchors {
            centerIn: parent
        }
        spacing: spacingMargin
        Repeater {
            model: gameSize
            Row {
                anchors {
                    horizontalCenter: parent.horizontalCenter
                }
                spacing: spacingMargin
                Repeater {
                    model: gameSize
                    Rectangle {
                        id: rectGameMode

                        width: (gameMode.width - (gameSize + 1) * spacingMargin) / gameSize
                        height: width
                        color: "#20ffffff"
                        radius: 2
                    }
                }
            }
        }
    }

    Text {
        id: txtGameMode

        anchors.centerIn: parent
        color: "#FFFFFF"
        font {
            family: "Ubuntu"
            pixelSize: 30
        }
    }
}
