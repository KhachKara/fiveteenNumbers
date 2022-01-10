import QtQml 2.12
import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.15

ApplicationWindow {
    id: root
    width: 360
    height: 640
    visible: true
    title: "testWindow"

    component MyGroupBox: Rectangle {
        default property alias items: gbColumn.children
        border {
            width: 2
            color: 'grey'
        }
        height: gbColumn.height + 5
        color: 'skyblue'
        Column {
            id: gbColumn
            anchors {
                left: parent.left
                right: parent.right
                margins: 10
            }
            spacing: 15
        }
    }

    component MyField: Item {
        height: tPrint.height
        property alias text: tPrint.text
        property alias textInput: ti.text
        Text {
            id: tPrint
            width: parent.width / 3
            font.pixelSize: 40
        }
        Rectangle {
            anchors {
                left: tPrint.right
                right: parent.right
                leftMargin: 5
            }
            height: tPrint.height + 2
            opacity: 0.31
            border.width: ti.focus ? 3 : 1
        }
        TextInput {
            id: ti
            anchors {
                left: tPrint.right
                right: parent.right
                leftMargin: 8
            }
            clip: true
            font.pixelSize: 40
            activeFocusOnTab: true
        }
    }

    component MyHeader: Text {
        font.underline: true
        font.pixelSize: 50
        font.bold: true
    }

    Text {
        id: idPlayer
        anchors.left: parent.left
        anchors.leftMargin: 10
        font.pixelSize: 40
        text: "id: %1, login: %2".arg(core.idPlayer).arg(core.login)
        color: 'darkblue'
        z: 1
    }
    Flickable {
        anchors {
            top: idPlayer.bottom
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }
        contentHeight: column.height + 10
        clip: true
        Column {
            id: column
            anchors {
                left: parent.left
                right: parent.right
                topMargin: 10
                leftMargin: 10
                rightMargin: 10
            }
            spacing: 10
            MyGroupBox {
                width: parent.width
                MyHeader {
                    text: "Reg or sing in"
                }

                MyField {
                    id: login
                    width: parent.width
                    text: 'Login'
                }
                MyField {
                    id: pass
                    width: parent.width
                    text: 'Pass'
                }
                Button {
                    text: "Reg player"
                    width: parent.width
                    onClicked: {
                        let r = core.signIn(login.textInput, pass.textInput);
                        switch (r) {
                        case -1:
                            r = core.registerPlayer(login.textInput, pass.textInput);
                            console.info(r >= 0 ? 'зарегились' : 'какая то ошибка %1'.arg(r))
                            break;
                        case -2:
                            console.info('не правильный пароль)')
                            break
                        default:
                            console.info('залогинились')
                        }
                    }
                }
            }
            MyGroupBox {
                width: parent.width
                MyHeader {
                    text: "Add result"
                }
                MyField {
                    id: sizeArea
                    width: parent.width
                    text: 'Size'
                }
                MyField {
                    id: steps
                    width: parent.width
                    text: 'Steps'
                }
                MyField {
                    id: time
                    width: parent.width
                    text: 'Time'
                }
                MyField {
                    id: date
                    width: parent.width
                    text: 'Date'
                }
                Button {
                    text: "Write result"
                    width: parent.width
                    onClicked: {
                        let r = core.addResult(parseInt(sizeArea.textInput),
                                               parseInt(steps.textInput),
                                               parseInt(time.textInput),
                                               date.textInput);
                    }
                }
            }
            ListView {
                id: list
                anchors {
                    left: parent.left
                    right: parent.right
                    margins: 10
                }
                height: 200
                model: core.model
                delegate: Item {
                    width: list.width
                    height: tNumber.height + 2
                    Text {
                        id: tNumber
                        text: index + 1
                        width: 20
                    }
                    Rectangle {
                        id: rMedal
                        anchors {
                            left: tNumber.right
                            leftMargin: 37
                        }
                        visible: index < 3
                        width: 12
                        height: width
                        radius: width / 2
                        color: {
                            switch(index) {
                            case 0: return 'gold'
                            case 1: return 'silver'
                            case 2: return '#FFC266'
                            default: return 'black'
                            }
                        }
                    }
                    Text {
                        id: tLogin
                        anchors {
                            left: rMedal.right
                            leftMargin: 37
                        }
                        text: loginRole
                    }
                    Text {
                        anchors.right: parent.right
                        text: stepsRole
                    }
                }
            }
        }
    }
}
