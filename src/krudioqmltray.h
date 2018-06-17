#ifndef KRUDIOQMLTRAY_H
#define KRUDIOQMLTRAY_H

#include <QObject>
#include <QDebug>
#include <QString>
#include <QSystemTrayIcon>
#include <QIcon>
#include <QFile>
#include <QCoreApplication>
#include <QJsonDocument>
#include <QMenu>

class KrudioQmlTray: public QObject
{
     Q_OBJECT
public:
    KrudioQmlTray();
    //Tray
    Q_INVOKABLE void tray_setSize(int w,int h);
    Q_INVOKABLE void tray_setIcon(QString path);
    Q_INVOKABLE void tray_setState(bool state);
    Q_INVOKABLE void tray_setColor(bool state);
    Q_INVOKABLE void tray_refresh();
    Q_INVOKABLE void tray_show();
    Q_INVOKABLE void tray_create();
    Q_INVOKABLE void tray_createMenu();
    Q_INVOKABLE void tray_showMessage(QString title,QString message);
    int widthTrayIcon,heightTrayIcon;
    QString pathToIcon;
    Q_INVOKABLE QSystemTrayIcon *icon;
    QMenu *trayMenu;
signals:
    void tray_onClick();
    void tray_onMiddleClick();
    void tray_onExit();
    void tray_showWindow();
private slots:
    void playPause(QSystemTrayIcon::ActivationReason r);
    void quit(){ emit tray_onExit();}
    void show(){ emit tray_showWindow();}
};

#endif // KRUDIOQMLTRAY_H
