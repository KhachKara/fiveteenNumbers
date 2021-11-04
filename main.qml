import Common 43.21
import "./Assets"

import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    id: root

    minimumWidth: ProjectStyles.gameSide
    minimumHeight: ProjectStyles.gameSide
    maximumWidth: ProjectStyles.gameSide
    maximumHeight: ProjectStyles.gameSide

    visible: true
    title: qsTr("15 Numbers")

    Rectangle {
        id: gameArea

        property int pressedX: 0
        property int pressedY: 0
        property int releasedX: 0
        property int releasedY: 0


        width: parent.width
        height: parent.height


        Square {
            id: sq1

            squareNumber: "1"
            x: 0
            y: 0
            squareMouseArea.onPressed: {
                gameArea.pressedX = gameArea.mapToGlobal(parseInt(squareMouseArea.mouseX), parseInt(squareMouseArea.mouseY))[0]
                gameArea.pressedY = gameArea.mapToGlobal(parseInt(squareMouseArea.mouseX), parseInt(squareMouseArea.mouseY))[1]
                console.log(gameArea.mapToGlobal(parseInt(squareMouseArea.mouseX), parseInt(squareMouseArea.mouseY)))
//                console.log(gameArea.pressedX, gameArea.pressedY)
            }
            squareMouseArea.onReleased: {
                console.log(gameArea.mapToGlobal(parseInt(squareMouseArea.mouseX), parseInt(squareMouseArea.mouseY)))
            }
        }
    }
}

