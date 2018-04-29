#include "krudio_icon.h"

#ifndef QT_NO_SYSTEMTRAYICON

krudio_icon::krudio_icon()
{

    createTrayIcon();

}

void krudio_icon::closeEvent(QCloseEvent *event)
{
    emit signalClose();
    qApp->closeAllWindows();
    event->accept();
}

void krudio_icon::setTrayIcon(int size,int color,bool enable)
{
    switch (size) {
    case 0:
        size=16;
        break;
    case 1:
        size=22;
        break;
    case 2:
        size=24;
        break;
    }
    QString colorStr;
    switch (color) {
    case 0:
        colorStr="dark";
        break;
    case 1:
        colorStr="light";
        break;
    }
    QString enableStr;
    if(enable) {
        enableStr="on";
    }else{
        enableStr="off";
    }
    QIcon icon(QIcon(":/icons/krudiotray-"+colorStr+"-"+enableStr+QString::number(size)+".svg").pixmap(size,size));
    trayIcon->setIcon(icon);
}

void krudio_icon::createTrayIcon()
{
    trayIconMenu = new QMenu(this);
    trayIconMenu->addAction("Exit");

    trayIcon = new QSystemTrayIcon(this);
    trayIcon->setContextMenu(trayIconMenu);
    setTrayIcon(0,1,false);
    trayIcon->show();
}

#endif
