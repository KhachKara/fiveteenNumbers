import Common 43.21
import "./Assets"

import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    id: gameArea

    minimumWidth: ProjectStyles.ganeSide
    minimumHeight: ProjectStyles.ganeSide
    maximumWidth: ProjectStyles.ganeSide
    maximumHeight: ProjectStyles.ganeSide

    visible: true
    title: qsTr("15 Numbers")

    Square {
        squareNumber: "1"
        x: 0
        y: 0
    }
    Square {
        squareNumber: "2"
        x: 100
        y: 0
    }
    Square {
        squareNumber: "3"
        x: 200
        y: 0
    }
    Square {
        squareNumber: "4"
        x: 300
        y: 0
    }
    Square{
        squareNumber: "5"
        x: 0
        y: 100
    }
    Square{
        squareNumber: "6"
        x: 100
        y: 100
    }
    Square{
        squareNumber: "7"
        x: 200
        y: 100
    }
    Square{
        squareNumber: "8"
        x: 300
        y: 100
    }
    Square{
        squareNumber: "9"
        x: 0
        y: 200
    }
    Square{
        squareNumber: "10"
        x: 100
        y: 200
    }
    Square{
        squareNumber: "11"
        x: 200
        y: 200
    }
    Square{
        squareNumber: "12"
        x: 300
        y: 200
    }
    Square{
        squareNumber: "13"
        x: 0
        y: 300
    }
    Square{
        squareNumber: "14"
        x: 100
        y: 300
    }
    Square{
        squareNumber: "15"
        x: 200
        y: 300
    }
}
