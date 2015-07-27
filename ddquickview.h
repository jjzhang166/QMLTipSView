#ifndef YBQUICKVIEW_H
#define YBQUICKVIEW_H

#include <QQuickView>
#include <QMouseEvent>
#include <QDesktopWidget>
#include <QPoint>
#include <QCursor>
#include <QRect>
#include <QPainter>
#include <QPaintEvent>
#include <QDebug>
#include <QEvent>
#include <QParallelAnimationGroup>
#include <QPropertyAnimation>
#include <QApplication>
#include <QQuickItem>
#include <QTimer>
#include <QJsonParseError>
#include <QJsonObject>

#define PADDING 5
class YbQuickView : public QQuickView
{
    Q_OBJECT
public:
    explicit YbQuickView(QQuickView *parent = 0);
    ~YbQuickView();

    void setMaxYbView(QSize);
    void setHasMouse(bool isHasMouse);

    bool isHasMouseEvent;
    bool finishedhideAni;
    bool isHide;
    bool isZhiding;
    bool isMax;

    bool finishedshowAni;
    int iHeight;
    QParallelAnimationGroup* group;
    QParallelAnimationGroup* group2;
    QParallelAnimationGroup* group3;
    QParallelAnimationGroup* group4;

    QTimer *timerShow;//平滑显示的定时器
    QTimer *timerStay;//停留时间的定时器 10s
    QTimer *timerClose;//关闭淡出的定时器
    int beginY;

    QObject* qml_object;
protected:
    void mouseReleaseEvent(QMouseEvent *event);
    void mouseMoveEvent(QMouseEvent *event);
    void mousePressEvent(QMouseEvent *event);
    void mouseDoubleClickEvent(QMouseEvent *event);
private:
    bool isLeftPressDown;
    QPoint dragPosition;
    bool canMove;

    QPoint move_point; //移动的距离
    bool mouse_press;  //按下鼠标左键
    QPoint normalPoint;//完全显示时左上角位置
    QRect deskRect;
public slots:
    void slotFinishedAnimation1();
    void slotFinishedAnimation2();
    void slotfromqml(QVariant, QString);
    void setqmlObject();
    void startCloseWindow();
    void showQmlWindow();

    void slotSetInfoToQML(int iType, const QStringList &msg);

    void myMove();
    void myStay();
    void myClose();

    void slotSetWsInfo(const QString &lst);
    void showTipsView();//在右下角显示
};

#endif // YBQUICKVIEW_H
