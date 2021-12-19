import QtQuick 2.0
import QtQuick.Controls 2.5

Item {
    id: root

    Image {
        anchors.horizontalCenter: root.horizontalCenter
        anchors{
            top: parent.top
            topMargin: 30
        }
        source: "qrc:/Assets/icons/logo.svg"
    }

    CursorShapeMouseArea {
        anchors.fill: parent

        onClicked: {
            stackView.push("AboutPage.qml")
        }
    }
}
