//
//  AlphanumericCeaserCipher.swift
//  SpyApp
//
//  Created by Diana Luu on 9/9/18.
//  Copyright © 2018 Axel Ancona Esselmann. All rights reserved.
//

import Foundation

struct AlphanumericCeasarCipher: Cipher {
    func encode(_ plaintext: String, secret: String) -> String {
        var encoded = ""
        guard let shiftBy = UInt32(secret) else {
            return "Invalid secret"
        }
        
        let uppertext = plaintext.uppercased()
        
        for character in uppertext {
            let unicode = character.unicodeScalars.first!.value
            // range of digits in ascii code: 48 (0) -> 57 (9)
            // range of uppercase letters in ascii code: 65 (A) -> 90 (Z)
            // check value of unicode; if unicode <57 but becomes >57 through adding secret, add 7 to "skip" ahead
            // if unicode <90 but becomes >90 through adding secret, then subtract 43 to "loop around"
            // add shifted character to encoded
            var shiftedUnicode:UInt32
            if unicode <= 57 && unicode + shiftBy > 57 {
                shiftedUnicode = unicode + shiftBy + 7
            } else if unicode <= 90 && unicode + shiftBy > 90 {
                shiftedUnicode = unicode + shiftBy - 43
            } else if (unicode >= 48 && unicode <= 90) || (unicode >= 65 && unicode <= 90) {
                shiftedUnicode = unicode + shiftBy
            } else {
                return "Invalid character detected"
            }
            if shiftedUnicode > 255 {
                return "Overflow error"
            }
            let shiftedCharacter = String(UnicodeScalar(UInt8(shiftedUnicode)))
            encoded = encoded + shiftedCharacter
        }
        
        return encoded
    }
    
    func decrypt (_ encrypted: String, secret: String) -> String {
        var decrypted = ""
        guard let shiftBack = UInt32(secret) else {
            return "Invalid secret"
        }
        
        let uppertext = encrypted.uppercased()
        
        for character in uppertext {
            let unicode = character.unicodeScalars.first!.value
            var shiftedUnicode:UInt32
            if shiftBack > unicode {
                return "Negative error"
            }
            if unicode >= 48 && unicode - shiftBack < 48 {
                shiftedUnicode = unicode - shiftBack + 43
            } else if unicode >= 65 && unicode - shiftBack < 65 {
                shiftedUnicode = unicode - shiftBack - 7
            } else {
                shiftedUnicode = unicode - shiftBack
            }
            
            let shiftedCharacter = String(UnicodeScalar(UInt8(shiftedUnicode)))
            decrypted = decrypted + shiftedCharacter
        }
        return decrypted
    }
}
