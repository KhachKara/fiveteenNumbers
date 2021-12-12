import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

Item {
    id: root

    signal sendClicked()

    property alias nickName: nameInp.text
    property alias e_mail: e_mailInp.text
    property alias message: messageArea.text

    Rectangle {
        id: feedbackRect

        anchors.fill: parent
        radius: 8

        color: "#b0a8b9"
        Text {
            id: feedBackTxt
            text: qsTr("Feedback")

            color: "#ffffff"

            anchors {
                top: parent.top
                left: parent.left
                topMargin: 20
                leftMargin: 30
            }

            font {
                family: "Ubuntu"
                pixelSize: 32
            }
        }

        Rectangle {
            id: name

            width: 200
            height: 30
            radius: 8

            anchors {
                top: feedBackTxt.bottom
                left: parent.left
                right: parent.right
                topMargin: 20
                leftMargin: 30
                rightMargin: 30
            }

            TextInput {
                id: nameInp

                color: "#b0a8b9"
                anchors {
                    fill: parent
                    left: parent.left
                    leftMargin: 10
                }
                verticalAlignment: TextInput.AlignVCenter
                text: "name"

                property int k: 0
                onFocusChanged: {
                    if(k === 0) {
                        text = ""
                        ++k
                    }
                    color = "#000000"
                }
            }
        }

        Rectangle {
            id: e_mail

            width: 200
            height: 30
            radius: 8

            anchors {
                top: name.bottom
                left: parent.left
                right: parent.right
                topMargin: 10
                leftMargin: 30
                rightMargin: 30
            }

            TextInput {
                id: e_mailInp

                color: "#b0a8b9"
                anchors {
                    fill: parent
                    left: parent.left
                    leftMargin: 10
                }
                verticalAlignment: TextInput.AlignVCenter
                text: "e-mail"

                property int k: 0
                onFocusChanged: {
                    if(k === 0) {
                        text = ""
                        ++k
                    }
                    color = "#000000"
                }
            }
        }

        Rectangle {
            id: message

            width: 200
            height: 100
            radius: 8

            anchors {
                top: e_mail.bottom
                bottom: parent.bottom
                left: parent.left
                right: parent.right
                topMargin: 10
                leftMargin: 30
                rightMargin: 30
                bottomMargin: 50
            }
            ScrollView {
                anchors.fill: parent
                TextArea {
                    id: messageArea

                    placeholderTextColor: "#b0a8b9"
                    anchors {
                        fill: parent
                    }
                    placeholderText: "messagge"
                }
                onFocusChanged: {
                    messageArea.placeholderText = ""
                    messageArea.color = "#000000"
                }
            }
        }

        Rectangle {
            id: sendBtn

            width: 100
            height: 30

            radius: 8

            color: "#4B4453"

            anchors {
                top: message.bottom
                horizontalCenter: parent.horizontalCenter
                topMargin: 10
            }

            Text {
                id: sendBtnTxt
                text: qsTr("Send")
                anchors.centerIn: parent

                color: "#ffffff"

                font {
                    family: "Ubuntu"
                    pixelSize: 18
                }
            }
            CursorShapeMouseArea {
                anchors.fill: parent

                onClicked: {
                    root.sendClicked()
                    messageBoxRect.visible = true
                }
            }
        }
        Rectangle {
            id: messageBoxRect

            visible: false
            height: 80
            color: "#4B4453"
            anchors {
                verticalCenter: feedbackRect.verticalCenter
                left: feedbackRect.left
                right: feedbackRect.right
                leftMargin: 30
                rightMargin: 30
            }
            radius: 8

            Text {
                id: messageBoxTxt
                text: "Your mesage was\nsuccessfuly sent"
                color: "#b0a8b9"
                anchors.centerIn: parent
                font {
                    family: "Ubuntu"
                    pixelSize: 18
                }
            }
            Image {
                id: close
                source: "./icons/close.svg"
                anchors {
                    top: parent.top
                    right: parent.right
                    topMargin: 10
                    rightMargin: 10
                }
                CursorShapeMouseArea {
                    anchors.fill: parent
                    onClicked: {
                        messageBoxRect.visible = false
                        nameInp.text = ""
                        e_mailInp.text = ""
                        messageArea.text = ""
                    }
                }
            }
        }
    }
}
