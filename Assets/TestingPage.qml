import QtQuick 2.0
import QtQuick.Controls 2.2

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

                anchors.fill: parent
                verticalAlignment: TextInput.AlignVCenter
                anchors.leftMargin: 30
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
                verticalAlignment: TextInput.AlignVCenter
                anchors.leftMargin: 30
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
                verticalAlignment: TextInput.AlignVCenter
                anchors.leftMargin: 30
                font {
                    family: "Ubuntu"
                    pixelSize: 32
                }
            }
        }
        Button {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Push me"
            font {
                family: "Ubuntu"
                pixelSize: 32
            }

            onClicked: {
                console.log(core.registerPlayer(login.text, password.text, e_mail.text))
            }
        }
    }
}
