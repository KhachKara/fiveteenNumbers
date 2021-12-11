import QtQuick 2.4
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.0

Item {
    id: feedbackForm



    property alias textArea1: textArea1
    property alias send: send

    ColumnLayout {
        id: columnLayout1
        height: 100
        anchors.right: parent.right
        anchors.rightMargin: 12
        anchors.left: parent.left
        anchors.leftMargin: 12
        anchors.top: parent.top
        anchors.topMargin: 12

        TextArea {
            id: textArea1
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }

    RowLayout {
        id: rowLayout1
        width: 100
        anchors.right: parent.right
        anchors.rightMargin: 12
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 12

        Button {
            id: send
            text: qsTr("Send")
            Layout.fillHeight: true
            Layout.fillWidth: true
        }


    }
}
