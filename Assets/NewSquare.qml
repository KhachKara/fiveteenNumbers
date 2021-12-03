import Common 43.21
import QtQuick 2.2

// комменты после прочтения удали

Item {  // прозрачный прямоугольник подложка
    id: root
    width: 100
    height: width

    Rectangle {
        id: squareRect

        property int number: 0

        visible: number > 0

        width: parent.with * 0.7 // между квадратами должно быть 15 пикс
                                 // поэтому подложка должна якорится к краю squareRect иначе между квадратами будет 30 пикс
        height: width
        radius: parent.width * 0.04  // может быть 5 пикс

        anchors.centerIn: parent

        color: "#FFAD9C"  // когда на своем месте такой цвет "#FF8066"

        Text {
            id: numberText

            anchors.centerIn: parent
            text: number
            color: "#FFFFFF"
            font {
                family: "Ubuntu"  // стоить создать библиатеку стилей типа TextNetrics
                pixelSize: 32
            }
        }
    }
}
