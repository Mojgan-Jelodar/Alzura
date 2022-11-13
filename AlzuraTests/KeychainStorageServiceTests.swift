//
//  StorageServiceTests.swift
//  AlzuraTests
//
//  Created by Mozhgan on 11/11/22.
//

import Foundation
import XCTest
@testable import Alzura
final class KeychainStorageServiceTests : XCTestCase {
    private var subjectUnderTest : KeyCahinStorage<String>!
    override func setUpWithError() throws {
        subjectUnderTest = .init(transformer: .init(toData: { string in
            return try string.data(using: .utf8).unwrapOrThrow(error: StorageError.transformerFail)
        }, fromData: { data in
            return String(data: data, encoding: .utf8) ?? ""
        }))
    }
    override func tearDownWithError() throws {
        subjectUnderTest = nil
    }
    
    func testStoreAndRetrive() throws {
        let value = "Alzura"
        let key = "ABC"
        try subjectUnderTest.setObject(value, forKey: key)
        let storedValue = try subjectUnderTest.object(forKey: key)
        XCTAssertEqual(value, storedValue)
    }
    
    func testClear() throws {
        let value = "Alzura"
        let key = "ABC"
        try subjectUnderTest.setObject(value, forKey: key)
        subjectUnderTest.removeObject(forKey: key)
    }
}
