#include "databasemodel.h"
#include "databaseworker.h"
#include "myfunc.h"

const QString DataBaseModel::ITEM_NAME = "DataBaseModel";
const bool DataBaseModel::IS_QML_REG = My::qmlRegisterType<DataBaseModel>
													(DataBaseModel::ITEM_NAME);

const std::array<QString, DataBaseModel::ROLE_COUNT> DataBaseModel::DB_ROLE_STR {
	"loginRole",
	"stepsRole",
	"timeRole"
};

DataBaseModel::DataBaseModel(QObject *parent)
	: QSqlQueryModel(parent)
{
	updateModel();
}

QVariant DataBaseModel::data(const QModelIndex &index, int role) const
{
	int columnId = role - RoleBegin;
	QModelIndex modelIndex = this->index(index.row(), columnId);

	return QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
}

void DataBaseModel::updateModel()
{
	setQuery(DataBaseWorker::queryRate());
}

QHash<int, QByteArray> DataBaseModel::roleNames() const
{
	QHash<int, QByteArray> r;
	for (int i = RoleBegin; i < RoleEnd; ++i) {
		r.insert(i, DB_ROLE_STR.at(i - RoleBegin).toUtf8());
	}
	return r;
}
