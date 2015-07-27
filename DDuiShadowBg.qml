import QtQuick 2.0
import QtGraphicalEffects 1.0

Rectangle {
    //鏈€搴曞眰閫忔槑鍥惧眰
    width: 480;
    height: 680;
    color: "transparent"
    property int listViewActive: 0
    Item {
        //涓讳綋绐楀彛
        id: container;
        anchors.centerIn: parent;
        width: parent.width;
        height: parent.height;
        Rectangle {
            id: mainRect
            width: container.width-(2*rectShadow.radius);
            height: container.height - (2*rectShadow.radius);
            anchors.centerIn: parent;
            //浠ヤ笅鐪佺暐
        }
    }
    DropShadow {//缁樺埗闃村奖
        id: rectShadow;
        anchors.fill: source
        cached: true;
        horizontalOffset: 0;
        verticalOffset: 3;
        radius: 8.0;
        samples: 16;
        color: "#80000000";
        smooth: true;
        source: container;
    }
}
