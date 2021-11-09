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



    BackgroundRect {
        id: backgroundRect
    }


    Component {
        id: squareComponent

        Square {}

    }

    Rectangle {
        id: gameArea

        width: parent.width
        height: parent.height

        property int rowQuantity: ProjectStyles.columnRow

        Component.onCompleted: {
            console.log('squareComponent.status', squareComponent.status)
            let k = 1
            for (let j = 0; j < rowQuantity; ++j) {
                for (let i = 0; i < rowQuantity; ++i) {
                    squareComponent.incubateObject(root, {
                                                       x: i * ProjectStyles.gameSide / ProjectStyles.columnRow,
                                                       y: j * ProjectStyles.gameSide / ProjectStyles.columnRow,
                                                       squareNumber: k
                                                   });
                    k = k + 1;
                    if (k === ProjectStyles.columnRow * ProjectStyles.columnRow) {
                        backgroundRect.number = k
                        backgroundRect.flag = true
                        break
                    }
                }
            }
        }
    }
}
