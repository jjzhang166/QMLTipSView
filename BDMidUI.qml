import QtQuick 2.0

Rectangle {
    width: 300
    height: 200
    BDTopUI{
        id:topUI
        anchors.top: parent.top
        anchors.topMargin: 0
        width: parent.width
        height: 28
    }
    BDStackView{
        id:centerUI
        anchors.top: topUI.bottom
        anchors.bottom: line.top
        anchors.bottomMargin: 0
        width: parent.width
    }
    Rectangle{
        id:line
        width: parent.width
        height: 1
        color: "#E8E6E6"
        anchors.bottom: btmUI.top
        anchors.bottomMargin: 0
    }

    BDBottomUI{
        id:btmUI
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        width: parent.width
        height: 38
        onSignalClickPreNext: {
            centerUI.setCurrentIndex(index);
        }
    }
    function setMideInfo(tmp){
        centerUI.fromCppInfo(tmp);
    }
}

