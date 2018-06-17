#include "krudioqml.h"

KrudioQml::KrudioQml()
{
}

//Get Json
QString KrudioQml::getJson(QString nameJson){
    QString dataJson;
    QFile settingFile("/usr/share/krudio-qml/data/" + nameJson +".json");
    settingFile.open(QIODevice::ReadOnly | QIODevice::Text);
    dataJson = settingFile.readAll();
    settingFile.close();
    QJsonDocument jsonDocument = QJsonDocument::fromJson(dataJson.toUtf8());
    return QString(jsonDocument.toJson());
}

//Save Json
void KrudioQml::saveJson(QString nameJson, QString dataJson){
    QJsonDocument doc = QJsonDocument::fromJson(dataJson.toUtf8());
    QFile settingFile("/usr/share/krudio-qml/data/" + nameJson +".json");
    settingFile.open(QIODevice::WriteOnly | QIODevice::Text | QFile::Truncate);
    settingFile.write(doc.toJson());
    settingFile.close();
}

//Search
void KrudioQml::search(QString nameSong){
    if(nameSong != ""){
        QString link = "https://www.google.ru/search?q="+nameSong;
        QDesktopServices::openUrl(QUrl(link));
    }
}
