import Foundation

struct CipherFactory {

    private var ciphers: [String: Cipher] = [
        "Ceasar": CeaserCipher(),
        "AlphaNum": AlphanumericCeasarCipher(),
        "Reverse": ReverseCipher(),
        "OddsEvens": OddsEvensCipher()
    ]

    func cipher(for key: String) -> Cipher {
        return ciphers[key]!
    }
}
