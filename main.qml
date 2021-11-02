import Common 43.21
import "./Assets"

import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    id: root

    minimumWidth: ProjectStyles.ganeSide
    minimumHeight: ProjectStyles.ganeSide
    maximumWidth: ProjectStyles.ganeSide
    maximumHeight: ProjectStyles.ganeSide

    visible: true
    title: qsTr("15 Numbers")

    Square{
    }
}
