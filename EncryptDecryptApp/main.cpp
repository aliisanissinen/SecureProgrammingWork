#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "controller.hh"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    // Create pointers to classes
    auto controller{std::make_shared<Controller>()};

    QQmlApplicationEngine engine;

    // Create presentation of required classes to QML side
    engine.rootContext()->setContextProperty("controller", controller.get());

    const QUrl url(QStringLiteral("qrc:/LogInWindow.qml"));
    QObject::connect(
        &engine, &QQmlApplicationEngine::objectCreated,
        &app, [url](QObject *obj, const QUrl &objUrl)
        {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    engine.load(url);

    return app.exec();
}
