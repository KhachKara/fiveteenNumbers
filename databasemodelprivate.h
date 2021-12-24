#pragma once

#include <QObject>
#include <QSqlDatabase>

class DataBaseModelPrivate : public QObject
{
public:
	static const QString DB_NAME;
	static const QString DB_HOSTNAME;
	static const QString DB_TB_PLAYER;
	static const QString DB_TB_RATE;
	static const QString DB_PLAYERS_ID;
	static const QString DB_PLAYERS_NIK;
	static const QString DB_PLAYERS_MAIL;
	static const QString DB_PLAYERS_PASS;
	static const QString DB_RATE_ID;
	static const QString DB_RATE_ID_PLAYER;
	static const QString DB_RATE_STEPS;
	static const QString DB_RATE_TIME;
	static const QString DB_RATE_DATE;

	DataBaseModelPrivate(QObject * parent = nullptr);
	virtual ~DataBaseModelPrivate() = default;
	/* Методы для непосредственной работы с классом
	 * Подключение к базе данных и вставка записей в таблицу
	 * */
	void connectToDataBase();
private:
	/* Внутренние методы для работы с базой данных
	 * */
	bool openDataBase();		// Открытие базы данных
	bool restoreDataBase();		// Восстановление базы данных
	void closeDataBase();		// Закрытие базы данных
	bool createTables();		// Создание базы таблицы в базе данных

public slots:
	bool insertPlayer(const QVariantList &data);
	bool insertPlayer(QString nik, QString mail, QByteArray pass);
	bool insertRate(const QVariantList &data);
	bool insertRate(int idPlayer, int steps, int time, QString date);
private:
	QSqlDatabase db;

};

