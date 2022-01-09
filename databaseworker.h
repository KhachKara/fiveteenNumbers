#pragma once

#include <QObject>
#include <QSqlDatabase>

class DataBaseWorker : public QObject
{
	Q_OBJECT
	static const bool _CRYPT_PASS = false;
public:
	static const QString ITEM_NAME;     ///< DataBaseWorker
	static const bool IS_QML_REG;

	static const QString DB_NAME;
	static const QString DB_HOSTNAME;
	static const QString DB_TB_PLAYER;
	static const QString DB_TB_RATE;
	static const QString DB_PLAYERS_ID;
	static const QString DB_PLAYERS_LOGIN;
	static const QString DB_PLAYERS_MAIL;
	static const QString DB_PLAYERS_PASS;
	static const QString DB_RATE_ID;
	static const QString DB_RATE_ID_PLAYER;
	static const QString DB_RATE_SIZE_AREA;
	static const QString DB_RATE_STEPS;
	static const QString DB_RATE_TIME;
	static const QString DB_RATE_DATE;

	/// Возвращает запрос для таблицы: Login, Steprs, Time
	static QString queryRate(int sizeArea);
	static QString getHash(QString pass);

	DataBaseWorker(QObject * parent = nullptr);
	virtual ~DataBaseWorker() = default;

	/// Методы для непосредственной работы с классом
	/// Подключение к базе данных и вставка записей в таблицу
	void connectToDataBase();

public slots:
	/// Регистрация игрока.
	/// true - если добавлена запись в БД
	bool registerPlayer(QString login, QString pass, QString mail = QString());

	bool checkLogin(QString login) const;
	bool checkHash(QString login, QString hash) const;
	/// Проверяет лог и пароль.
	/// Если успешно возвращает индекс пользователя.
	/// Если аккаунт не найден, возвращает -1.
	/// Если пароль не правильный возвращает -2.
	int checkPass(QString login, QString pass);

	/// Добавляет результат игры
	bool addResult(int idPlayer, int sizeArea, int steps, int time, QString date = QString());

private:
	/* Внутренние методы для работы с базой данных
	 * */
	bool openDataBase();		// Открытие базы данных
	bool restoreDataBase();		// Восстановление базы данных
	void closeDataBase();		// Закрытие базы данных
	bool createTables();		// Создание базы таблицы в базе данных

protected slots:
	bool insertPlayer(const QVariantList &data);
	bool insertRate(const QVariantList &data);

private:
	QSqlDatabase db;

};

