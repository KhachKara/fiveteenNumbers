import QtQuick 2.12
import QtQuick.Controls 2.12

Item  {
    id: root

    signal newGameClicked()
    signal rateClicked()
    signal settingsClicked()
    signal quitClicked()
    signal logoClicked()

    ListModel {
        id: listModel
        ListElement {
            text: "New game"
        }
        ListElement {
            text: "Rate"
        }
        ListElement {
            text: "Settings"
        }
        ListElement {
            text: "Quit"
        }
    }

    Image {
        id: logoImage
        anchors {
            horizontalCenter: root.horizontalCenter
            top: parent.top
            topMargin: -70
        }

        source: "qrc:/Assets/icons/logo.svg"

        CursorShapeMouseArea {
            anchors.fill: parent

            onClicked: {
                logoClicked()
            }
        }
    }

    ListView {
        id: listView

        anchors {
            top: logoImage.bottom
            topMargin: 50
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        clip: true

        spacing: 12
        ScrollBar.vertical: ScrollBar{}


        model: listModel
        delegate: Rectangle {
            id: rectButton

            anchors.horizontalCenter: parent ? parent.horizontalCenter : undefined
            width: 300
            height: 70
            color: "#845EC2"
            radius: 8
            Text {
                anchors.centerIn: parent
                text: model.text
                color: "#ffffff"
                font {
                    family: "Ubuntu"
                    pixelSize: 32
                }
            }
            CursorShapeMouseArea {
                anchors.fill: parent

                onClicked: {
                    if(text === "New game") {
                        newGameClicked()
                    }
                    if(text === "Rate") {
                        rateClicked()
                    }
                    if(text === "Settings") {
                        settingsClicked()
                    }
                    if(text === "Quit") {
                        quitClicked()
                    }
                }
            }
        }
    }
}


