#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QCryptographicHash>

#include "core.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

	Core core;
    QQmlApplicationEngine engine;
	QQmlContext *context = engine.rootContext();
	context->setContextProperty("_arguments", app.arguments());
	context->setContextProperty("core", &core);

    const QUrl url(QStringLiteral("qrc:/main.qml"));
//	const QUrl url(QStringLiteral("qrc:/testWindow.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
