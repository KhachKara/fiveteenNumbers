pragma Singleton
import QtQuick 2.12

QtObject {
    property var __rootItem;
    readonly property bool isPortrait: !!__rootItem ? __rootItem.height > __rootItem.width : true

    function initModule(rootItem) {
        __rootItem = rootItem;
    }
}
