#pragma once

#include <QObject>
#include "databaseworker.h"
#include "databasemodel.h"

class Core : public QObject
{
	Q_OBJECT
	Q_PROPERTY(DataBaseModel * model READ model CONSTANT)
	Q_PROPERTY(bool isSignIn READ isSignIn NOTIFY isSignInChanged)
	Q_PROPERTY(int idPlayer READ idPlayer NOTIFY idPlayerChanged)
	Q_PROPERTY(QString login READ login NOTIFY loginChanged)
public:
	static const QString ITEM_NAME;     ///< Core
	static const bool IS_QML_REG;

	Core(QObject *parent = nullptr);

	DataBaseModel *model() const;

	bool isSignIn() const;
	int idPlayer() const;
	void setIdPlayer(int newIdPlayer);

	const QString &login() const;
	void setLogin(const QString &newLogin);
	int checkAccount(QString login, QString hash);

public slots:
	bool registerPlayer(QString login, QString pass, QString mail = QString());
	bool checkLogin(QString login) const;
	int signIn(QString login, QString pass);
	void signOut();
	bool addResult(int sizeArea, int steps, int time, QString date = QString());

	bool existRecoveryGame() const;
	void saveGame(QString area, int steps, int timeSec) const;
	void saveTimeSec(int timeSec) const;
	void removeGame() const;
	QString recoveryArea() const;
	int recoverySteps() const;
	int recoveryTimeSec() const;

signals:
	void isSignInChanged();
	void idPlayerChanged();
	void loginChanged();

private:
	const int ID_NONE = -1;
	DataBaseWorker *_db = nullptr;
	DataBaseModel *_model = nullptr;
	int _idPlayer = ID_NONE;
	QString _login;
};

