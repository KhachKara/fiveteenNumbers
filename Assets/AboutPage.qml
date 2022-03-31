import QtQuick 2.2
import QtQuick.Controls 2.5
import QtQuick.Dialogs 1.3

Flickable {
    id: root

    contentHeight: staffColumn.height

    component IconTextRow: Row {
        id: rowRoot
        property alias icon: img.source
        property alias text: txt.text
        property string link

        spacing: 10
        Image {
            id: img
            anchors.verticalCenter: txt.verticalCenter
            width: 16
            height: width
        }
        Text {
            id: txt
            color: "#B0A8B9"
            font {
                family: "Ubuntu"
                pixelSize: 20
                italic: true
                underline: true
            }
            CursorShapeMouseArea {
                id: maLink
                anchors.fill: parent
                onClicked: {
                    Qt.openUrlExternally(rowRoot.link);
                }
            }
        }
    }

    Column {
        id: staffColumn

        anchors {
            left: parent.left
            leftMargin: 30
            right: parent.right
            rightMargin: 30
        }
        spacing: 20
        TextArea {
            width: parent.width
            wrapMode: TextEdit.WordWrap
            readOnly: true
            color: "#B0A8B9"
            font {
                family: "Ubuntu"
                pixelSize: 22
            }
            text: "This game was made to go through the full path of application development. If you want to contact us, here are our contacts:"
        }

        IconTextRow {
            icon: "qrc:/Assets/icons/behance.png"
            text: "Design by Anastacia Karapetyan"
            link: "https://www.behance.net/bo4koanast8de6"
        }
        IconTextRow {
            icon: "qrc:/Assets/icons/telegram.png"
            text: "Developer Mher Karapetyan"
            link: "https://t.me/karapetyan_m"
        }
        IconTextRow {
            icon: "qrc:/Assets/icons/telegram.png"
            text: "Developer Khachatur Karapetyan"
            link: "https://t.me/khachkara"
        }
    }
}
