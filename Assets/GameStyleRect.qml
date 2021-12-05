import QtQuick 2.0
import QtQuick.Controls 2.5


Rectangle {
    id: gameMode

    property int gameSize: 3
    property int spacingMargin: 6
    property alias txtGameMode: txtGameMode.text


    width: 140
    height: width
    color: "#845EC2"
    radius: 8

    Column {
        id: col
        spacing: spacingMargin
        anchors {
            centerIn: parent
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

        color: "#FFFFFF"
        font {
            family: "Ubuntu"
            pixelSize: 30
        }
        anchors.centerIn: parent
    }
}
