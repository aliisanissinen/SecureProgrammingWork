#ifndef CRYPTO_HH
#define CRYPTO_HH

#include "modes.h"
#include "aes.h"
#include "filters.h"
#include "base64.h"
#include "osrng.h"
#include "pwdbased.h"
#include "sha.h"
#include "hex.h"
#include "channels.h"
#include "sha3.h"
#include <string>
#include <QString>


class Crypto
{
public:
    /**
     * @brief Constructor
     */
    Crypto();

    /**
     * @brief Encrypts a message
     * @param message, text to encrypt
     * @param userkey, key to encrypt the text
     * @return ecrypted text
     */
    std::string encrypt(std::string message, std::string userkey);

    /**
     * @brief Decrypts a message
     * @param message, text to decrypt
     * @param userkey, key to decrypt the text
     * @return derypted text
     */
    std::string decrypt(std::string message, std::string userkey);

    /**
     * @brief Hash a password
     * @param password that needs to be hashed
     * @return hashed password
     */
    std::string generateHash(std::string password);

private:
    // Key and initialization vector setup, DEFAULT_KEYLENGTH = 16 bytes
    CryptoPP::byte key_[CryptoPP::AES::DEFAULT_KEYLENGTH];
    CryptoPP::byte iv_[CryptoPP::AES::BLOCKSIZE];

};

#endif // CRYPTO_HH
