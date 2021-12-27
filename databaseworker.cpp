#include "databaseworker.h"
#include "myfunc.h"

#include <QCryptographicHash>
#include <QDebug>
#include <QFile>
#include <QSqlError>
#include <QSqlQuery>

const QString DataBaseWorker::ITEM_NAME = "DataBaseWorker";
const bool DataBaseWorker::IS_QML_REG = My::qmlRegisterType<DataBaseWorker>
													(DataBaseWorker::ITEM_NAME);

const QString DataBaseWorker::DB_NAME = "database.db";
const QString DataBaseWorker::DB_HOSTNAME = "DataBase";
const QString DataBaseWorker::DB_TB_PLAYER = "Player";
const QString DataBaseWorker::DB_TB_RATE = "Rate";
const QString DataBaseWorker::DB_PLAYERS_ID = "id";
const QString DataBaseWorker::DB_PLAYERS_LOGIN = "login";
const QString DataBaseWorker::DB_PLAYERS_MAIL = "mail";
const QString DataBaseWorker::DB_PLAYERS_PASS = "password";
const QString DataBaseWorker::DB_RATE_ID = "id";
const QString DataBaseWorker::DB_RATE_ID_PLAYER = "idPlayer";
const QString DataBaseWorker::DB_RATE_STEPS = "steps";
const QString DataBaseWorker::DB_RATE_TIME = "time";
const QString DataBaseWorker::DB_RATE_DATE = "date";

QString DataBaseWorker::queryRate()
{
	return QString("SELECT %1, %2, %3 FROM %4 INNER JOIN %5 on %5.%6 = %4.%7 ORDER BY ")
			.arg(DB_PLAYERS_LOGIN, DB_RATE_STEPS, DB_RATE_TIME,
				 DB_TB_RATE, DB_TB_PLAYER, DB_PLAYERS_ID, DB_RATE_ID_PLAYER);
}

DataBaseWorker::DataBaseWorker(QObject *parent) : QObject(parent)
{
	connectToDataBase();
}

/* Методы для подключения к базе данных
 * */
void DataBaseWorker::connectToDataBase()
{
	/* Перед подключением к базе данных производим проверку на её существование.
	 * В зависимости от результата производим открытие базы данных или её восстановление
	 * */
	if(!QFile(DB_NAME).exists()){
		restoreDataBase();
	} else {
		openDataBase();
	}
}

bool DataBaseWorker::registerPlayer(QString login, QString mail, QString pass)
{
	return insertPlayer(login, mail,
						QString(QCryptographicHash::hash(pass.toLatin1(), QCryptographicHash::Sha256).toHex()));
}

int DataBaseWorker::checkPass(QString login, QString pass)
{
	QString qFindPlayer = QString("SELECT %1, %2 FROM %3 WHERE %4 = '%5'")
			.arg(DB_PLAYERS_ID, DB_PLAYERS_PASS, DB_TB_PLAYER, DB_PLAYERS_LOGIN, login);
	QSqlQuery query(qFindPlayer);
	if (!query.next()) {
		qDebug() << __FILE__ << __LINE__ << "Can't find login:" << login;
		return -1;
	}
	auto sha = QString(QCryptographicHash::hash(pass.toLatin1(), QCryptographicHash::Sha256).toHex());

	if (sha != query.value(DB_PLAYERS_PASS).toString()) {
		qDebug() << __FILE__ << __LINE__ << "The password is incorrect";
		return -2;
	}
	return query.value(DB_PLAYERS_ID).toInt();
}

/* Методы восстановления базы данных
 * */
bool DataBaseWorker::restoreDataBase()
{
	// Если база данных открылась ...
	if (openDataBase()) {
		// Производим восстановление базы данных
		return (createTables()) ? true : false;
	} else {
		qDebug() << "Can't open database";
		return false;
	}
	return false;
}

/* Метод для открытия базы данных
 * */
bool DataBaseWorker::openDataBase()
{
	/* База данных открывается по заданному пути
	 * и имени базы данных, если она существует
	 * */
	db = QSqlDatabase::addDatabase("QSQLITE");
	db.setHostName(DB_HOSTNAME);
	db.setDatabaseName(DB_NAME);
	return db.open();
}

/* Методы закрытия базы данных
 * */
void DataBaseWorker::closeDataBase()
{
	db.close();
}

/* Метод для создания таблиц в базе данных
 * */
bool DataBaseWorker::createTables()
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
				 DB_PLAYERS_LOGIN,
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
					"%6 TEXT NOT NULL, "
					"FOREIGN KEY (%3) REFERENCES %7(%8)"
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

bool DataBaseWorker::insertPlayer(const QVariantList &data)
{
	QSqlQuery query;
	QString qCheck = QString("SELECT %1 FROM %2 WHERE %1 = '%3'");

	// Проверка на оригинальность логина
	query.exec(qCheck.arg(DB_PLAYERS_LOGIN, DB_TB_PLAYER, data.at(0).toString()));
	if (query.next()) {
		qDebug() << __FILE__ << __LINE__ << "Login exist" << data.at(0).toString();
		return false;
	}

	// Проверка на ригинальность почты
	query.exec(qCheck.arg(DB_PLAYERS_MAIL, DB_TB_PLAYER, data.at(1).toString()));
	if (query.next()) {
		qDebug() << __FILE__ << __LINE__ << "Mail exist" << data.at(1).toString();
		return false;
	}


	QString qInsert = QString("INSERT INTO %1 (%2, %3, %4) VALUES ('%5', '%6', '%7')")
			.arg(DB_TB_PLAYER,
				 DB_PLAYERS_LOGIN,
				 DB_PLAYERS_MAIL,
				 DB_PLAYERS_PASS,
				 data[0].toString(),
				 data[1].toString(),
				 data[2].toString());
	if(!query.exec(qInsert)) {
		qDebug() << QString("%1:%2").arg(__FILE__).arg(__LINE__)
				 << query.lastError().text();
		qDebug() << query.lastQuery();
		return false;
	}
	return true;
}

bool DataBaseWorker::insertPlayer(QString login, QString mail, QString pass)
{
	return insertPlayer(QVariantList({login, mail, pass}));
}

bool DataBaseWorker::insertRate(const QVariantList &data)
{
	QSqlQuery query;

	QString q = QString("INSERT INTO %1 ( %2, %3, %4, %5)")
			.arg(DB_TB_RATE,
				 data[0].toString(),
				 data[1].toString(),
				 data[2].toString(),
				 data[3].toString());
	if(!query.exec(q)) {
		qDebug() << QString("%1:%2").arg(__FILE__).arg(__LINE__)
				 << query.lastError().text();
		qDebug() << query.lastQuery();
		return false;
	}
	return true;
}

bool DataBaseWorker::insertRate(int idPlayer, int steps, int time, QString date)
{
	return insertRate(QVariantList({QString(idPlayer), QString(steps), QString(time), date}));
}
