import "./Assets"
import QtQml 2.2
import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.5

Window {
    id: root

    readonly property int topMargin: 30

    readonly property color mainBgColor: "#4B4453"
    readonly property color grayBgColor: "#B0A8B9"
    readonly property color carrotBgColor: "#C34A36"
    readonly property color lightCarrotBgColor: "#FF8066"

    width: 360
    height: 640
    color: mainBgColor

    WelcomePage {
        id: welcomePage

        visible: false
        anchors.fill: parent
        anchors.topMargin: 160
    }

    LogoPage {
        id: logoPage

        height: 100
        width: parent.width
    }


    StackView {
        id: stackView

        anchors.topMargin: 160
        anchors.fill: parent

        initialItem: "qrc:/Assets/WelcomePage.qml"
    }

    visible: true
    title: qsTr("15 Numbers")

    AdvertisePage {
        id: advertisePage

        anchors.bottom: parent.bottom
    }
}
