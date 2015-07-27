#ifndef BDSTACKVIEW_H
#define BDSTACKVIEW_H

#include <QStackedWidget>
#include <QQuickWidget>

class BDStackView : public QStackedWidget
{
      Q_OBJECT
public:
    BDStackView(QWidget *parent = 0);
    ~BDStackView();

    void newQmlView(const QStringList& lstInfo);
};

#endif // BDSTACKVIEW_H
