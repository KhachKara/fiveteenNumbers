import QtQuick 2.12
import QtQuick.Controls 2.12

Item  {
    id: root

    signal newGameClicked()
    signal quitClicked()
    signal logoClicked()

    property color mainBgColor: "transparent"
    readonly property real iconGradientSize: 50
    property real bottomGradientSize: 0

    ListModel {
        id: listModel
        ListElement {
            text: "New game"
        }
        ListElement {
            text: "Quit"
        }
    }

    Rectangle {
        id: logoImage
        anchors {
            top: parent.top
            topMargin: -70
        }
        width: parent.width
        height: 130 + root.iconGradientSize
        z: 1

        gradient: Gradient {
            GradientStop { position: 0.0; color: root.mainBgColor }
            GradientStop {
                position: (logoImage.height - root.iconGradientSize) / logoImage.height;
                color: root.mainBgColor
            }
            GradientStop { position: 1; color: "transparent" }
        }

        Image {
            anchors {
                fill: parent
                bottomMargin: root.iconGradientSize
            }
            fillMode: Image.PreserveAspectFit
            source: "qrc:/Assets/icons/logo.svg"

            CursorShapeMouseArea {
                anchors.fill: parent

                onClicked: {
                    logoClicked()
                }
            }
        }
    }


    ListView {
        id: listView

        anchors {
            top: logoImage.bottom
            topMargin: -root.iconGradientSize
            left: parent.left
            leftMargin: 30
            right: parent.right
            rightMargin: 30
            bottom: parent.bottom
            bottomMargin: -root.bottomGradientSize
        }
        bottomMargin: root.bottomGradientSize

        Binding on topMargin {
            value: Math.max(listView.height - (listView.contentHeight
                                               + root.iconGradientSize)
                            , root.iconGradientSize)
            delayed: true
        }

        spacing: 12

        model: listModel
        delegate: Rectangle {
            anchors.horizontalCenter: parent ? parent.horizontalCenter : undefined
            width: listView.width
            height: 70
            color: "#845EC2"
            radius: 8
            Text {
                anchors.centerIn: parent
                text: model.text
                color: "#ffffff"
                font {
                    family: "Ubuntu"
                    pixelSize: 32
                }
            }
            CursorShapeMouseArea {
                anchors.fill: parent

                onClicked: {
                    if(text === "New game") {
                        newGameClicked();
                    } else if(text === "Quit") {
                        quitClicked();
                    }
                }
            }
        }
    }
}
