#include <QApplication>
#include <QQuickWidget>
#include "bdtipsview.h"
#include "ddquickview.h"
#include "echoclient.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    YbQuickView *view = new YbQuickView;
    view->setFlags(Qt::FramelessWindowHint|Qt::WindowStaysOnTopHint/*|Qt::Window*/);
    EchoClient client(QUrl(QStringLiteral("ws://localhost:1234")));
    QObject::connect(&client, &EchoClient::signalReceive, view, &YbQuickView::slotSetWsInfo);
    view->setSource(QUrl("qrc:/main.qml"));
    view->setqmlObject();
    return app.exec();
}
