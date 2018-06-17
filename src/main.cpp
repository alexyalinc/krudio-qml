#include <QApplication>
#include <QQmlApplicationEngine>
#include "krudioqml.h"
#include "krudioqmltray.h"

int main(int argc, char *argv[])
{


    qmlRegisterType<KrudioQml>("krudioqml", 1, 0, "KrudioQml");
    qmlRegisterType<KrudioQmlTray>("krudioqmltray", 1, 0, "KrudioQmlTray");
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QApplication app(argc, argv);
    KrudioQml *krudioqmlApp;
    QQmlApplicationEngine engine;
    QObject::connect(&engine, &QQmlApplicationEngine::quit, &app, &QGuiApplication::quit);

    app.setWindowIcon(QIcon(":/src/icons/krudio-qml.svg"));
    engine.load(QUrl(QStringLiteral("qrc:/src/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
