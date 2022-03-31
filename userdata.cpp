#include "userdata.h"

#include <QSettings>

static const char* GAME = "GAME";
static const char* GAME_AREA = "AREA";
static const char* GAME_STEPS = "STEPS";
static const char* GAME_TIME_SEC = "TIME_SEC";

void UserData::saveGame(QString area, int steps, int timeSec)
{
	QSettings s;
	s.beginGroup(GAME);
	s.setValue(GAME_AREA, area);
	s.setValue(GAME_STEPS, steps);
	s.setValue(GAME_TIME_SEC, timeSec);
	s.endGroup();
}

void UserData::saveTime(int timeSec)
{
	QSettings s;
	s.beginGroup(GAME);
	s.setValue(GAME_TIME_SEC, timeSec);
	s.endGroup();

}

void UserData::removeGame()
{
	QSettings s;
	s.beginGroup(GAME);
	s.setValue(GAME_AREA, QString());
	s.endGroup();
}

bool UserData::hasContinueGame()
{
	QSettings s;
	s.beginGroup(GAME);
	return !s.value(GAME_AREA).toString().isEmpty();
}

QString UserData::getArea()
{
	QSettings s;
	s.beginGroup(GAME);
	return s.value(GAME_AREA).toString();
}

int UserData::getSteps()
{
	QSettings s;
	s.beginGroup(GAME);
	return s.value(GAME_STEPS).toInt();
}

int UserData::getTimeSec()
{
	QSettings s;
	s.beginGroup(GAME);
	return s.value(GAME_TIME_SEC).toInt();
}

