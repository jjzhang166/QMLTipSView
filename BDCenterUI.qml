import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2

Rectangle {
    width: 300
    height: 62
    property string bigTitle: "苍老师笑得很漂亮啊"
    property string imgurl: "file:///C:/Users/Administrator/Desktop/cls.jpg"
    property string contents: "2004年小明读初中的时候就被教英语的女老师Mary给办了，
那是小明的第一次，离现在也有10年的时间了！有没有什么好招数，帮帮小明恢复心里健康"
    property string contentDetails: "【详情】"
    property string moreUrl: "http://www.heilqt.com"
    Text {
        id: title
        width: parent.width-10
        height: 30
        text: bigTitle
        font.family: appFont
        font.pointSize: 11
        color: "#3B4246"
        elide: Text.ElideRight
        anchors.horizontalCenter: parent.horizontalCenter
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
    Row{
        id: layout
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.rightMargin: 16
        anchors.leftMargin: 16
        anchors.top: title.bottom
        anchors.topMargin: 6
        anchors.bottom: parent.bottom
        spacing: 6
        Image {
            source: imgurl
            id:imgId
            width: sourceSize.width>96?96:(sourceSize.width)
            height:sourceSize.height>96?96:(sourceSize.height)
        }
        Text{
            id:contentTxt
            text: contents
            font.family:appFont
            font.pointSize:8
            color: "#8B8B8B"
            focus: true
            wrapMode: Text.WrapAnywhere
            font.wordSpacing:1.0
            clip: true
            elide: Text.ElideRight
            width: parent.width-imgId.width
            height: parent.height
            lineHeight:1.2
        }
    }
    Rectangle{
        anchors.right:layout.right
        anchors.bottom: layout.bottom
        width: 50
        height: 20
        z:20
        Text {
            id: detailsTxt
            text: contentDetails
            anchors.fill: parent
            font.family:appFont
            font.pointSize: 9
            color: "#D73924"
            focus: true
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
        }
        MouseArea{
            id:moreMa
            anchors.fill: parent
            hoverEnabled: true
            onClicked: {
                console.log("------getCurrentOpenUrl------ "+moreUrl);
                Qt.openUrlExternally(moreUrl);
            }
            onEntered: {
                cursorShape = Qt.PointingHandCursor;
            }
            onExited: {
                cursorShape = Qt.ArrowCursor;
            }
        }
    }

    function setUI(varinfo){
        console.log("get socket information;;; "+varinfo);
        var obj = changeToJson(varinfo[0]);
        if(typeof obj=='object'){
            bigTitle = obj.mSmlTitle;
            imgurl = obj.mImgURL;
            contents = obj.htmlContents;
            moreUrl = obj.mDialURL;
            topUI.appTitle = obj.mTitle;
            update();
        }
    }
    function getcurrentUrl(){
        return moreUrl;
    }
    function changeToJson(str){
        return eval('('+str+')');
    }
}

