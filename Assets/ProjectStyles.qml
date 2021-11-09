pragma Singleton
import QtQuick 2.0

QtObject{
    property int gameSide: columnRow * 100
    property int columnRow: 8
    property int mouseSensitivity: gameSide / columnRow / 2
}
