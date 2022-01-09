#pragma once

#include <QString>

class UserData
{
public:
	static void signIn(QString login, QString hash);
	static void signOut();
	static void saveGame(QString area, int steps, int timeSec);
	static void saveTime(int timeSec);
	static void removeGame();

	static bool isSignIn();
	static QString getLogin();
	static QString getHash();
	static bool hasContinueGame();
	static QString getArea();
	static int getSteps();
	static int getTimeSec();
};

