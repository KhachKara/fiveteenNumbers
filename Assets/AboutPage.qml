import QtQuick 2.2
import QtQuick.Controls 2.5
import "./js/variables.js" as Variables

Item {
    id: root

    signal sendClicked()
    signal messageCloseClicked()

    property alias nickName: nameInp.text
    property alias e_mail: e_mailInp
    property alias message: messageArea.text
    property alias messageBoxTxt: messageBoxTxt.text
    property alias messageBox: messageBoxRect

    readonly property string correctFill: "Feel the form correctly"
    readonly property string success: "Your mesage was\nsuccessfuly sent"

    states: [
        State {
            id: stateEmpty
            name: "getEmpty"
            PropertyChanges {
                target: nameInp
                color: "#b0a8b9"
                text: "name"
            }
            PropertyChanges {
                target: e_mailInp
                color: "#b0a8b9"
                text: "e-mail"
            }
            PropertyChanges {
                target: messageArea
                color: "#b0a8b9"
                text: "message"
            }
        }
    ]

    Rectangle {
        id: feedbackRect

        anchors.fill: parent
        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
            topMargin: 80
            leftMargin: 30
            rightMargin: 30
            bottomMargin: 200
        }
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
                font {
                    family: "Ubuntu"
                    pixelSize: 18
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

                validator: RegExpValidator {
                    regExp: Variables.email_regular_expression
                }
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
                onTextChanged: {
                    console.log(text, acceptableInput)
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
                    placeholderText: "messagge"
                }
                onFocusChanged: {
                    messageArea.placeholderText = ""
                    messageArea.color = "#000000"
                }
                font {
                    family: "Ubuntu"
                    pixelSize: 18
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
                    sendClicked()
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
                color: "#b0a8b9"
                anchors.centerIn: parent
                font {
                    family: "Ubuntu"
                    pixelSize: 18
                }
            }
            Image {
                id: close
                source: {
                    if(messageBoxTxt.text === success) {
                        "./icons/success_close.svg"
                    } else {"./icons/close.svg"}
                }
                anchors {
                    top: parent.top
                    right: parent.right
                    topMargin: 10
                    rightMargin: 10
                }
                CursorShapeMouseArea {
                    anchors.fill: parent
                    onClicked: {
                        messageCloseClicked()
                    }
                }
            }
        }
    }

    // footer _____________________________________
    Column {
        id: staffColumn

        anchors {
            horizontalCenter: parent.horizontalCenter
            top: feedbackRect.bottom
            topMargin: 30
        }
        spacing: 5
        Text {
            id: design
            text: "<i><u>Design by Anastacia Karapetyan</u></i>"
            color: "#B0A8B9"
            font {
                family: "Ubuntu"
                pixelSize: 16
            }
            CursorShapeMouseArea {
                anchors.fill: parent
                onClicked: {
                    Qt.openUrlExternally("https://www.behance.net/bo4koanast8de6")
                }
            }
        }
        Text {
            id: backend

            color: "#B0A8B9"
            text: qsTr("Backend  by Mher Karapetyan")
            font {
                family: "Ubuntu"
                pixelSize: 16
            }
        }
        Text {
            id: frontend

            text: qsTr("Frontend by Khachatur Karapetyan")
            color: "#B0A8B9"
            font {
                family: "Ubuntu"
                pixelSize: 16
            }
        }
    }
}
