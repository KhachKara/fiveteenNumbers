import Common 43.21
import QtQuick 2.2

Item {
    property alias squareNumber: squareText.text
    property alias squareMouseArea: squareMouseArea
    property alias squareRect: squareRect


    width: ProjectStyles.gameSide / 4
    height: ProjectStyles.gameSide / 4

    //    function borderCollision() {
    //        if((squareRect.x >= gameArea.x && squareRect.x + squareRect.width >= gameArea.width) &&
    //                (squareRect.y <= gameArea.y && squareRect.y + squareRect.height <= gameArea.height))
    //        {return console.log(squareNumber + " true")}
    //        else {return console.log(squareNumber + " false")}
    //    }

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


        MouseArea {
            id: squareMouseArea

            property real pressedX
            property real pressedY
            property real releasedX
            property real releasedY

            anchors.fill: parent

            onPressed: {
                pressedX = gameArea.mapToGlobal(squareMouseArea.mouseX, squareMouseArea.mouseY).x
                pressedY = gameArea.mapToGlobal(squareMouseArea.mouseX, squareMouseArea.mouseY).y
            }
            onReleased: {
                releasedX = gameArea.mapToGlobal(squareMouseArea.mouseX, squareMouseArea.mouseY).x
                releasedY = gameArea.mapToGlobal(squareMouseArea.mouseX, squareMouseArea.mouseY).y

                if (releasedX - pressedX >= 10) {
                    squareRect.x += squareRect.width
                } else if (pressedX - releasedX >= 10) {
                    squareRect.x -= squareRect.width
                }

                if(releasedY - pressedY >= 10) {
                    squareRect.y += squareRect.height
                } else if (pressedY - releasedY >= 10) {
                    squareRect.y -= squareRect.height
                }
            }
        }
    }
}
