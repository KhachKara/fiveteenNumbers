#include "databasemodelprivate.h"

#include <QDebug>
#include <QFile>
#include <QSqlError>
#include <QSqlQuery>

const QString DataBaseModelPrivate::DB_NAME = "database.db";
const QString DataBaseModelPrivate::DB_HOSTNAME = "DataBase";
const QString DataBaseModelPrivate::DB_TB_PLAYER = "Player";
const QString DataBaseModelPrivate::DB_TB_RATE = "Rate";
const QString DataBaseModelPrivate::DB_PLAYERS_ID = "id";
const QString DataBaseModelPrivate::DB_PLAYERS_NIK = "nik";
const QString DataBaseModelPrivate::DB_PLAYERS_MAIL = "mail";
const QString DataBaseModelPrivate::DB_PLAYERS_PASS = "password";
const QString DataBaseModelPrivate::DB_RATE_ID = "id";
const QString DataBaseModelPrivate::DB_RATE_ID_PLAYER = "idPlayer";
const QString DataBaseModelPrivate::DB_RATE_STEPS = "steps";
const QString DataBaseModelPrivate::DB_RATE_TIME = "time";
const QString DataBaseModelPrivate::DB_RATE_DATE = "date";

DataBaseModelPrivate::DataBaseModelPrivate(QObject *parent) : QObject(parent)
{
}

/* Методы для подключения к базе данных
 * */
void DataBaseModelPrivate::connectToDataBase()
{
	/* Перед подключением к базе данных производим проверку на её существование.
	 * В зависимости от результата производим открытие базы данных или её восстановление
	 * */
	if(!QFile(DB_NAME).exists()){
		this->restoreDataBase();
	} else {
		this->openDataBase();
	}
}

/* Методы восстановления базы данных
 * */
bool DataBaseModelPrivate::restoreDataBase()
{
	// Если база данных открылась ...
	if(this->openDataBase()){
		// Производим восстановление базы данных
		return (this->createTables()) ? true : false;
	} else {
		qDebug() << "Can't open database";
		return false;
	}
	return false;
}

/* Метод для открытия базы данных
 * */
bool DataBaseModelPrivate::openDataBase()
{
	/* База данных открывается по заданному пути
	 * и имени базы данных, если она существует
	 * */
	db = QSqlDatabase::addDatabase("QSQLITE");
	db.setHostName(DB_HOSTNAME);
	db.setDatabaseName(DB_NAME);
	if(db.open()){
		return true;
	} else {
		return false;
	}
}

/* Методы закрытия базы данных
 * */
void DataBaseModelPrivate::closeDataBase()
{
	db.close();
}

/* Метод для создания таблиц в базе данных
 * */
bool DataBaseModelPrivate::createTables()
{
	/* В данном случае используется формирование сырого SQL-запроса
	 * с последующим его выполнением.
	 * */
	QSqlQuery query;
	QString qPlayer = QString(
				"CREATE TABLE IF NOT EXISTS %1 ("
					"%2 INTEGER PRIMARY KEY AUTOINCREMENT, "
					"%3 TEXT NOT NULL, "
					"%4 TEXT NOT NULL, "
					"%5 TEXT NOT NULL"
				  ")")
			.arg(DB_TB_PLAYER,
				 DB_PLAYERS_ID,
				 DB_PLAYERS_NIK,
				 DB_PLAYERS_MAIL,
				 DB_PLAYERS_PASS);
	if (!query.exec(qPlayer)) {
		qDebug() << QString("%1:%2").arg(__FILE__).arg(__LINE__)
				 << query.lastError().text();
		qDebug() << query.lastQuery();
		return false;
	}
	QString qRate = QString(
				"CREATE TABLE IF NOT EXISTS %1 ("
					"%2 INTEGER PRIMARY KEY AUTOINCREMENT, "
					"%3 INTEGER NOT NULL, "
					"%4 INTEGER NOT NULL, "
					"%5 INTEGER NOT NULL, "
					"%6 TEXT NOT NULL,"
					"%7 FOREIGN KEY (%3) REFERENCES %8(%9)"
				")")
			.arg(DB_TB_RATE,
				 DB_RATE_ID,
				 DB_RATE_ID_PLAYER,
				 DB_RATE_STEPS,
				 DB_RATE_TIME,
				 DB_RATE_DATE,
				 DB_TB_PLAYER,
				 DB_PLAYERS_ID);
	if (!query.exec(qRate)) {
		qDebug() << QString("%1:%2").arg(__FILE__).arg(__LINE__)
				 << query.lastError().text();
		qDebug() << query.lastQuery();
		return false;
	}
	return true;
}

/* Метод для вставки записи в базу данных
 * */
bool DataBaseModelPrivate::insertPlayer(const QVariantList &data)
{
	/* Запрос SQL формируется из QVariantList,
	 * в который передаются данные для вставки в таблицу.
	 * */
	QSqlQuery query;

	QString q = QString("INSERT INTO %1 ( %2, %3, %4)")
			.arg(DB_TB_PLAYER,
				 data[0].toString(),
				 data[1].toString(),
				 data[2].toString());
	if(!query.exec(q)){
		qDebug() << QString("%1:%2").arg(__FILE__).arg(__LINE__)
				 << query.lastError().text();
		qDebug() << query.lastQuery();
		return false;
	}
	return true;
}

bool DataBaseModelPrivate::insertPlayer(QString nik, QString mail, QByteArray pass)
{
	return insertPlayer(QVariantList({nik, mail, pass}));
}

bool DataBaseModelPrivate::insertRate(const QVariantList &data)
{
	QSqlQuery query;

	QString q = QString("INSERT INTO %1 ( %2, %3, %4, %5)")
			.arg(DB_TB_RATE,
				 data[0].toString(),
				 data[1].toString(),
				 data[2].toString(),
				 data[3].toString());
	if(!query.exec(q)){
		qDebug() << QString("%1:%2").arg(__FILE__).arg(__LINE__)
				 << query.lastError().text();
		qDebug() << query.lastQuery();
		return false;
	}
	return true;
}

bool DataBaseModelPrivate::insertRate(int idPlayer, int steps, int time, QString date)
{
	return insertRate(QVariantList({QString(idPlayer), QString(steps), QString(time), date}));
}
