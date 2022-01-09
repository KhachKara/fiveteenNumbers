#include "core.h"
#include "myfunc.h"
#include <QDebug>

const QString Core::ITEM_NAME = "Core";
const bool Core::IS_QML_REG = My::qmlRegisterType<Core>
													(Core::ITEM_NAME);

Core::Core(QObject *parent)
	: QObject(parent)
	, _db(new DataBaseWorker(parent))
	, _model(new DataBaseModel(parent))
{
}

DataBaseModel *Core::model() const
{
	return _model;
}

bool Core::isLogin() const
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
	setLogin(isLogin() ? login : QString());
	return idPlayer();
}

void Core::signOut()
{
	setIdPlayer(ID_NONE);
	setLogin(QString());
}

bool Core::addResult(int sizeArea, int steps, int time, QString date)
{
	if (!isLogin()) {
		qDebug() << QString("%1:%2").arg(__FILE__).arg(__LINE__) << "must reg or sign in";
		return false;
	}
	auto r = _db->addResult(idPlayer(), sizeArea, steps, time, date);
	_model->updateModel(sizeArea);
	return r;
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

bool Core::checkHash(QString login, QString hash) const
{
	return _db->checkHash(login, hash);
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
		emit isLoginChanged();
}
