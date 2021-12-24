#include "databasemodel.h"
#include "databasemodelprivate.h"
#include "myfunc.h"

#include <QQmlEngine>

const QString DataBaseModel::ITEM_NAME = "DataBaseModel";
const bool DataBaseModel::IS_QML_REG = My::qmlRegisterType<DataBaseModel>
													(DataBaseModel::ITEM_NAME);

const std::array<QString, DataBaseModel::ROLE_COUNT> DataBaseModel::DB_ROLE_STR {
	"ID",
	"Nik",
	"Steps",
	"Time"
};

DataBaseModel::DataBaseModel(QObject *parent)
	: QAbstractListModel(parent)
//	, _p(parent)
{

}


int DataBaseModel::rowCount(const QModelIndex &parent) const
{
}

QVariant DataBaseModel::data(const QModelIndex &index, int role) const
{
}

QHash<int, QByteArray> DataBaseModel::roleNames() const
{
	QHash<int, QByteArray> r;
	for (int i = RoleBegin; i < RoleEnd; ++i) {
		r.insert(i, DB_ROLE_STR.at(i - RoleBegin).toUtf8());
	}
	return r;
}
