import QtQuick 2.2

Item {
    id: root

    property int number: 0

    height: width

    Rectangle {
        id: squareRect

        anchors.fill: parent
        visible: number > 0
        color: "transparent"
        Rectangle {
            anchors.centerIn: parent
            width: 0.925926 * parent.width
            height: width
            color: "#FF8066"
            radius: 0.08 * width
        }

        Text {
            id: numberText

            anchors.centerIn: parent
            text: number
            color: "#FFFFFF"
            font {
                family: "Ubuntu"
                pixelSize: squareRect.height - 25 // \todo добавить минимальный размер
            }
        }
    }
}
