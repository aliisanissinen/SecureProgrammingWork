#include "account.hh"

Account::Account()
{

}

bool Account::setuser(std::string username, std::string password, std::shared_ptr<Crypto> &crypto)
{
    std::vector<std::string> dataFromFile;

    std::ifstream readFile("credentials.txt");
    std::string lineInFile;

    while (getline(readFile, lineInFile)) {
        std::stringstream linestream(lineInFile);
        std::string dataInLine;

        while (std::getline(linestream, dataInLine, ';')) {
            dataFromFile.push_back(dataInLine);
        }

        if (username == dataFromFile.at(0) && crypto->generateHash(password) == dataFromFile.at(1)) {
            qDebug() << "Login Successfully!";

            username_ = dataFromFile.at(0);
            hashedpassword_ = dataFromFile.at(1);
            name_ = dataFromFile.at(2);
            return true;
        }
        dataFromFile.clear();
    }
    qDebug() << "InValid username or password";
    return false;
}

std::string Account::getname()
{
    return name_;
}

std::string Account::getusername()
{
    return username_;
}

bool Account::changepassword(std::string oldpassword, std::string newpassword, std::shared_ptr<Crypto> &crypto)
{
    if (checkPassword(newpassword)) {

        if (crypto->generateHash(oldpassword) == hashedpassword_) {
            std::fstream file("credentials.txt", std::ios::in);

            if (file.is_open()) {
                std::string replace = username_ + ";" + hashedpassword_ + ";" + name_;
                std::string replace_with = username_ + ";" +
                        crypto->generateHash(newpassword) + ";" + name_;
                std::string line;
                std::vector<std::string> lines;

                while (std::getline(file, line)) {
                    std::string::size_type pos = 0;

                    while ((pos = line.find(replace, pos)) != std::string::npos) {
                        line.replace(pos, line.size(), replace_with);
                        pos += replace_with.size();
                    }
                    lines.push_back(line);
                }

                file.close();
                file.open("credentials.txt", std::ios::out | std::ios::trunc);

                for(const auto& i : lines) {
                    file << i << std::endl;
                }
            }
            return true;
        }
        else {
            return false;
        }
    }
    else {
        return false;
    }
}

bool Account::checkPassword(std::string password)
{
    int passwordLength = password.length();

    // Strong password has at least one uppercase and lowercase alphabet,
    // one digit, and one special character. The full password must be at
    // least 8 characters long.
    bool hasLowerCaseAlphabet = false;
    bool hasUpperCaseAlphabet = false;
    bool hasDigit = false;
    bool hasSpecialChar = false;

    std::string normalChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";

    for (int i=0;i<passwordLength;i++) {
      if (islower(password[i]))
         hasLowerCaseAlphabet = true;

      if (isupper(password[i]))
         hasUpperCaseAlphabet = true;

      if (isdigit(password[i]))
         hasDigit = true;

      size_t specialCharIndx = password.find_first_not_of(normalChars);
      if (specialCharIndx != std::string::npos)
         hasSpecialChar = true;
    }

    if (hasLowerCaseAlphabet && hasUpperCaseAlphabet && hasDigit &&
      hasSpecialChar && (passwordLength >= 8)) {
        return true;
    }
    else {
        return false;
    }
}
