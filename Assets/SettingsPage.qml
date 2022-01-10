import QtQuick 2.2

Item {
    id: root

    component MyCheckBox: Image {
        property bool checked: false

        source: checked ? "qrc:/Assets/icons/CHECKED_checkbox.svg" : "qrc:/Assets/icons/EMPTY_checkbox.svg"

        CursorShapeMouseArea {
            anchors.fill: parent
            onClicked: {
                checked =  !checked;
            }
        }
    }

    component MyCheckRow: Item {
        property alias text: txt.text
        property alias checked: checkBox.checked

        implicitHeight: 24

        Text {
            id: txt

            anchors.verticalCenter: parent.verticalCenter
            color: "#B0A8B9"
            font {
                family: "Ubuntu"
                pixelSize: 20
            }
        }

        MyCheckBox {
            id: checkBox
            anchors {
                verticalCenter: parent.verticalCenter
                right: parent.right
            }
        }
    }

    Column {
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            margins: 22
        }

        spacing: 22
        MyCheckRow {
            id: soundSetting
            width: parent.width
            text: qsTr("Sound")
        }

        MyCheckRow {
            id: musicSetting
            width: parent.width
            text: qsTr("Music")
        }
    }
}
