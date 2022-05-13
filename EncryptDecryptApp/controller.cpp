#include "controller.hh"

Controller::Controller(QObject *parent) : QObject(parent)
{

}

void Controller::login(QString username, QString password)
{
    if (account_->setuser(username.toStdString(), password.toStdString(), crypto_)) {
        loggedIn_ = true;
        emit usernameChange();
    }
    else {
        loggedIn_ = false;
    }
    emit loggedIn();
}

bool Controller::loginInfo() const
{
    return loggedIn_;
}

QString Controller::giveUsername() const
{
    return QString::fromStdString(account_->getusername());
}

QString Controller::giveName() const
{
    return QString::fromStdString(account_->getname());
}

void Controller::getText(QString text, QString way, QString userkey)
{
    if (way == "encrypt") {
        message_ = QString::fromStdString(crypto_->encrypt(text.toStdString(), userkey.toStdString()));
        emit encryptTextChange();

    }
    else if (way == "decrypt") {
        message_ = QString::fromStdString(crypto_->decrypt(text.toStdString(), userkey.toStdString()));
        emit decryptTextChange();
    }
    else {
        qDebug() << "Wrong way in the getText() function (controller)";
    }
}

QString Controller::finishedText() const
{
    return message_;
}

void Controller::getNewPassword(QString oldpassword, QString newpassword,
                                QString confirmpassword)
{
    // New password and confirm password need to be same,
    // so user can't change to the wrong password
    if (newpassword == confirmpassword) {
        passwordChange_ = account_->changepassword(oldpassword.toStdString(),
                                                   newpassword.toStdString(),
                                                   crypto_);
        emit passwordChange();
    }
    else {
        passwordChange_ = false;
        qDebug() << "Something went wrong with password change.";
    }
}

bool Controller::changePasswordInfo() const
{
    return passwordChange_;
}
