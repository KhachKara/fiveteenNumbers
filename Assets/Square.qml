import Common 43.21
import QtQuick 2.2

Item {
    property alias squareNumber: squareText.text
    property alias squareMouseArea: squareMouseArea
    property alias squareRect: squareRect

    property point topMiddlePoint: Qt.point(squareRect.width / 2, 0)
    property point bottomMiddlePoint: Qt.point(squareRect.width / 2, squareRect.height)
    property point leftiddlePoint: Qt.point(0, squareRect.height / 2)
    property point rightMiddlePoint: Qt.point(squareRect.width, squareRect.height / 2)

    width: ProjectStyles.gameSide / 4
    height: ProjectStyles.gameSide / 4

    function borderCollision() {
        if((topMiddlePoint.y < gameArea.y && bottomMiddlePoint.y > gameArea.height) &&
                (leftiddlePoint.x < gameArea.x && rightMiddlePoint.x > gameArea.width))
        {return console.log(squareNumber + " out of board")}
        else {return console.log(squareNumber + " inside")}
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
                borderCollision()
//                console.log(gameArea.mapFromGlobal(topMiddlePoint.y, bottomMiddlePoint.y,
//                                                   leftiddlePoint.x, rightMiddlePoint.x))
            }
            onReleased: {
                releasedX = gameArea.mapToGlobal(squareMouseArea.mouseX, squareMouseArea.mouseY).x
                releasedY = gameArea.mapToGlobal(squareMouseArea.mouseX, squareMouseArea.mouseY).y

                if (releasedX - pressedX >= 10 && releasedY - pressedY < 10 && pressedY - releasedY < 10) {
                    squareRect.x += squareRect.width
                } else if (pressedX - releasedX >= 10  && releasedY - pressedY < 10 && pressedY - releasedY < 10) {
                    squareRect.x -= squareRect.width
                }

                if(releasedY - pressedY >= 10  && releasedX - pressedX < 10 && pressedX - releasedX < 10) {
                    squareRect.y += squareRect.height
                } else if (pressedY - releasedY >= 10  && releasedX - pressedX < 10 && pressedX - releasedX < 10) {
                    squareRect.y -= squareRect.height
                }


            }
        }
    }
}
