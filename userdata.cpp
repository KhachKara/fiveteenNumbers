#include "userdata.h"

#include <QSettings>

static const char* AUTH = "AUTHORIZATION";
static const char* AUTH_LOGIN = "LOGIN";
static const char* AUTH_HASH = "HASH";
static const char* GAME = "GAME";
static const char* GAME_AREA = "AREA";
static const char* GAME_STEPS = "STEPS";
static const char* GAME_TIME_SEC = "TIME_SEC";


void UserData::signIn(QString login, QString hash)
{
	QSettings s;
	s.beginGroup(AUTH);
	s.setValue(AUTH_LOGIN, login);
	s.setValue(AUTH_HASH, hash);
	s.endGroup();
}

void UserData::signOut()
{
	QSettings s;
	s.beginGroup(AUTH);
	s.setValue(AUTH_LOGIN, QString());
	s.setValue(AUTH_HASH, QString());
	s.endGroup();
}

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

bool UserData::isSignIn()
{
	QSettings s;
	s.beginGroup(AUTH);
	return !s.value(AUTH_LOGIN).toString().isEmpty();
}

QString UserData::getLogin()
{
	QSettings s;
	s.beginGroup(AUTH);
	return s.value(AUTH_LOGIN).toString();
}

QString UserData::getHash()
{
	QSettings s;
	s.beginGroup(AUTH);
	return s.value(AUTH_HASH).toString();
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

