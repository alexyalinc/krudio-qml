#include "krudio.h"

krudio::krudio(QObject *parent) : QObject(parent)
{
}


void krudio::saveSetting(const QString &json) {

//QObject* stations = this->parent()->findChild<QObject*>("stations");
//qDebug() << msg + stations->property("text");

    qDebug() << json;
}

QVariant krudio::pathToApp() {
    QDir dir(".");
    return   dir.absolutePath();
}

QVariant krudio::getJson(QString opts) {
    QDir dir(".");
    QString path;
    opts=(opts=="category")?"stations":opts;
    if(opts=="stations"){
        path="/usr/share/krudio-qml/data/database.json";
    }else if(opts=="favourites"){
        path="/usr/share/krudio-qml/data/favourites.json";
    }

    QFile file(path);
    if(!file.open(QIODevice::ReadOnly)) {
        qDebug() << file.errorString();
    }

    QTextStream in(&file);
    QString json;
    while(!in.atEnd()) {
        QString line = in.readLine();
        json +=line.toUtf8();
    }
    file.close();
    return json;

}
void krudio::saveJson(QString dataJson,QString opts) {
    QDir dir(".");
    QString path;
    opts=(opts=="category")?"stations":opts;
    if(opts=="stations"){
        path="/usr/share/krudio-qml/data/database.json";
    }else if(opts=="favourites"){
        path="/usr/share/krudio-qml/data/favourites.json";
    }
    QFile file(path);
    if(!file.open(QIODevice::WriteOnly)) {
        qDebug() << file.errorString();
    }

    QByteArray array (dataJson.toStdString().c_str());\
    file.write(array);
    file.close();
}

void krudio::search(QString nameSong){
    if(nameSong != "" && nameSong != tr("Loading...")){
        QString link = "https://www.google.ru/search?q="+nameSong;
        QDesktopServices::openUrl(QUrl(link));
    }
}
