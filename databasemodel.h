#pragma once

#include <QAbstractListModel>

class DataBaseModelPrivate;

class DataBaseModel : public QAbstractListModel
{
	Q_OBJECT
public:
	static const QString ITEM_NAME;     ///< DataBaseModel
	static const bool IS_QML_REG;
	enum Role {
		RoleBegin = Qt::UserRole + 1,

		IdRole = RoleBegin,	// id
		NikRole,			// nikname
		StepsRole,			// result steps
		TimeRole,			// result time

		RoleEnd
	};
	Q_ENUM(Role)
	static const int ROLE_COUNT = RoleEnd - RoleBegin;
	static const std::array<QString, ROLE_COUNT> DB_ROLE_STR;

	explicit DataBaseModel(QObject *parent = nullptr);
	virtual ~DataBaseModel() = default;

	int rowCount(const QModelIndex &parent = QModelIndex()) const override;
	QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

protected:
	QHash<int, QByteArray> roleNames() const override;

private:
	DataBaseModelPrivate *_p = nullptr;
};

