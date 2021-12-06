import QtQuick 2.0

Item {
    id: root

    implicitWidth: aboutPage.implicitWidth
    implicitHeight: aboutPage.implicitHeight

    Rectangle {
        id: aboutPage

        anchors.fill: parent

        Column {
            anchors {
                top: parent.top
                left: parent.left
                topMargin: 87
                leftMargin: 30
            }
            spacing: 5
            Text {
                id: design
                text: qsTr("design")

                font {
                    family: "Ubuntu"
                    pixelSize: 22
                }
            }
            Text {
                id: backend
                text: qsTr("backend")

                font {
                    family: "Ubuntu"
                    pixelSize: 22
                }
            }
            Text {
                id: frontend
                text: qsTr("frontend")

                font {
                    family: "Ubuntu"
                    pixelSize: 22
                }
            }
        }
    }
}
