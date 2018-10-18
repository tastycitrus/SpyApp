//
//  OddsEvensCipherTests.swift
//  SpyAppTests
//
//  Created by Diana Luu on 9/16/18.
//  Copyright © 2018 Axel Ancona Esselmann. All rights reserved.
//

import XCTest
@testable import SpyApp

class OddsEvensCipherTests: XCTestCase {
    
    func test_oddCharacterStringMapsToTwoCharactersBackWith_0_secret() {
        let cipher = OddsEvensCipher()
        let plaintext = "c"
        
        let result = cipher.encode(plaintext, secret: "0")
        
        XCTAssertEqual("a", result)
    }
    
    func test_evenCharacterStringMapsToTwoCharactersForthWith_0_secret() {
        let cipher = OddsEvensCipher()
        let plaintext = "b"
        
        let result = cipher.encode(plaintext, secret: "0")
        
        XCTAssertEqual("d", result)
    }
    
    func test_oddCharacterStringMapsToRightCharacterWith_1_secret() {
        let cipher = OddsEvensCipher()
        let plaintext = "c"
        
        let result = cipher.encode(plaintext, secret: "1")
        
        XCTAssertEqual("b", result)
    }
    
    func test_evenCharacterStringMapsToRightCharacterWith_1_secret() {
        let cipher = OddsEvensCipher()
        let plaintext = "b"
        
        let result = cipher.encode(plaintext, secret: "1")
        
        XCTAssertEqual("e", result)
    }
    
    func test_oddCharacterStringDecryptsSuccessfully() {
        let cipher = OddsEvensCipher()
        let plaintext = "c"
        
        let encode = cipher.encode(plaintext, secret: "1")
        let result = cipher.decrypt(encode, secret: "1")
        
        XCTAssertEqual(plaintext, result)
    }
    
    func test_evenCharacterStringDecryptsSuccessfully() {
        let cipher = OddsEvensCipher()
        let plaintext = "b"
        
        let encode = cipher.encode(plaintext, secret: "1")
        let result = cipher.decrypt(encode, secret: "1")
        
        XCTAssertEqual(plaintext, result)
    }
    
    func test_negativeErrorWillNotCrash() {
        let cipher = OddsEvensCipher()
        let plaintext = "a"
        
        let result = cipher.decrypt(plaintext, secret: "255")
        
        XCTAssertEqual("Negative error", result)
    }
}
