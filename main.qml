import Common 43.21
import "./Assets"

import QtQuick 2.15
import QtQuick.Window 2.15
import "./Assets/componentCreation.js" as SquareCreationScript

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

        width: parent.width
        height: parent.height

        property int rowQuantity: 4

        Component.onCompleted: {
            for (var i = 0; i <= rowQuantity; ++i) {
                for (var j = 0; j <= rowQuantity; ++j) {
                    SquareCreationScript.createSquareObjects()
//                    Square.sqsquareNumber += 1  // не соответствие типов
                    Square.squareRect.x = i * Square.squareRect.width
                    Square.squareRect.y = j * Square.squareRect.height
                }
            }
        }

    }
}
