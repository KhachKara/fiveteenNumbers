#pragma once

#include <QAbstractListModel>
#include <QSqlQueryModel>

class DataBaseModel : public QSqlQueryModel
{
	Q_OBJECT
public:
	static const QString ITEM_NAME;     ///< DataBaseModel
	static const bool IS_QML_REG;
	enum Role {
		RoleBegin = Qt::UserRole + 1,

		LoginRole = RoleBegin,	// nikname
		StepsRole,				// result steps
		TimeRole,				// result time

		RoleEnd
	};
	Q_ENUM(Role)
	static const int ROLE_COUNT = RoleEnd - RoleBegin;
	static const std::array<QString, ROLE_COUNT> DB_ROLE_STR;

	explicit DataBaseModel(QObject *parent = nullptr);
	virtual ~DataBaseModel() = default;

	QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
public slots:
	void updateModel(int sizeArea);

protected:
	QHash<int, QByteArray> roleNames() const override;
};

