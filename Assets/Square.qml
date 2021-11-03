import Common 43.21
import QtQuick 2.2

Item {
    property alias squareNumber: squareText.text


    width: ProjectStyles.gameSide / 4
    height: ProjectStyles.gameSide / 4

    function borderCollision() {
        if((squareRect.x >= gameArea.x && squareRect.x + squareRect.width >= gameArea.width) &&
           (squareRect.y <= gameArea.y && squareRect.y + squareRect.height <= gameArea.height))
        {return console.log(squareNumber + " true")}
        else {return console.log(squareNumber + " false")}
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
            font.pixelSize: ProjectStyles.gameSide * 0.15
            color: squareMouseArea.pressed ? "#ffffff" : "#000000"
        }

        //        Drag.active: squareMouseArea.drag.active

        MouseArea {
            id: squareMouseArea

            anchors.fill: parent
            drag.target: parent
            drag.minimumX: squareRect.width
            onPositionChanged: {

            }
        }
    }
}
