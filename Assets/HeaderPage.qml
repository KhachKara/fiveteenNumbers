import QtQuick 2.0

Item {
    id: root

    property alias pageName: pageName.text
    property alias backVisible: back.visible
    property alias exitVisible: exit.visible
    property alias backIsPause: back.isPause
    property alias textColor: pageName.color

    signal backClicked()

    Item {
        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            leftMargin: 30
        }
        width: 50
        height: width
        Image {

            id: back
            property bool isPause: false
            source: isPause ? "./icons/pause.svg" : "./icons/back.svg"
            anchors.centerIn: parent
        }

        CursorShapeMouseArea {
            anchors.fill: parent

            onClicked: {
                root.backClicked();
            }
        }
    }

    Item {
        id: exit
        anchors {
            verticalCenter: parent.verticalCenter
            right: parent.right
            rightMargin: 30
        }
        width: 50
        height: width
        Image {
            source: "./icons/exit.svg"
            anchors.centerIn: parent
        }
        CursorShapeMouseArea {
            anchors.fill: parent

            onClicked: {
                Qt.quit();
            }
        }
    }

    Text {
        id: pageName

        color: "#B0A8B9"
        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
            topMargin: 32
        }

        font {
            family: "Ubuntu"
            pixelSize: 22
        }
    }
}
