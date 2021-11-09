pragma Singleton
import QtQuick 2.0

QtObject{
    property int gameSide: columnRow * 100
    property int columnRow: 4
    property real numberFontSize: 0.75
    property int borderThiknes: 2
    property int mouseSensitivity: gameSide / columnRow / 2
}
