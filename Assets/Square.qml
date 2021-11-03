import Common 43.21
import QtQuick 2.2

Item {
    width: ProjectStyles.ganeSide / 4
    height: ProjectStyles.ganeSide / 4

    Rectangle{
        id: square

        width: parent.width
        height: parent.height
        radius: parent.width * 0.1
        color: "red"

        Text {
            id: txtSquare
            text: "9"
            anchors.centerIn: parent
            font.pixelSize: ProjectStyles.ganeSide * 0.15
            color: squareMouseArea.pressed ? "#ffffff" : "#000000"
        }

        MouseArea {
            id: squareMouseArea

            anchors.fill: parent
            drag.target: parent
        }
    }
}
