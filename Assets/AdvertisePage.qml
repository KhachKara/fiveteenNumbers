import QtQuick 2.0

Item {
    id: root
    anchors.fill: parent

    Rectangle {
        id: advertisement

        height: 50
        color: "yellow"
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
    }

}
