import Common 43.21
import QtQuick 2.0

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

            property int deltaX: onMouseXChanged - mouseX
            property int deltaY: onMouseYChanged - mouseY

            property int newX: 0
            property int newY: 0


            property string direction

            anchors.fill: parent
            drag.target: parent

            direction: deltaX > 0 ? "left" : "right"


            onPressed: console.log(onMouseXChanged[0], onMouseYChanged[1])
        }

    }
}
