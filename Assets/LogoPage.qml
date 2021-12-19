import QtQuick 2.0
import QtQuick.Controls 2.5

Item {
    id: root

    signal logoClicked()

    property alias logoHeight: logoImage.height

    Image {
        id: logoImage
        anchors.horizontalCenter: root.horizontalCenter
        anchors{
            top: parent.top
            topMargin: 30
        }
        source: "qrc:/Assets/icons/logo.svg"


        CursorShapeMouseArea {
            anchors.fill: parent

            onClicked: {
                logoClicked()
            }
        }
    }
}
