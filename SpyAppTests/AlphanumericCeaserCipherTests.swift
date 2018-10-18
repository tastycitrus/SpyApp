//
//  AlphanumericCeaserCipherTests.swift
//  SpyAppTests
//
//  Created by Diana Luu on 9/16/18.
//  Copyright © 2018 Axel Ancona Esselmann. All rights reserved.
//

import XCTest
@testable import SpyApp

class AlphanumericCeaserCipherTests: XCTestCase {
    
    func test_characterWrapsCorrectly_inEncode() {
        let cipher = AlphanumericCeasarCipher()
        let plaintext = "Z"
        
        let result = cipher.encode(plaintext, secret: "1")
        
        //Z should map to 0
        XCTAssertEqual("0", result)
    }
    
    func test_characterWrapsCorrectly_inDecrypt() {
        let cipher = AlphanumericCeasarCipher()
        let plaintext = "0"
        
        let result = cipher.decrypt(plaintext, secret: "1")
        
        //0 should map to Z
        XCTAssertEqual("Z", result)
    }
    
    func test_EncodeAndDecryptSimultaneously() {
        let cipher = AlphanumericCeasarCipher()
        let plaintext = "WEARENUMBER1"
        
        let encrypt = cipher.encode(plaintext, secret: "5")
        let result = cipher.decrypt(encrypt, secret: "5")
        
        XCTAssertEqual(plaintext, result)
    }
    
    func test_lowercaseInputIsChangedToUpperWith_0_secret() {
        let cipher = AlphanumericCeasarCipher()
        let plaintext = "a"
        
        let result = cipher.encode(plaintext, secret: "0")
        
        XCTAssertEqual("A", result)
    }
    
    func test_invalidInputWillNotCrash_onEncode() {
        let cipher = AlphanumericCeasarCipher()
        let plaintext = "]"
        
        let result = cipher.encode(plaintext, secret: "1")
        
        XCTAssertEqual("Invalid character detected", result)
    }
    
    func test_AppWillNotCrashIfTooLargeSecret() {
        let cipher = AlphanumericCeasarCipher()
        let plaintext = "a"
        
        let result = cipher.encode(plaintext, secret: "3000")
        
        XCTAssertEqual("Overflow error", result)
    }
    
    func test_encodeAndDecryptWithLargeSecret() {
        let cipher = AlphanumericCeasarCipher()
        let plaintext = "BANANA"
        
        let encrypt = cipher.encode(plaintext, secret: "25")
        let result = cipher.decrypt(encrypt, secret: "25")
        
        XCTAssertEqual(plaintext, result)
    }
    
    func test_negativeErrorWillNotCrash() {
        let cipher = AlphanumericCeasarCipher()
        let plaintext = "a"
        
        let result = cipher.decrypt(plaintext, secret: "255")
        
        XCTAssertEqual("Negative error", result)
    }
}
