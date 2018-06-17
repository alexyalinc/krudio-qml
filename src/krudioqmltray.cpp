#include "krudioqmltray.h"

KrudioQmlTray::KrudioQmlTray()
{
    tray_create();
    tray_show();

}

//Tray
void KrudioQmlTray::playPause(QSystemTrayIcon::ActivationReason r){
    if(r == 4 ){
        emit tray_onMiddleClick();
    }else{
        emit tray_onClick();
    }
}
void KrudioQmlTray::tray_create(){

    icon = new QSystemTrayIcon;
    connect(icon,SIGNAL(activated(QSystemTrayIcon::ActivationReason)),this,SLOT(playPause(QSystemTrayIcon::ActivationReason)));
    tray_setSize(32,32);
    tray_setIcon(":/src/icons/krudiotray-light-off.svg");
    tray_createMenu();

}

void KrudioQmlTray::tray_createMenu(){
    trayMenu = new QMenu;
    trayMenu->addAction("&Show",this,SLOT(show()));
    trayMenu->addAction("&Exit",this,SLOT(quit()));
    icon->setContextMenu(trayMenu);
}

void KrudioQmlTray::tray_showMessage(QString title,QString message){
    icon->showMessage(title,message,QSystemTrayIcon::Information,5000);
}

void KrudioQmlTray::tray_setSize(int w,int h){
    widthTrayIcon = w;
    heightTrayIcon = h;
    icon->setIcon(QIcon(pathToIcon).pixmap(widthTrayIcon,heightTrayIcon));
}

void KrudioQmlTray::tray_refresh(){
    icon->setIcon(QIcon(pathToIcon).pixmap(widthTrayIcon,heightTrayIcon));
}

void KrudioQmlTray::tray_setState(bool state){
    if(state){
        pathToIcon.replace("-off","-on");
    }else{
        pathToIcon.replace("-on","-off");
    }
    tray_refresh();
}

void KrudioQmlTray::tray_setColor(bool state){
    if(state){
        pathToIcon.replace("-dark","-light");
    }else{
        pathToIcon.replace("-light","-dark");
    }
    tray_refresh();
}

void KrudioQmlTray::tray_setIcon(QString path){

    pathToIcon = path;
    icon->setIcon(QIcon(path).pixmap(widthTrayIcon,heightTrayIcon));

}

void KrudioQmlTray::tray_show(){

    icon->show();

}
