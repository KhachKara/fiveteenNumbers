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

    width: ProjectStyles.gameSide / ProjectStyles.columnRow
    height: ProjectStyles.gameSide / ProjectStyles.columnRow

    Rectangle{
        id: squareRect

        width: parent.width
        height: parent.height
        radius: parent.width * 0.1
        color: "red"
        border.width: ProjectStyles.borderThiknes
        border.color: "#000000"

        Text {
            id: squareText

            anchors.centerIn: parent
            font.pixelSize: squareRect.height * ProjectStyles.numberFontSize
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

                if (releasedX - pressedX >= ProjectStyles.mouseSensitivity
                        && releasedY - pressedY < ProjectStyles.mouseSensitivity
                        && pressedY - releasedY < ProjectStyles.mouseSensitivity) {
                    squareRect.x += squareRect.width
                } else if (pressedX - releasedX >= ProjectStyles.mouseSensitivity
                           && releasedY - pressedY < ProjectStyles.mouseSensitivity
                           && pressedY - releasedY < ProjectStyles.mouseSensitivity) {
                    squareRect.x -= squareRect.width
                }

                if(releasedY - pressedY >= ProjectStyles.mouseSensitivity
                        && releasedX - pressedX < ProjectStyles.mouseSensitivity
                        && pressedX - releasedX < ProjectStyles.mouseSensitivity) {
                    squareRect.y += squareRect.height
                } else if (pressedY - releasedY >= ProjectStyles.mouseSensitivity
                           && releasedX - pressedX < ProjectStyles.mouseSensitivity
                           && pressedX - releasedX < ProjectStyles.mouseSensitivity) {
                    squareRect.y -= squareRect.height
                }
            }
        }
    }
}
