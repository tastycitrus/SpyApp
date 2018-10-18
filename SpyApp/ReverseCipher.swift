//
//  NewCipherOne.swift
//  SpyApp
//
//  Created by Diana Luu on 9/11/18.
//  Copyright © 2018 Axel Ancona Esselmann. All rights reserved.
//

import Foundation

struct ReverseCipher: Cipher {
    //cipher takes in 0-9 and A-Z (note space is counted as a character and thus invalid)
    //input is "flipped" (i.e. 0 becomes 9, A becomes Z) and then shifted over by number designated by secret
    //0-9 in ascii 48-57
    //A-Z in ascii 65-90
    //a-z is still valid input because the string is converted to uppercase before encryption/decryption
    func encode(_ plaintext: String, secret: String) -> String {
        var encoded = ""
        guard let shiftBy = UInt32(secret) else {
            return "Invalid secret"
        }
        
        let uppertext = plaintext.uppercased()
        
        for character in uppertext {
            let unicode = character.unicodeScalars.first!.value
            var shiftedUnicode:UInt32
            if unicode <= 52 && unicode >= 48 { //0-4
                let flipVal = unicode - 48
                shiftedUnicode = 57 - flipVal + shiftBy
            } else if unicode <= 57 && unicode >= 53 { //5-9
                let flipVal = 57 - unicode
                shiftedUnicode = 48 + flipVal + shiftBy
            } else if unicode <= 77 && unicode >= 65 { //A-M
                let flipVal = unicode - 65
                shiftedUnicode = 90 - flipVal + shiftBy
            } else if unicode <= 90 && unicode >= 66 { //N-Z
                let flipVal = 90 - unicode
                shiftedUnicode = 65 + flipVal + shiftBy
            } else { //invalid character detected
                return "Invalid character detected"
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
        
        let uppertext = encrypted.uppercased()
        
        for character in uppertext {
            let unicode1 = character.unicodeScalars.first!.value
            if shiftBy > unicode1 {
                return "Negative error"
            }
            let unicode = unicode1 - shiftBy
            var shiftedUnicode:UInt32
            if unicode <= 52 && unicode >= 48 { //0-4
                let flipVal = unicode - 48
                shiftedUnicode = 57 - flipVal
            } else if unicode <= 57 && unicode >= 53 { //5-9
                let flipVal = 57 - unicode
                shiftedUnicode = 48 + flipVal
            } else if unicode <= 77 && unicode >= 65 { //A-M
                let flipVal = unicode - 65
                shiftedUnicode = 90 - flipVal
            } else if unicode <= 90 && unicode >= 66 { //N-Z
                let flipVal = 90 - unicode
                shiftedUnicode = 65 + flipVal
            } else { //invalid character detected
                return "Invalid character detected"
            }
            
            let shiftedCharacter = String(UnicodeScalar(UInt8(shiftedUnicode)))
            decrypted = decrypted + shiftedCharacter
        }
        return decrypted
    }
}
