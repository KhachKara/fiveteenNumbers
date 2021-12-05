import QtQuick 2.2

Item {
    id: root

    property int number: 0

    height: width

    Rectangle {
        id: squareRect

        anchors.fill: parent
        visible: number > 0
        radius: parent.width * 0.1
        color: "red"
        border.width: ProjectStyles.borderThiknes
        border.color: "#000000"

        Image {
            id: gradientFill

            anchors.fill: parent
            source: "./icons/gradientFill.svg"
        }


        Text {
            id: squareText

            anchors.centerIn: parent
            text: number
            font.pixelSize: squareRect.height * ProjectStyles.numberFontSize
        }
    }
}
