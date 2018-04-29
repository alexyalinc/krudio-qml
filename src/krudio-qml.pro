QT += qml quick
QT += widgets gui svg
CONFIG += c++11

SOURCES += main.cpp \
    krudio.cpp \
    krudio_icon.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    krudio.h \
    krudio_icon.h
