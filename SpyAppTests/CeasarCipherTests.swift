//
//  CeasarCipherTests.swift
//  SpyAppTests
//
//  Created by Diana Luu on 9/16/18.
//  Copyright © 2018 Axel Ancona Esselmann. All rights reserved.
//

import XCTest
@testable import SpyApp

class CeasarCipherTests: XCTestCase {
    
    func test_oneCharacterStringMapsToSelfWith_0_secret() {
        let cipher = CeaserCipher()
        let plaintext = "a"
        
        let result = cipher.encode(plaintext, secret: "0")
        
        XCTAssertEqual(plaintext, result)
    }
    
    func test_oneCharacterStringMapsToNextCharWith_1_secret() {
        let cipher = CeaserCipher()
        let plaintext = "a"
        
        let result = cipher.encode(plaintext, secret: "1")
        
        //expected result is b
        XCTAssertEqual("b", result)
    }
    
    func test_oneCharacterStringDecryptWith_1_secret() {
        let cipher = CeaserCipher()
        let plaintext = "a"
        
        let encrypt = cipher.encode(plaintext, secret: "1")
        let result = cipher.decrypt(encrypt, secret: "1")
        
        XCTAssertEqual(plaintext, result)
    }
    
    func test_wholeWordDecryptWith_2_secret() {
        let cipher = CeaserCipher()
        let plaintext = "banana"
        
        let encrypt = cipher.encode(plaintext, secret: "2")
        let result = cipher.decrypt(encrypt, secret: "2")
        
        XCTAssertEqual(plaintext, result)
    }
    
    func test_appWillNotCrashIfOverflow() {
        let cipher = CeaserCipher()
        let plaintext = "a"
        
        let result = cipher.encode(plaintext, secret: "255")
        
        //expected "result" should be "Overflow error"
        XCTAssertEqual("Overflow error", result)
    }
    
    func test_negativeErrorWillNotCrash() {
        let cipher = CeaserCipher()
        let plaintext = "a"
        
        let result = cipher.decrypt(plaintext, secret: "255")
        
        XCTAssertEqual("Negative error", result)
    }
}
