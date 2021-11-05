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

        width: parent.width
        height: parent.height

        Repeater {
            model: 16
            Square {
                squareNumber: index + 1
                x: (index % 4) * width
                y: (index / 4) * height
            }
        }
    }
}

