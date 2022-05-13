#include "crypto.hh"
#include <QDebug>

Crypto::Crypto()
{

}

std::string Crypto::encrypt(std::string message, std::string userkey)
{
    std::string ciphermessage;
    std::string encoded;

    try {
        memcpy(key_, userkey.c_str(), CryptoPP::AES::DEFAULT_KEYLENGTH);
        memcpy(iv_, userkey.c_str(), CryptoPP::AES::BLOCKSIZE);

        CryptoPP::AES::Encryption aesEncryption(key_, CryptoPP::AES::DEFAULT_KEYLENGTH);
        CryptoPP::CBC_Mode_ExternalCipher::Encryption cbcEncryption( aesEncryption, iv_ );

        CryptoPP::StreamTransformationFilter stfEncryptor(cbcEncryption, new CryptoPP::StringSink( ciphermessage ) );
        stfEncryptor.Put( reinterpret_cast<const unsigned char*>( message.c_str() ), message.length() );
        stfEncryptor.MessageEnd();

        // Base64Encoder edit the text to a more readable format
        CryptoPP::StringSource ss(ciphermessage, true,
            new CryptoPP::Base64Encoder(new CryptoPP::StringSink(encoded)));
    }
    catch (...) {
        qDebug() << "Something went wrong, encryption";
    }

    return encoded;
}

std::string Crypto::decrypt(std::string message, std::string userkey)
{
    std::string decoded;

    // Decode message, encoded in the encryption method
    CryptoPP::StringSource ss(message, true,
        new CryptoPP::Base64Decoder(new CryptoPP::StringSink(decoded)));

    std::string decryptedmessage;

    try {
        memcpy(key_, userkey.c_str(), CryptoPP::AES::DEFAULT_KEYLENGTH);
        memcpy(iv_, userkey.c_str(), CryptoPP::AES::BLOCKSIZE);

        CryptoPP::AES::Decryption aesDecryption(key_, CryptoPP::AES::DEFAULT_KEYLENGTH);
        CryptoPP::CBC_Mode_ExternalCipher::Decryption cbcDecryption( aesDecryption, iv_ );

        CryptoPP::StreamTransformationFilter stfDecryptor(cbcDecryption, new CryptoPP::StringSink( decryptedmessage ) );
        stfDecryptor.Put( reinterpret_cast<const unsigned char*>( decoded.c_str() ), decoded.size() );
        stfDecryptor.MessageEnd();
    }
    catch (...) {
        qDebug() << "Something went wrong, decryption";
    }

    return decryptedmessage;
}

std::string Crypto::generateHash(std::string password)
{
    CryptoPP::SHA512 * hash = new CryptoPP::SHA512;
    CryptoPP::byte digest[CryptoPP::SHA512::DIGESTSIZE];
    hash->CalculateDigest(digest, (const CryptoPP::byte*)password.c_str(), password.length());

    std::string result;
    CryptoPP::HexEncoder encoder;

    encoder.Attach(new CryptoPP::StringSink(result));
    encoder.Put(digest, sizeof(digest));

    return result;
}
