import QtQuick 2.0
import QtQuick.Controls 2.5

Item {
    id: root

    signal logoClicked()

    signal newGameClicked()
    signal rateClicked()
    signal settingsClicked()
    signal quitClicked()



    ListView {
        id: listView

        anchors.fill: parent
        spacing: 12
        ScrollBar.vertical: ScrollBar{}
        model: listModel
        delegate: Rectangle {
            id: rectButton

            anchors.horizontalCenter: parent.horizontalCenter

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

                }
            }
        }
    }
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
}
