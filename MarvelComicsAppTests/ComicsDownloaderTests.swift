//
//  ComicsDownloaderTests.swift
//  MarvelComicsAppTests
//
//  Created by Jakub Prus on 13/04/2023.
//

import XCTest
@testable import MarvelComicsApp

// Naming Structure: test_UnitOfWork_StateUnderTest_ExpectedBehaviour

// Testing Structure: Given, When, Then

final class ComicsDownloaderTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // MARK: ComicsDownloader
    func test_ComicsDownloader_createRequestURL_returnNotNil() {
        // Given
        let comicsDownloader = ComicsDownloader()
        
        // When
        let url = comicsDownloader.createRequestURL()
        
        // Then
        XCTAssertNotNil(url)
    }
    
    func test_ComicsDownloader_downloadData_returnNotNil() async {
        // Given
        let comicsDownloader = ComicsDownloader()
        
        // When
        let testing = await comicsDownloader.downloadData()
        
        // Then
        XCTAssertNotNil(testing)
    }
    
    
    // MARK: MockComicsDownloader
    func test_MockComicsDownloader_downloadData_returnNotNil() async {
        // Given
        let comicsDownloader = MockComicsDownloader()
        
        // When
        let testing = await comicsDownloader.downloadData()
        
        // Then
        XCTAssertNotNil(testing)
    }
}
