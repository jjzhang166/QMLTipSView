import QtQuick 2.0

Rectangle {
    width: 300
    height: 28
    color: Qt.rgba(Math.random(),Math.random(),Math.random(),1.0)//"#CB4949"
    property string appTitle: "大数据金融终端"
    Image {
        id: logoImg
        source: "http://download.easyicon.net/png/1078394/16/" //可以替换成自己的应用logo
        width: 14
        height: 17
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 6
    }
    Text {
        id: title
        width: parent.width/3
        height: parent.height
        anchors.left: logoImg.right
        anchors.leftMargin: 6
        text: appTitle
        font.family:appFont
        font.pointSize: 10
        color: "white"
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
    }
    Image {
        id: closeBtn
        source: ma.containsMouse?"qrc:/images/tfCloP.png":"qrc:/images/tfCloN.png"
        width: 16
        height: 16
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 4
        MouseArea{
            id:ma
            anchors.fill: parent
            onClicked: {
                signalOption(0,"");
            }
        }
    }
}

