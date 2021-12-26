#pragma once

#include <QObject>
#include "databaseworker.h"
#include "databasemodel.h"

class Core : public QObject
{
	Q_OBJECT
	Q_PROPERTY(DataBaseModel * model READ model CONSTANT)
public:
	static const QString ITEM_NAME;     ///< Core
	static const bool IS_QML_REG;

	Core(QObject *parent = nullptr);

	DataBaseModel *model() const;

public slots:
	bool registerPlayer(QString login, QString mail, QString pass);
	int checkPass(QString login, QString pass);

private:
	DataBaseWorker *_db = nullptr;
	DataBaseModel *_model = nullptr;
	int _idPlayer = -1;
};

