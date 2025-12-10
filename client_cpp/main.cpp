#include <QApplication>
#include <QMessageBox>
#include "ui/MainWindow.h"
#include "utils/Config.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    app.setApplicationName("Basilic");
    app.setApplicationVersion("1.0.0");
    app.setOrganizationName("Basilic");

    if (!Config::instance()->loadEnvironment()) {
        QMessageBox::critical(nullptr, "Configuration Error",
            "Failed to load .env file. Please ensure Supabase credentials are configured.");
        return 1;
    }

    MainWindow window;
    window.show();

    return app.exec();
}
