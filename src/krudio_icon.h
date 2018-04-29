#ifndef KRUDIO_ICON_H
#define KRUDIO_ICON_H

#include <QtWidgets/QSystemTrayIcon>

#ifndef QT_NO_SYSTEMTRAYICON

#include <QtWidgets>
#include <QApplication>
#include <QCloseEvent>
#include <QIcon>
#include <QString>
#include <QDebug>

class krudio_icon : public QDialog
{
    Q_OBJECT

public:
    krudio_icon();

protected:
    virtual void closeEvent(QCloseEvent *event);
signals:
    void signalClose();
private slots:
    void setTrayIcon(int size,int color,bool enable);

private:
    void createTrayIcon();

    QSystemTrayIcon *trayIcon;
    QMenu *trayIconMenu;
};

#endif // QT_NO_SYSTEMTRAYICON

#endif
