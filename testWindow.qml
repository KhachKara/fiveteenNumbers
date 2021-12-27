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

    Column {
        anchors {
            fill: parent
            topMargin: 10
            leftMargin: 10
        }
        TextInput {
            id: login
            width: parent.width
            focus: true
            font.pixelSize: 40
        }
        TextInput {
            id: mail
            width: parent.width
            focus: true
            font.pixelSize: 40
            readOnly: true
            text: login.text + '@text.test'
        }
        TextInput {
            id: pass
            width: parent.width
            focus: true
            font.pixelSize: 40
        }
        Button {
            text: "Write"
            onClicked: {
                let r = core.registerPlayer(login.text, mail.text, pass.text);
                console.info('result is', r);
            }
        }


    }
}
