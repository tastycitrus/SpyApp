//
//  OddsEvensCipher.swift
//  SpyApp
//
//  Created by Diana Luu on 9/16/18.
//  Copyright © 2018 Axel Ancona Esselmann. All rights reserved.
//

import Foundation

struct OddsEvensCipher: Cipher {
    //if ascii value is odd, move back 2, if even, move forward 2
    //then shift forward by secret
    //A-Z 65-90
    //a-z 97-122
    //cipher should take in any printable input but will reject if secret pushes it past 255
    func encode(_ plaintext: String, secret: String) -> String {
        var encoded = ""
        guard let shiftBy = UInt32(secret) else {
            return "Invalid secret"
        }
        
        for character in plaintext {
            let unicode = character.unicodeScalars.first!.value
            var shiftedUnicode:UInt32
            if unicode % 2 == 0 { //if even
                shiftedUnicode = unicode + 2 + shiftBy
            } else { //if odd
                shiftedUnicode = unicode - 2 + shiftBy
            }
            
            if shiftedUnicode > 255 {
                return "Failed to encrypt: Out of bounds"
            }
            
            let shiftedCharacter = String(UnicodeScalar(UInt8(shiftedUnicode)))
            encoded = encoded + shiftedCharacter
        }
        
        return encoded
    }
    
    func decrypt(_ encrypted: String, secret: String) -> String {
        var decrypted = ""
        guard let shiftBy = UInt32(secret) else {
            return "Invalid secret"
        }
        
        for character in encrypted {
            let unicode = character.unicodeScalars.first!.value
            if shiftBy > unicode {
                return "Negative error"
            }
            var shiftedUnicode = unicode - shiftBy
            if shiftedUnicode % 2 == 0 { //if even
                shiftedUnicode = shiftedUnicode - 2
            } else { //if odd
                shiftedUnicode = shiftedUnicode + 2
            }
            
            let shiftedCharacter = String(UnicodeScalar(UInt8(shiftedUnicode)))
            decrypted = decrypted + shiftedCharacter
        }
        
        return decrypted
    }
}
