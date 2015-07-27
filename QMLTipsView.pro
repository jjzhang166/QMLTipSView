
TEMPLATE = app
TARGET = BDTipsView

QT += core qml quick widgets quickwidgets websockets

SOURCES += main.cpp \
    ddquickview.cpp \
    echoclient.cpp

CONFIG += C++11
RESOURCES += qml.qrc \
    imgrc.qrc

HEADERS += \
    ddquickview.h \
    echoclient.h

FORMS += \
    bdtipsview.ui
