#include "MainWindow.h"
#include <QLabel>
#include <QVBoxLayout>
#include <QWidget>

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
{
    setWindowTitle("Basilic - Magic Draft Client");
    setMinimumSize(800, 600);

    QWidget *centralWidget = new QWidget(this);
    QVBoxLayout *layout = new QVBoxLayout(centralWidget);

    QLabel *label = new QLabel("Welcome to Basilic!", centralWidget);
    label->setAlignment(Qt::AlignCenter);
    layout->addWidget(label);

    setCentralWidget(centralWidget);
}

MainWindow::~MainWindow()
{
}
