#ifndef KRUDIO_H
#define KRUDIO_H

#include <QObject>
#include <QVariant>
#include <QDebug>
#include <iostream>
#include <string>
#include <QString>
#include <QFile>
#include <QTextStream>
#include <QDir>
#include <QDesktopServices>
#include <QUrl>

using namespace std;

class krudio : public QObject
{
    Q_OBJECT
public:
    explicit krudio(QObject *parent = 0);

signals:

public slots:
    void saveSetting(const QString &json);
    Q_INVOKABLE QVariant pathToApp();
    Q_INVOKABLE void     saveJson(QString dataJson,QString opts);
    Q_INVOKABLE QVariant getJson(QString opts);
    Q_INVOKABLE void search(QString nameSong);
};

#endif // KRUDIO_H
