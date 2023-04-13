//
//  md5Tests.swift
//  MarvelComicsAppTests
//
//  Created by Jakub Prus on 13/04/2023.
//

import XCTest
@testable import MarvelComicsApp

// Naming Structure: test_UnitOfWork_StateUnderTest_ExpectedBehaviour

// Testing Structure: Given, When, Then

final class md5Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_extensionMD5_md5_shouldNotReturnBlank() {
        // Given
        let sampleString = "sampleString"
        
        // When
        let testing = sampleString.MD5
        
        // Then
        XCTAssertNotNil(testing)
        XCTAssertFalse(testing.isEmpty)
    }

}
