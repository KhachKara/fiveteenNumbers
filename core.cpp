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

bool Core::registerPlayer(QString login, QString mail, QString pass)
{
	if (!_db->registerPlayer(login, mail, pass)) {
		return false;
	}
	signIn(login, pass);
	return true;
}

int Core::signIn(QString login, QString pass)
{
	setIdPlayer(_db->checkPass(login, pass));
	setLogin(idPlayer() >= 0 ? login : QString());
	return idPlayer();
}

void Core::signOut()
{
	setIdPlayer(-1);
	setLogin(QString());
}

bool Core::addResult(int steps, int time, QString date)
{
	if (idPlayer() < 0) {
		qDebug() << QString("%1:%2").arg(__FILE__).arg(__LINE__) << "must reg or sign in";
		return false;
	}
	auto r = _db->addResult(idPlayer(), steps, time, date);
	_model->updateModel();
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

int Core::idPlayer() const
{
	return _idPlayer;
}

void Core::setIdPlayer(int newIdPlayer)
{
	if (_idPlayer == newIdPlayer)
		return;
	_idPlayer = newIdPlayer;
	emit idPlayerChanged();
}
