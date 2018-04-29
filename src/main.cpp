#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QApplication>
#include "krudio.h"
#include "krudio_icon.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QApplication app(argc, argv);
    qmlRegisterType<krudio>("cpp.krudio", 2, 0, "Krudio");
    QQmlApplicationEngine engine;
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    krudio_icon kicon;

    return app.exec();
}
