//
//  ReverseCipherTests.swift
//  SpyAppTests
//
//  Created by Diana Luu on 9/16/18.
//  Copyright © 2018 Axel Ancona Esselmann. All rights reserved.
//

import XCTest
@testable import SpyApp

class ReverseCipherTests: XCTestCase {

    func test_oneCharacterStringMapsToReverse_0_secret() {
        let cipher = ReverseCipher()
        let plaintext = "A"
        
        let result = cipher.encode(plaintext, secret: "0")
        
        //A will be flipped to Z
        XCTAssertEqual("Z", result)
    }
    
    func test_oneCharacterStringMapsToCharAfterReverse_1_secret() {
        let cipher = ReverseCipher()
        let plaintext = "Z"
        
        let result = cipher.encode(plaintext, secret: "1")
        
        //Z will be flipped to A, then shifted by 1
        XCTAssertEqual("B", result)
    }
    
    func test_InvalidInputDoesNotCrash() {
        let cipher = ReverseCipher()
        let plaintext = "["
        
        let result = cipher.encode(plaintext, secret: "1")
        
        XCTAssertEqual("Invalid character detected", result)
    }
    
    func test_longStringWillEncodeAndDecrypt() {
        let cipher = ReverseCipher()
        let plaintext = "SUPERMAN64"
        
        let encode = cipher.encode(plaintext, secret: "2")
        let result = cipher.decrypt(encode, secret: "2")
        
        XCTAssertEqual(plaintext, result)
    }
    
    func test_lowercaseWillConvertToUppercase() {
        let cipher = ReverseCipher()
        let plaintext = "banana"
        
        let encode = cipher.encode(plaintext, secret: "0")
        let result = cipher.decrypt(encode, secret: "0")
        
        XCTAssertEqual("BANANA", result)
    }
    
    func test_negativeErrorWillNotCrash() {
        let cipher = ReverseCipher()
        let plaintext = "a"
        
        let result = cipher.decrypt(plaintext, secret: "255")
        
        XCTAssertEqual("Negative error", result)
    }
}
