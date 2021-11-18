import Common 43.21
import QtQuick 2.2

Item {
    property int number: 0
    property alias squareRect: squareRect


    height: width

    Rectangle {
        id: squareRect

        anchors.fill: parent
        visible: number > 0 // Можно так же добавить как будет выглядеть пустая клетка.
        radius: parent.width * 0.1
        color: "red"
        border.width: ProjectStyles.borderThiknes
        border.color: "#000000"

        Image {
            id: gradientFill

            anchors.fill: parent
            source: "gradientFill.svg"
        }


        Text {
            id: squareText

            anchors.centerIn: parent
            text: number
            font.pixelSize: squareRect.height * ProjectStyles.numberFontSize
        }
    }
}
