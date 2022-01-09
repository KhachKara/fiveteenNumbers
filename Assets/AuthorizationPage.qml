import QtQuick 2.0
import QtQml 2.2
import QtQuick.Dialogs 1.3

Item {
    id: root

    signal enterClicked()

    property var baseStackView
    property int areaSize: -1;
    property int steps: -1
    property int timeSec: -1
    property alias nickname: nick.text
    property alias password: passw.text

    component MyTextInput: Rectangle {
        readonly property string text: _textInp.text !== placeholderText + _textInp.__key ? _textInp.text : ""
        property alias placeholderText: _textInp.placeholderText
        property int echoMode: TextInput.Normal
        height: 40
        radius: 8
        onFocusChanged: {
            if (focus) {
                _textInp.forceActiveFocus();
            }
        }
        TextInput {
            id: _textInp
            property bool emptyInput: text === placeholderText + __key || !text.length
            property string placeholderText: "placeholderText"
            property string __key: "    " // &nbsp

            anchors {
                fill: parent
                leftMargin: 10
            }
            verticalAlignment: TextInput.AlignVCenter
            text: placeholderText + __key
            focus: true
            echoMode: emptyInput ? TextInput.Normal : parent.echoMode
            color: emptyInput ? "#b0a8b9" :"#000000"
            onActiveFocusChanged: {
                if (emptyInput) {
                    if (activeFocus) {
                        text = "";
                    } else {
                        text = placeholderText + __key
                    }
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
            passw.focus = true;
        }
    }

    Rectangle {
        id: authorBgRect

        anchors.centerIn: parent

        width: parent.width
        height: 200
        radius: 8

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

        MyTextInput {
            id: nick
            anchors {
                top: authorTxt.bottom
                left: parent.left
                right: parent.right
                margins: 20
            }
            placeholderText: "nickname"
            Image {
                id: enterIcon
                source: "qrc:/Assets/icons/enter_icon_gray.svg"
                anchors {
                    verticalCenter: parent.verticalCenter
                    right: parent.right
                    rightMargin: 10
                }

                CursorShapeMouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if (core.checkLogin(nickname)) {
                            let r = core.signIn(nickname, password);
                            if (r === -1) {
                                // этого не должно происходить!
                                console.error("Error in code");
                            } else if (r === -2) {
                                messageDialog.title = "Warning"
                                messageDialog.text = "Fill the correct password!"
                                messageDialog.visible = true
                            } else {
                                core.addResult(areaSize, steps, timeSec)
                                baseStackView.pop()
                            }
                        } else {
                            core.registerPlayer(nickname, password)
                            core.addResult(areaSize, steps, timeSec)
                            if (baseStackView) {
                                baseStackView.pop()
                            }
                        }
                    }
                }
            }
        }
        MyTextInput {
            id: passw
            anchors {
                top: nick.bottom
                left: parent.left
                right: parent.right
                margins: 20
            }
            placeholderText: "password"
            echoMode: TextInput.Password
            Image {
                id: eyeIcon
                source: passw.echoMode === TextInput.Password
                        ? "qrc:/Assets/icons/eye_hide.svg"
                        : "qrc:/Assets/icons/eye_show.svg"
                anchors {
                    verticalCenter: parent.verticalCenter
                    right: parent.right
                    rightMargin: 10
                }

                CursorShapeMouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if(passw.echoMode === TextInput.Password) {
                            passw.echoMode = TextInput.Normal
                        } else {
                            passw.echoMode = TextInput.Password
                        }
                    }
                }
            }
        }
    }
}
