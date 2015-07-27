import QtQuick 2.0

Rectangle {
    width: 300
    height: 38
    property string moreDetails: "查看更多新闻"
    property alias currentIndex:  rateTxt.currentIndex
    signal signalClickPreNext(int index);
    signal signalOpenUrl(string  url);
    BDPrAndNext{
        id:rateTxt
//        width: parent.width*(3/5)
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: line.left
        anchors.rightMargin: 10
        centerCount: centerUI.count
        onSignalClickPreNextBak: {
            signalClickPreNext(index);
        }
    }
    Rectangle{
        id:line
        width: 1
        anchors.right: detailsTxt.left
        anchors.rightMargin: 10
        height: parent.height/2
        color: "#E8E6E6"
        anchors.verticalCenter: parent.verticalCenter
    }
    Text {
        id: detailsTxt
        text: moreDetails
        font.family: appFont
        font.pointSize: 9
        color: "#D73924"
        focus: true
//        width: parent.width*(2/5)
        anchors.right: parent.right
        anchors.rightMargin: 20
        height: parent.height
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        MouseArea{
            id:moreMa
            anchors.fill: parent
            hoverEnabled: true
            onClicked: {
                var urls = centerUI.getCurrentOpenUrl();
                console.log("------getCurrentOpenUrl------ "+urls);
                Qt.openUrlExternally(urls);
            }
            onEntered: {
                cursorShape = Qt.PointingHandCursor;
            }
            onExited: {
                cursorShape = Qt.ArrowCursor;
            }
        }
    }

    function setNumRate(str){
        rateTxt.numTxts = str;
    }
}

