#ifndef KRUDIOTRAYICON_H
#define KRUDIOTRAYICON_H


#include <QWidget>
#include <QDialog>
#include <QMenu>
#include <QSystemTrayIcon>

class KrudioTrayIcon: public QWidget
{
    Q_OBJECT
public:
    KrudioTrayIcon();

    void createTrayIcon();
private:
    QSystemTrayIcon *trayIcon;
    QMenu *trayIconMenu;
    QWidget *trayIconWitget;
public slots:
    void quit(){quit();}
};

#endif // KRUDIOTRAYICON_H

