#include "ddquickview.h"

YbQuickView::YbQuickView(QQuickView *parent) :
    QQuickView(parent),finishedhideAni(true),finishedshowAni(true),isMax(false)
{
    isLeftPressDown = false;
    isZhiding = true;
    isHide = false;
    isHasMouseEvent = true;
    beginY = QApplication::desktop()->height();

    //初始化为未按下鼠标左键
    this->setColor(Qt::transparent);
    setResizeMode(QQuickView::SizeRootObjectToView);
    QQuickWindow::setDefaultAlphaBuffer(true);
    mouse_press = false;
    setFlags(Qt::FramelessWindowHint|Qt::WindowStaysOnTopHint|Qt::Window);
    iHeight = 700;
    timerShow=new QTimer(this);
    connect(timerShow,SIGNAL(timeout()),this,SLOT(myMove()));
    timerStay=new QTimer(this);
    connect(timerStay,SIGNAL(timeout()),this,SLOT(myStay()));
    timerClose=new QTimer(this);
    connect(timerClose,SIGNAL(timeout()),this,SLOT(myClose()));
}

YbQuickView::~YbQuickView()
{
}

void YbQuickView::setMaxYbView(QSize size)
{
    this->setMaximumSize(size);
}

void YbQuickView::setHasMouse(bool isHasMouse)
{
        isZhiding = isHasMouse;
}
void YbQuickView::mouseReleaseEvent(QMouseEvent *event)
{
    mouse_press = false;
    QQuickView::mouseReleaseEvent(event);
}

void YbQuickView::mousePressEvent(QMouseEvent *event)
{
    //只能是鼠标左键移动和改变大小
    if(event->button() == Qt::LeftButton)
    {
        mouse_press = true;
    }
    //窗口移动距离
    move_point = event->globalPos() - this->position();
    QQuickView::mousePressEvent(event);
}

void YbQuickView::mouseDoubleClickEvent(QMouseEvent *event)
{
    QRect rect(10,2,this->width()-70,100);
    QQuickView::mouseDoubleClickEvent(event);
}
void YbQuickView::mouseMoveEvent(QMouseEvent *event)
{   
    //移动窗口
    if(mouse_press)
    {
        QPoint move_pos = event->globalPos();
        setPosition(move_pos - move_point);
    }
    QQuickView::mouseMoveEvent(event);
}

void YbQuickView::slotFinishedAnimation1()
{
    if(group2){
     group2->deleteLater();
     group2 = NULL;
    }
}

void YbQuickView::slotFinishedAnimation2()
{
    if(group3){
     group3->deleteLater();
     group3 = NULL;
    }
    qApp->quit();
}

void YbQuickView::slotfromqml(QVariant iType, QString msg)
{
    Q_UNUSED(msg)
    int type = iType.toInt();
    switch (type) {
    case 0:
           startCloseWindow();
        break;
    case 1:

        break;
    case 2:

        break;
    default:
        break;
    }
}

void YbQuickView::setqmlObject()
{
    qml_object = rootObject();
    if(!qml_object){
        qDebug("get qml_object");
    }
    connect(qml_object,SIGNAL(signalOption(QVariant,QString)),this,SLOT(slotfromqml(QVariant,QString)));
}

void YbQuickView::startCloseWindow()
{
    group3 = new QParallelAnimationGroup;
    connect(group3,SIGNAL(finished()),this,SLOT(slotFinishedAnimation2()));
    QPropertyAnimation *animation = new QPropertyAnimation(this, "height");
    animation->setDuration(500);
    animation->setStartValue(this->height());
    animation->setEndValue(0);

    QPropertyAnimation *animation3 = new QPropertyAnimation(this, "opacity");
    animation3->setDuration(400);
    animation3->setStartValue(1.0);
    animation3->setEndValue(0.0);

    group3->addAnimation(animation3);
    animation->setEasingCurve(QEasingCurve::Linear);
    group3->start();
}

void YbQuickView::showQmlWindow()
{
    group2 = new QParallelAnimationGroup;
    connect(group2,SIGNAL(finished()),this,SLOT(slotFinishedAnimation1()));
    QPropertyAnimation *animation = new QPropertyAnimation(this, "height");
    animation->setDuration(200);
    animation->setStartValue((24));
    animation->setEndValue(iHeight);

    QPropertyAnimation *animation3 = new QPropertyAnimation(this, "opacity");
    animation3->setDuration(500);
    animation3->setStartValue(0.8);
    animation3->setEndValue(1.0);

//    group2->addAnimation(animation);
    group2->addAnimation(animation3);
    animation->setEasingCurve(QEasingCurve::InOutQuad);
    group2->start();
}

void YbQuickView::slotSetInfoToQML(int iType,const QStringList &msg)
{
    QVariant varMsg(msg);
    int type = iType;
    if(qml_object){
       QMetaObject::invokeMethod(qml_object, "setTipsInformation",Qt::DirectConnection,
                              Q_ARG(QVariant, QVariant::fromValue(type)),
                              Q_ARG(QVariant, varMsg));
    }
    showTipsView();
}
void YbQuickView::showTipsView()
{
    qDebug()<<"this obj status is "<<this->flags();
//    setVisible(true);
//    showNormal();
    requestActivate();
    QDesktopWidget *deskTop=QApplication::desktop();
    deskRect=deskTop->availableGeometry();
    beginY = QApplication::desktop()->height();
    normalPoint.setX(deskRect.width()-this->width());
    normalPoint.setY(deskRect.height()-this->height());
    setPosition(normalPoint.x(),768-1);
    show();
    timerShow->start(5);
}

void YbQuickView::myMove()
{
    show();
    beginY -=10;
    setPosition(normalPoint.x(),beginY);
    if(beginY<=normalPoint.y()){
         timerShow->stop();
         timerStay->start(1000);
         setFlags(Qt::FramelessWindowHint|Qt::WindowStaysOnTopHint/*|Qt::Window*/);
    }
}

void YbQuickView::myStay()
{
    static int timeCount=0;
    timeCount++;
    if(timeCount>=9){
        timerStay->stop();
    }
}
void YbQuickView::myClose()
{
}
///
/// \brief YbQuickView::slotSetWsInfo
/// \param lst
///接收ws服务端的推送消息
///
void YbQuickView::slotSetWsInfo(const QString &lst)
{
    QStringList tmp;
    tmp.clear();
    tmp.append(lst);
    slotSetInfoToQML(0,tmp);
}
