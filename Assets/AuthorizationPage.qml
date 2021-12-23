import QtQuick 2.0

Item {
    id: root

    property alias nickname: nickNameInp.text
    property alias password: passwInp.text

    Rectangle {
        id: authorBgRect

        width: parent.width
        height: 200
        radius: 8
        anchors.centerIn: parent
        color: "yellow"

        Text {
            id: authorTxt

            text: qsTr("Authorization")
            font {
                family: "Ubuntu"
                pixelSize: 32
            }

            anchors {
                top: parent.top
                left: parent.left
                margins: 20
            }
        }

        Rectangle {
            id: nickNameRect

            height: 40
            radius: 8
            anchors {
                top: authorTxt.bottom
                left: parent.left
                right: parent.right
                margins: 20
            }

            TextInput {
                id: nickNameInp

                color: "#b0a8b9"
                anchors {
                    fill: parent
                    left: parent.left
                    leftMargin: 10
                }

                verticalAlignment: TextInput.AlignVCenter
                text: "nickname"
                property int k: 0
                onFocusChanged: {
                    if(k === 0) {
                        text = ""
                        ++k
                    }
                    color = "#000000"
                }
                font {
                    family: "Ubuntu"
                    pixelSize: 18
                }
            }
            Image {
                id: enterIcon
                source: "qrc:/Assets/icons/enter_icon_gray.svg"
                z: 1
                anchors {
                    verticalCenter: parent.verticalCenter
                    right: parent.right
                    rightMargin: 10
                }

                CursorShapeMouseArea {
                    anchors.fill: parent
                    onClicked: {
                        authorizationPage.visible = false
                    }
                }
            }
        }
        Rectangle {
            id: passwRect

            height: 40
            radius: 8
            anchors {
                top: nickNameRect.bottom
                left: parent.left
                right: parent.right
                margins: 20
            }          

            TextInput {
                id: passwInp

                color: "#b0a8b9"
                anchors {
                    fill: parent
                    left: parent.left
                    leftMargin: 10
                }

                echoMode: TextInput.Normal

                verticalAlignment: TextInput.AlignVCenter
                text: "password"
                property int k: 0
                onFocusChanged: {
                    if(k === 0) {
                        text = ""
                        passwInp.echoMode = "Password"
                        ++k
                    }
                    color = "#000000"
                }
                font {
                    family: "Ubuntu"
                    pixelSize: 18
                }
            }           
            Image {
                id: eyeIcon
                source: "qrc:/Assets/icons/eye_hide.svg"
                z: 1
                anchors {
                    verticalCenter: parent.verticalCenter
                    right: parent.right
                    rightMargin: 10
                }

                CursorShapeMouseArea {
                    anchors.fill: parent
                    property int k: 1
                    onClicked: {
                        if(k > 0) {
                            eyeIcon.source = "qrc:/Assets/icons/eye_show.svg"
                            passwInp.echoMode = TextInput.Normal
                            k = k * (-1)
                        } else {
                            eyeIcon.source = "qrc:/Assets/icons/eye_hide.svg"
                            passwInp.echoMode = TextInput.Password
                            k = k * (-1)
                        }
                    }
                }
            }
        }
    }
}
