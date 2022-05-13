#ifndef CONTROLLER_HH
#define CONTROLLER_HH

#include "crypto.hh"
#include "account.hh"
#include <QObject>
#include <QString>
#include <QDebug>

class Controller: public QObject
{
    Q_OBJECT

    //Signals for updating UI
    Q_PROPERTY(bool loggedIn READ loginInfo NOTIFY loggedIn)
    Q_PROPERTY(QString username READ giveUsername NOTIFY usernameChange)
    Q_PROPERTY(QString name READ giveName NOTIFY nameChange)
    Q_PROPERTY(QString encryptedText READ finishedText NOTIFY encryptTextChange)
    Q_PROPERTY(QString decryptedText READ finishedText NOTIFY decryptTextChange)
    Q_PROPERTY(bool newPassword READ changePasswordInfo NOTIFY passwordChange)

public:
    /**
     * @brief Constructor
     */
    Controller(QObject *parent = nullptr);

    /**
     * @brief Logs in the user with account class
     * @param username
     * @param password
     */
    Q_INVOKABLE void login(QString username, QString password);

    /**
     * @brief Gives info about login
     * @return true if user's login is successfull, if not then false
     */
    bool loginInfo() const;

    /**
     * @brief Gives user's username from account class
     * @return user's username
     */
    QString giveUsername() const;

    /**
     * @brief Gives user's name from account class
     * @return user's name
     */
    QString giveName() const;

    /**
     * @brief Send text to the crypto class, to encryption or decryption
     * @param text, text to encrypt or decrypt
     * @param way, is text need to be encypted or decrypted
     * @param userkey, to crypt the text
     */
    Q_INVOKABLE void getText(QString text, QString way, QString userkey);

    /**
     * @brief Finished text
     * @return text that is encrypted or decrypted
     */
    QString finishedText() const;

    /**
     * @brief Start changing a password, uses account class if password change is possible
     * @param oldpassword
     * @param newpassword
     * @param confirmpassword, needs to be same as newpassword
     */
    Q_INVOKABLE void getNewPassword(QString oldpassword, QString newpassword, QString confirmpassword);

    /**
     * @brief Gives information about password change
     * @return true if password is change, otherwise false
     */
    bool changePasswordInfo() const;


signals:
    void loggedIn();
    void usernameChange();
    void nameChange();
    void encryptTextChange();
    void decryptTextChange();
    void passwordChange();

private:
    std::shared_ptr<Crypto> crypto_ = std::make_shared<Crypto>();
    std::shared_ptr<Account> account_ = std::make_shared<Account>();

    bool loggedIn_ = false;
    bool passwordChange_ = false;
    QString message_;

};

#endif // CONTROLLER_HH
