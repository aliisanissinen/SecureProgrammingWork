#ifndef LOGIN_HH
#define LOGIN_HH

#include "account.hh"
#include <string>
#include <memory>


class Login
{
public:
    Login();

    std::unique_ptr<Account> loginuser(std::string username, std::string password);
    bool logoutuser();
};

#endif // LOGIN_HH
