import QtQuick 2.0

Item {
    width: 80
    height: 16
    property int currentIndex: 0
    property int centerCount: 0
    property string numTxts: "1/1"
    signal signalClickPreNextBak(int index);
    signal signalOpenUrl(string  url);
    Row{
        id:rowNextPre
        width: parent.width
        height: parent.height
        spacing: 10
        Image {
            id: pre
            source: "qrc:/images/arrow-8-left.png"
            MouseArea{
                id:txtMa
                anchors.fill: parent
                onClicked: {
                    console.log("左边。。。。。。。"+currentIndex--);
                    if(currentIndex >=centerCount || currentIndex <0){
                        currentIndex = 0;
                        opacity = 0.7;
                        return;
                    }
                    opacity = 1.0;
                    signalClickPreNextBak(currentIndex);
                }
            }
        }
        Text {
            id: numTxt
            text: numTxts
            font.family: appFont
            font.pointSize: 9
            color: "#3B4246"
            focus: true
            height: parent.height
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
        }
        Image {
            id: next
            source: "qrc:/images/arrow-8-right.png"
            MouseArea{
                id:txtMa2
                anchors.fill: parent
                onClicked: {
                    console.log("右边。。。。。。。"+currentIndex++);
                    if(currentIndex >= centerCount || currentIndex <0){
                        currentIndex = centerCount-1;
                        opacity = 0.7;
                        return;
                    }
                    opacity = 1.0;
                    signalClickPreNextBak(currentIndex);
                }
            }
        }
    }
}

