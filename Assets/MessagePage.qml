import QtQuick 2.0

Item {
    id: root

    signal closeButtonClicked()
    property alias text: messageTxt.text

    Rectangle {
        id: messageRect

        anchors.fill: parent
        radius: 8

        color: "grey"

        Image {
            id: warning
            source: "qrc:/Assets/icons/warning.svg"
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                topMargin: 20
            }
        }

        Text {
            id: messageTxt

            anchors {
                horizontalCenter: parent.horizontalCenter
                top: warning.bottom
                topMargin: 20
            }
            font {
                family: "Ubuntu"
                pixelSize: 24
            }
        }

        Rectangle {
            id: msgButton
            width: 100
            height: 30
            radius: 8
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: messageTxt.bottom
                topMargin: 20
            }

            Text {
                id: close

                anchors.centerIn: parent
                text: qsTr("Close")
                font {
                    family: "Ubuntu"
                    pixelSize: 18
                }
            }
            CursorShapeMouseArea {
                anchors.fill: parent

                onClicked: {
                    closeButtonClicked();
                }
            }
        }
    }
}
