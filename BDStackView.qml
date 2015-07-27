import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.1

TabView {
    id: mutliView
    tabsVisible:false
    width: 300
    height: 200
    Component{
        id:tipsView
        BDCenterUI{
            id:chat
            anchors.fill: parent
            Connections {
                id: menuConnection
                ignoreUnknownSignals: true
                target: tipsView
                onSignalLocalSendMsg: {
                }
            }
        }
    }
    style: TabViewStyle {
        frameOverlap: 0
        frame: Item { }
    }
    onCurrentIndexChanged: {
//        btmUI.currentIndex = currentIndex;
//        btmUI.setNumRate(getNumbersRate());
    }
    function getCurrentOpenUrl(){
        var curObj = mutliView.getTab(currentIndex);
        if( typeof  curObj === "object"){
            if(curObj.item === null){
                console.exception("fuck error")
            }else{
                return curObj.item.getcurrentUrl();
            }
        }
    }
    function getNumbersRate(){
        return mutliView.currentIndex+1+"/"+mutliView.count;
    }
    function setCurrentIndex(index){
        console.log("设置当前页面为 "+index);
        if(index> mutliView.count-1 || index <0){
            return;
        }
        mutliView.currentIndex = index;
        btmUI.setNumRate(getNumbersRate());
    }
    //C++信号新建聊天窗口 tmp包括标题 图片链接 内容
    function fromCppInfo(tmp)
    {
        var tipsObj = mutliView.insertTab(mutliView.count,"",tipsView);
        mutliView.currentIndex = mutliView.count-1;
        console.log("tipsObj id: "+tipsObj+" "+tipsObj.item);
        btmUI.currentIndex = mutliView.count-1;
        btmUI.setNumRate(getNumbersRate());
        if( typeof  tipsObj === "object"){
            if(tipsObj.item === null){
                console.exception("fuck error")
            }else{
                tipsObj.item.setUI(tmp);
            }
        }
    }
}

