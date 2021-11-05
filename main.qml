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

        // 1 row
        Square {
            id: sq1

            squareNumber: "1"
            x: 0
            y: 0
        }
        Square {
            id: sq2

            squareNumber: "2"
            x: 100
            y: 0
        }
        Square {
            id: sq3

            squareNumber: "3"
            x: 200
            y: 0
        }
        Square {
            id: sq4

            squareNumber: "4"
            x: 300
            y: 0
        }

        // 2 row
        Square {
            id: sq5

            squareNumber: "5"
            x: 0
            y: 100
        }
        Square {
            id: sq6

            squareNumber: "6"
            x: 100
            y: 100
        }
        Square {
            id: sq7

            squareNumber: "7"
            x: 200
            y: 100
        }
        Square {
            id: sq8

            squareNumber: "8"
            x: 300
            y: 100
        }

        // 3 row
        Square {
            id: sq9

            squareNumber: "9"
            x: 0
            y: 200
        }
        Square {
            id: sq10

            squareNumber: "10"
            x: 100
            y: 200
        }
        Square {
            id: sq11

            squareNumber: "11"
            x: 200
            y: 200
        }
        Square {
            id: sq12

            squareNumber: "12"
            x: 300
            y: 200
        }

        // 4 row
        Square {
            id: sq13

            squareNumber: "13"
            x: 0
            y: 300
        }
        Square {
            id: sq14

            squareNumber: "14"
            x: 100
            y: 300
        }
        Square {
            id: sq15

            squareNumber: "15"
            x: 200
            y: 300
        }
    }
}

