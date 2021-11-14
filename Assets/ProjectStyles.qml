pragma Singleton
import QtQuick 2.0

QtObject {
    property int columnRowCount: 4
    property int sizeSquare: 100
    property int gameSide: columnRowCount * sizeSquare
    property real numberFontSize: 0.75
    property int borderThiknes: 2
}
