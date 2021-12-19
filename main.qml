//import "./Assets"
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

    visible: true
    title: qsTr("15 Numbers")
}
