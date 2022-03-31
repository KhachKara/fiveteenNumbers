import QtQuick 2.2
import QtQuick.Controls 2.5
import QtQuick.Dialogs 1.3
import "./js/variables.js" as Variables

Flickable {
    id: root

    property var baseStackView

    signal sendClicked()

    clip: true
    contentHeight: feedbackRect.height + staffColumn.anchors.topMargin + staffColumn.height

    component MyTextInput: Rectangle {
        readonly property string text: _textInp.text !== placeholderText + _textInp.__key ? _textInp.text : ""
        property alias placeholderText: _textInp.placeholderText

        implicitWidth: 200
        implicitHeight: 30
        radius: 8
        onFocusChanged: {
            if (focus) {
                _textInp.forceActiveFocus();
            }
        }

        TextInput {
            id: _textInp
            property bool emptyInput: true
            property string placeholderText: "placeholderText"
            property string __key: "    " // &nbsp

            anchors {
                fill: parent
                leftMargin: 10
            }
            verticalAlignment: TextInput.AlignVCenter
            text: placeholderText + __key
            focus: true

            color: emptyInput ? "#b0a8b9" :"#000000"

            onActiveFocusChanged: {
                if (emptyInput) {
                    if (activeFocus) {
                        text = "";
                    } else {
                        text = placeholderText + __key;
                    }
                }
            }
            onTextChanged: {
                if (text !== placeholderText + __key) {
                    emptyInput = !text.length;
                }
            }

            font {
                family: "Ubuntu"
                pixelSize: 18
            }
        }
    }

    MessageDialog {
        id: messageDialog
        onAccepted: {
            if (!name.text) {
                console.info('name empty');
                name.focus = true;
            } else if (!e_mail.text) {
                console.info('mail empty');
                e_mail.focus = true;
            } else if (!messageArea.text) {
                console.info('message empty');
                message.focus = true;
            } else {
                sendClicked();
                if (root.baseStackView) {
                    root.baseStackView.pop();
                }
            }
        }
    }

    Rectangle {
        id: feedbackRect

        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            leftMargin: 30
            rightMargin: 30
        }
        height: 340
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

        MyTextInput {
            id: name
            anchors {
                top: feedBackTxt.bottom
                left: parent.left
                right: parent.right
                topMargin: 20
                leftMargin: 30
                rightMargin: 30
            }
            placeholderText: "name"

        }
        MyTextInput {
            id: e_mail
            anchors {
                top: name.bottom
                left: parent.left
                right: parent.right
                topMargin: 10
                leftMargin: 30
                rightMargin: 30
            }
            placeholderText: "e-mail"
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
            onFocusChanged: {
                messageArea.forceActiveFocus();
            }

            ScrollView {
                anchors.fill: parent
                TextArea {
                    id: messageArea
                    placeholderTextColor: "#b0a8b9"
                    placeholderText: "messagge"
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
                    if (!name.text || !e_mail.text || !messageArea.text) {
                        messageDialog.title = "Warning";
                        messageDialog.text = "Feel the form correctly";
                        messageDialog.visible = true;
                    } else {
                        messageDialog.title = "Feedback";
                        messageDialog.text = "Your mesage was\nsuccessfuly sent";
                        messageDialog.visible = true;
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
                    Qt.openUrlExternally("https://www.behance.net/bo4koanast8de6");
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
