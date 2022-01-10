#include "core.h"
#include "myfunc.h"
#include "userdata.h"
#include <QDebug>

const QString Core::ITEM_NAME = "Core";
const bool Core::IS_QML_REG = My::qmlRegisterType<Core>
													(Core::ITEM_NAME);

Core::Core(QObject *parent)
	: QObject(parent)
	, _db(new DataBaseWorker(parent))
	, _model(new DataBaseModel(parent))
{
	if (UserData::isSignIn()) {
		auto code = checkAccount(UserData::getLogin(), UserData::getHash());

		switch (code) {
		case DataBaseWorker::ERROR_LOGIN:
		case DataBaseWorker::ERROR_PASSWORD:
			UserData::signOut();
			break;
		default:
			qDebug() << QString("Sign in to account: %1").arg(login());
		}
	}
}

DataBaseModel *Core::model() const
{
	return _model;
}

bool Core::isSignIn() const
{
	return _idPlayer != ID_NONE;
}

bool Core::registerPlayer(QString login, QString pass, QString mail)
{
	if (!_db->registerPlayer(login, pass, mail)) {
		return false;
	}
	signIn(login, pass);
	return true;
}

bool Core::checkLogin(QString login) const
{
	return _db->checkLogin(login);
}

int Core::signIn(QString login, QString pass)
{
	setIdPlayer(_db->checkPass(login, pass));
	setLogin(isSignIn() ? login : QString());
	if (isSignIn()) {
		UserData::signIn(login, DataBaseWorker::getHash(pass));
	} else {
		UserData::signOut();
	}
	return idPlayer();
}

void Core::signOut()
{
	setIdPlayer(ID_NONE);
	setLogin(QString());
	UserData::signOut();
}

bool Core::addResult(int sizeArea, int steps, int time, QString date)
{
	if (!isSignIn()) {
		qDebug() << QString("%1:%2").arg(__FILE__).arg(__LINE__) << "must reg or sign in";
		return false;
	}
	auto r = _db->addResult(idPlayer(), sizeArea, steps, time, date);
	_model->updateModel(sizeArea);
	return r;
}

bool Core::existRecoveryGame() const
{
	return UserData::hasContinueGame();
}

void Core::saveGame(QString area, int steps, int timeSec) const
{
	UserData::saveGame(area, steps, timeSec);
}

void Core::saveTimeSec(int timeSec) const
{
	UserData::saveTime(timeSec);
}

void Core::removeGame() const
{
	UserData::removeGame();
}

QString Core::recoveryArea() const
{
	return UserData::getArea();
}

int Core::recoverySteps() const
{
	return UserData::getSteps();
}

int Core::recoveryTimeSec() const
{
	return UserData::getTimeSec();
}

const QString &Core::login() const
{
	return _login;
}

void Core::setLogin(const QString &newLogin)
{
	if (_login == newLogin)
		return;
	_login = newLogin;
	emit loginChanged();
}

int Core::checkAccount(QString login, QString hash)
{
	setIdPlayer(_db->checkHash(login, hash));
	setLogin(isSignIn() ? login : QString());
	return idPlayer();
}

int Core::idPlayer() const
{
	return _idPlayer;
}

void Core::setIdPlayer(int newIdPlayer)
{
	if (_idPlayer == newIdPlayer)
		return;
	bool registratedChanged = _idPlayer == ID_NONE || newIdPlayer == ID_NONE;
	_idPlayer = newIdPlayer;
	emit idPlayerChanged();
	if (registratedChanged)
		emit isSignInChanged();
}
