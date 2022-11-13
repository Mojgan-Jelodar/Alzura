//
//  UserDefaultsStorageTests.swift
//  AlzuraTests
//
//  Created by Mozhgan on 11/11/22.
//

import Foundation
import XCTest
@testable import Alzura
final class UserDefaultsStorageTests : XCTestCase {
    private var subjectUnderTest : UserDefaultsStorage<Bool>!
    override func setUpWithError() throws {
        subjectUnderTest = .init(transformer: .init(toData: { value in
            var intValue = NSNumber(value: value).intValue
            return Data(bytes: &intValue, count: MemoryLayout.size(ofValue: intValue))
        }, fromData: { data in
            let value = data.withUnsafeBytes {return $0.load(as: Int.self)}
            return NSNumber(value: value).boolValue
        }))
    }
    override func tearDownWithError() throws {
        subjectUnderTest = nil
    }
    
    func testStoreAndRetrive() throws {
        let value = true
        let key = "isLoggedIn"
        try subjectUnderTest.setObject(value, forKey: key)
        let storedValue = try subjectUnderTest.object(forKey: key)
        XCTAssertEqual(value, storedValue)
    }
    
    func testClear() {
        do {
            let value = false
            let key = "isLoggedIn"
            try subjectUnderTest.setObject(value, forKey: key)
            subjectUnderTest.removeObject(forKey: key)
            let storedValue = try subjectUnderTest.object(forKey: key)
            XCTAssertNil(storedValue)
        } catch let error {
            XCTAssertEqual(StorageError.notFound, error as? StorageError)
        }
  
    }
}
