#ifndef KRUDIOQML_H
#define KRUDIOQML_H

#include <QObject>
#include <QDebug>
#include <QString>
#include <QSystemTrayIcon>
#include <QIcon>
#include <QFile>
#include <QCoreApplication>
#include <QJsonDocument>
#include <QMenu>
#include <QDesktopServices>
#include <QUrl>
#include <QDir>

class KrudioQml: public QObject
{
    Q_OBJECT
public:
    KrudioQml();
    //Get Settings
    Q_INVOKABLE QString getJson(QString nameJson);
    Q_INVOKABLE void search(QString nameSong);
    Q_INVOKABLE void saveJson(QString nameJson,QString dataJson);

};

#endif // KRUDIOQML_H
