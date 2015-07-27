import QtQuick 2.1
import QtQuick.Controls 1.2
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2

Rectangle {
    id:rootWindow
    width: 310
    height: 210
    visible: true
    color: "transparent"
    property string appFont: "微软雅黑"
    signal signalOption(variant itype,string str);
    DDuiShadowBg{
        id:bg
        width: parent.width
        height: parent.height
        BDMidUI{
            id:topUI
            anchors.fill: parent
            anchors.margins: 5
        }
    }
    function setTipsInformation(var1,var2){
          console.log("get var1 is "+var1);
          console.log("get var2 is "+var2);
          topUI.setMideInfo(var2);
    }
}
