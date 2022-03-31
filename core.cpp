#include "core.h"
#include "myfunc.h"
#include "userdata.h"
#include <QDebug>

const QString Core::ITEM_NAME = "Core";
const bool Core::IS_QML_REG = My::qmlRegisterType<Core>
													(Core::ITEM_NAME);

Core::Core(QObject *parent)
	: QObject(parent)
{
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
