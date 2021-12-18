import "./Assets"

import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.5

Window {
    id: root

    signal logoClicked()
    readonly property int topMargin: 30

    readonly property color mainBgColor: "#4B4453"
    readonly property color grayBgColor: "#B0A8B9"
    readonly property color carrotBgColor: "#C34A36"
    readonly property color lightCarrotBgColor: "#FF8066"

    width: 360
    height: 640
    color: mainBgColor

    visible: true
    title: qsTr("15 Numbers")

    Item {
        id: header
        anchors.fill: parent
        anchors {
            bottomMargin: parent.height - 100 - 2 * topMargin
        }
        //        color: "purple"

        Image {
            id: logo

            source: "qrc:/Assets/icons/logo.svg"
            anchors.centerIn: parent

            CursorShapeMouseArea {
                anchors.fill: parent

                onClicked: {
                    logoClicked()
                }

            }
        }
    }

    Item {
        id: body
        width: parent.width
        anchors {
            top: header.bottom
            bottom: footer.top
        }
        StackView {
            id: stackView
            anchors.fill: parent
            initialItem: "qrc:/Assets/WelcomePage.qml"
        }
    }

    Item {
        id: footer

        anchors.fill: parent
        anchors.topMargin: parent.height - 75
        //        color: "gold"

        AdvertisePage {
            id: advertise

            anchors.fill: parent
        }
    }
}
