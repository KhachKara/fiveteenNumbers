import Common 43.21
import QtQuick 2.2

Item {
    property alias squareNumber: squareText.text


    width: ProjectStyles.ganeSide / 4
    height: ProjectStyles.ganeSide / 4

    function borderCollision() {
        if((squareRect.x >= parent.x && squareRect.x <= parent.height) &&
                (squareRect.y >= parent.y && squareRect.y <= parent.height))
            return true
        return false
    }

    Rectangle{
        id: squareRect
        width: parent.width
        height: parent.height
        radius: parent.width * 0.1
        color: "red"
        border.width: 2
        border.color: "#000000"

        Text {
            id: squareText
            text: squareNumber
            anchors.centerIn: parent
            font.pixelSize: ProjectStyles.ganeSide * 0.15
            color: squareMouseArea.pressed ? "#ffffff" : "#000000"
        }

        Drag.active: squareMouseArea.drag.active

        MouseArea {
            id: squareMouseArea

            anchors.fill: parent
            drag.target: parent
            onPositionChanged: {
                console.log("Error" + squareNumber)
            }
        }
    }
}
