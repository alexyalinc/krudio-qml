#include "krudiotrayicon.h"

KrudioTrayIcon::KrudioTrayIcon()
{
    createTrayIcon();
}



void KrudioTrayIcon::createTrayIcon()
{
    trayIconMenu = new QMenu(trayIconWitget);
    trayIconMenu->addAction("Exit", this, SLOT(quit()));
    trayIcon = new QSystemTrayIcon(trayIconWitget);
    trayIcon->setContextMenu(trayIconMenu);
    trayIcon->setIcon(QIcon(":/src/icons/krudio-qml.svg").pixmap(32,32));
    trayIcon->setVisible(true);
    trayIcon->show();
}


