import QtQuick 2.2

Item {
    id: root

    Rectangle {
        id: soundRect

        width: parent.width
        height: 24
        color: Qt.rgba(0,0,0,0)
        Text {
            id: soundTxt

            color: "#B0A8B9"
            text: qsTr("Sound")
            font {
                family: "Ubuntu"
                pixelSize: 20
            }
            anchors.verticalCenter: soundRect.verticalCenter
        }
        Image {
            id: soundCheckbox

            property int k: 1

            source: if(soundCheckbox.k > 0) {
             "qrc:/Assets/icons/EMPTY_checkbox.svg"}
            else {"qrc:/Assets/icons/CHECKED_checkbox.svg"}
            anchors {
                verticalCenter: parent.verticalCenter
                right: parent.right
            }

            CursorShapeMouseArea {
                anchors.fill: parent
                onClicked: {
                    soundCheckbox.k =  soundCheckbox.k * (-1)
                }
            }
        }
    }

    Rectangle {
        id: musicRect

        anchors {
            top: soundRect.bottom
            topMargin: 24
        }
        width: parent.width
        height: 24
        color: Qt.rgba(0,0,0,0)
        Text {
            id: musicTxt

            color: "#B0A8B9"
            text: qsTr("Music")
            font {
                family: "Ubuntu"
                pixelSize: 20
            }
            anchors.verticalCenter: musicRect.verticalCenter
        }
        Image {
            id: musicCheckbox

            property int k: 1

            source: if(musicCheckbox.k > 0) {
                        "qrc:/Assets/icons/EMPTY_checkbox.svg"}
                       else {"qrc:/Assets/icons/CHECKED_checkbox.svg"}
            anchors {
                verticalCenter: parent.verticalCenter
                right: parent.right
            }

            CursorShapeMouseArea {
                anchors.fill: parent
                onClicked: {
                    musicCheckbox.k =  musicCheckbox.k * (-1)
                }
            }
        }
    }
}
