#include "core.h"
#include "myfunc.h"

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
	_idPlayer = checkPass(login, pass);
	return true;
}

int Core::checkPass(QString login, QString pass)
{
	_idPlayer = _db->checkPass(login, pass);
	return _idPlayer;
}
