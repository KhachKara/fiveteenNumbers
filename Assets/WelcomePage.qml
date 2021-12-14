import QtQuick 2.0

Item {
    id: root

    signal logoClicked()

    signal newGameClicked()
    signal rateClicked()
    signal settingsClicked()
    signal quitClicked()

    property int topMargin: 50

    Image {
        id: logo

        source: "./icons/logo.svg"
        sourceSize.width: 113
        sourceSize.height: 127
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: topMargin
        }

        CursorShapeMouseArea {
            anchors.fill: parent

            onClicked: {
                root.logoClicked()
            }

        }
    }

    Column {
        spacing: 11
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: logo.bottom
            topMargin: topMargin
        }
        Repeater {
            id: rep

            readonly property var signalsButton: [root.newGameClicked, root.rateClicked,
                                                  root.settingsClicked, root.quitClicked]

            model: ["New game", "Rate", "Settings", "Quit"]
            Rectangle {
                id: rectButton
                width: 300
                height: 70
                color: "#845EC2"
                radius: 8
                Text {
                    id: rectText
                    anchors.centerIn: parent
                    color: "#FFFFFF"
                    text: modelData
                    font {
                        family: "Ubuntu"
                        pixelSize: 32
                    }
                }

                CursorShapeMouseArea {
                    anchors.fill: parent

                    onClicked: {
                        rep.signalsButton[index]();
                    }
                }
            }
        }
    }
}
