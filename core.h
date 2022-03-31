#pragma once

#include <QObject>

class Core : public QObject
{
	Q_OBJECT
public:
	static const QString ITEM_NAME;     ///< Core
	static const bool IS_QML_REG;

	Core(QObject *parent = nullptr);

public slots:
	bool existRecoveryGame() const;
	void saveGame(QString area, int steps, int timeSec) const;
	void saveTimeSec(int timeSec) const;
	void removeGame() const;
	QString recoveryArea() const;
	int recoverySteps() const;
	int recoveryTimeSec() const;
};

