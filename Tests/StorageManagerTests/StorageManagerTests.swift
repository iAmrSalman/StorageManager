//
//  StorageManagerTests.swift
//  StorageManager
//
//  Created by Amr Salman on 1/26/18.
//  Copyright © 2018 StorageManager. All rights reserved.
//

import Foundation
import XCTest
import StorageManager

class StorageManagerTests: XCTestCase {
    func testStoreDictionary() {
        XCTAssertNoThrow(try StorageManager.default.store(dictionary: ["Txt": "This is a test"], in: "test"), "Storing dictionary into file test")
    }
    
    func testReadTestFile() {
        XCTAssertEqual(try StorageManager.default.dictionaryValue("test")["Txt"] as? String, "This is a test")
    }
    
    static var allTests = [
        ("testStoreDictionary", testStoreDictionary),
        ("testReadTestFile", testReadTestFile)
    ]
}
