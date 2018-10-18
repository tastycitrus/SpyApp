import Foundation

protocol Cipher {
    func encode(_ plaintext: String, secret: String) -> String
    func decrypt (_ encrypted: String, secret: String) -> String
}

struct CeaserCipher: Cipher {

    func encode(_ plaintext: String, secret: String) -> String {
        var encoded = ""

        guard let shiftBy = UInt32(secret) else {
            return "Invalid secret"
        }

        for character in plaintext {
            let unicode = character.unicodeScalars.first!.value
            let shiftedUnicode = unicode + shiftBy
            if shiftedUnicode > 255 {
                return "Overflow error"
            }
            let shiftedCharacter = String(UnicodeScalar(UInt8(shiftedUnicode)))
            encoded = encoded + shiftedCharacter
        }
        return encoded
    }
    
    //add button for decrypt method
    func decrypt(_ encrypted: String, secret: String) -> String {
        var decrypted = ""
        guard let shiftBack = UInt32(secret) else {
            return "Invalid secret"
        }
        
        //check if shifted unicode would be a negative value; loop around by adding 255?
        for character in encrypted {
            let unicode = character.unicodeScalars.first!.value
            if shiftBack > unicode {
                return "Negative error"
            }
            let shiftedUnicode = unicode - shiftBack
            let shiftedCharacter = String(UnicodeScalar(UInt8(shiftedUnicode)))
            decrypted = decrypted + shiftedCharacter
        }
        return decrypted
    }
}
