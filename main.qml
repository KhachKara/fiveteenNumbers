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

    HeaderPage {
        id: headerPage
        anchors.fill: parent
        visible: false

        onBackClicked: {
            stackView.pop()
            headerPage.visible = false
            logoPage.visible = true
        }
    }

    WelcomePage {
        id: welcomePage

        visible: false
        anchors.top: parent.top
        anchors.topMargin: 160
    }

    LogoPage {
        id: logoPage

        height: 100
        width: parent.width
        z: 1

        onLogoClicked: {
            stackView.push(aboutPage)
            logoPage.visible = false
            aboutPage.anchors.topMargin = 80
            headerPage.visible = true
            headerPage.pageName = "Our team"
        }
    }

    AboutPage {
        id: aboutPage

        anchors.fill: parent
        visible: false
    }

    StackView {
        id: stackView

        anchors.fill: parent
        initialItem: welcomePage
    }

    visible: true
    title: qsTr("15 Numbers")

    AdvertisePage {
        id: advertisePage

        anchors.bottom: parent.bottom
    }
}
