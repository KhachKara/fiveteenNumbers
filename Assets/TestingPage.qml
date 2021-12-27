import QtQuick 2.0

Item {

    Column {
        anchors.centerIn: parent
        spacing: 20

        Rectangle {
            width: 400
            height: 100
            color: "#f0f8ff"
            TextInput {
                id: login
                font {
                    family: "Ubuntu"
                    pixelSize: 32
                }
            }
        }
        Rectangle {
            width: 400
            height: 100
            color: "#faebd7"
            TextInput {
                id: password

                anchors.fill: parent
                font {
                    family: "Ubuntu"
                    pixelSize: 32
                }
            }
        }
        Rectangle {
            width: 400
            height: 100
            color: "#00ffff"
            TextInput {
                id: e_mail

                anchors.fill: parent
                font {
                    family: "Ubuntu"
                    pixelSize: 32
                }
            }
        }
    }
}
