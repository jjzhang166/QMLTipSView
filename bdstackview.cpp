#include "bdstackview.h"

BDStackView::BDStackView(QWidget *parent)
{
    this->resize(310,210);
    newQmlView(QStringList(""));
}

BDStackView::~BDStackView()
{

}
void BDStackView::newQmlView(const QStringList &lstInfo)
{
    QQuickWidget *view = new QQuickWidget;
    view->setSource(QUrl::fromLocalFile("./main.qml"));
    this->addWidget(view);
    view->show();
}
