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

    Component {
        id: squareComponent

        Square {}

    }

    Rectangle {
        id: gameArea

        width: parent.width
        height: parent.height

        property int rowQuantity: 4

        Component.onCompleted: {
            console.log('squareComponent.status', squareComponent.status)
            var k = 1
            for (var i = 0; i <= rowQuantity; ++i) {
                for (var j = 0; j <= rowQuantity; ++j) {
                    squareComponent.incubateObject(root, {
                                                      x: i * ProjectStyles.gameSide / 4,
                                                      y: j * ProjectStyles.gameSide / 4,
//                                                      squareNumber: '%1, %2'.arg(i).arg(j)
                                                       squareNumber: k,
                                                       k = k + 1
                                                  });                }
            }
        }
    }
}
