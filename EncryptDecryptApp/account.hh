#ifndef ACCOUNT_HH
#define ACCOUNT_HH

#include "crypto.hh"
#include <string>
#include <fstream>
#include <sstream>
#include <QDebug>

class Account
{
public:
    /**
     * @brief Constructor
     */
    Account();

    /**
     * @brief Set user, user have username password and name
     * @param username
     * @param password
     * @param crypto, class where is password hash function
     * @return true if user found, otherwise false
     */
    bool setuser(std::string username, std::string password, std::shared_ptr<Crypto> &crypto);

    /**
     * @brief Returns user's name
     * @return user's name
     */
    std::string getname();

    /**
     * @brief Returns user's username
     * @return user's username
     */
    std::string getusername();

    /**
     * @brief Changes user's password to the new one
     * @param oldpassword
     * @param newpassword
     * @param crypto, class where is password hash function
     * @return true if password is change, otherwise false
     */
    bool changepassword(std::string oldpassword, std::string newpassword, std::shared_ptr<Crypto> &crypto);

private:
    std::string username_;
    std::string name_;
    std::string hashedpassword_;

    /**
     * @brief Check that the password meets certain requirements
     * @param password
     * @return true if password is strong enough, otherwise false
     */
    bool checkPassword(std::string password);
};

#endif // ACCOUNT_HH
