//
//  ComicViewModelTests.swift
//  MarvelComicsAppTests
//
//  Created by Jakub Prus on 13/04/2023.
//

import XCTest
@testable import MarvelComicsApp

// Naming Structure: test_UnitOfWork_StateUnderTest_ExpectedBehaviour

// Testing Structure: Given, When, Then

final class ComicViewModelTests: XCTestCase {
    
    let linkPostfix = "/portrait_xlarge.jpg"
    let detailLinkPostfix = "/portrait_incredible.jpg"
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_ComicViewModel_getAuthors_shouldDefaultlyReturnAnonymous() {
        // Given
        let vm = ComicViewModel()
        
        // When
        let testing = vm.getAuthors(comic: Comic(creators: APIauthors(items: nil)))
        
        // Then
        XCTAssertEqual(testing, "Anonymous")
    }
    
    func test_ComicViewModel_getAuthors_shouldReturnSingleAuthorAndPeriod() {
        // Given
        let vm = ComicViewModel()
        
        // When
        let authorName = "First author"
        let testing = vm.getAuthors(comic: Comic(creators: APIauthors(items: [APIauthor(name: authorName)])))
        
        // Then
        XCTAssertEqual(testing, authorName+".")
    }
    
    func test_ComicViewModel_getAuthors_shouldReturnAuthorsSeperatedByComma() {
        // Given
        let vm = ComicViewModel()
        
        // When
        let firstAuthorName = "First author"
        let secondAuthorName = "Second author"
        let testing = vm.getAuthors(comic: Comic(creators: APIauthors(items: [APIauthor(name: firstAuthorName), APIauthor(name: secondAuthorName)])))
        
        // Then
        XCTAssertEqual(testing, firstAuthorName + ", " + secondAuthorName + ".")
    }

    func test_ComicViewModel_getAuthors_shouldReturnAnonymousWhenBlank() {
        // Given
        let vm = ComicViewModel()
        
        // When
        let authorName = ""
        let testing = vm.getAuthors(comic: Comic(creators: APIauthors(items: [APIauthor(name: authorName)])))
        
        // Then
        XCTAssertEqual(testing, "Anonymous" + ".")
    }
    
    func test_ComicViewModel_getAuthors_shouldReturnAuthorsAndAnonymousWhenBlank() {
        // Given
        let vm = ComicViewModel()
        
        // When
        let firstAuthorName = ""
        let secondAuthorName = "Second author"
        let testing = vm.getAuthors(comic: Comic(creators: APIauthors(items: [APIauthor(name: firstAuthorName), APIauthor(name: secondAuthorName)])))
        
        // Then
        XCTAssertEqual(testing, ("Anonymous" + ", " + secondAuthorName + "."))
    }
    
    func test_ComicViewModel_getThumbnailLink_shouldReturnBlank() {
        // Given
        let vm = ComicViewModel()
        
        // When
        let link = ""
        let testing = vm.getThumbnailLink(comic: Comic(thumbnail: APIthumbnail(path: link)))
        
        // Then
        XCTAssertEqual(testing, link + linkPostfix)
    }
    
    func test_ComicViewModel_getThumbnailLink_shouldReturnLink() {
        // Given
        let vm = ComicViewModel()
        
        // When
        let link = "link"
        let testing = vm.getThumbnailLink(comic: Comic(thumbnail: APIthumbnail(path: link)))
        
        // Then
        XCTAssertEqual(testing, link + linkPostfix)
    }
    
    func test_ComicViewModel_getThumbnailLinkDetail_shouldReturnBlank() {
        // Given
        let vm = ComicViewModel()
        
        // When
        let link = ""
        let testing = vm.getThumbnailLinkDetail(comic: Comic(thumbnail: APIthumbnail(path: link)))
        
        // Then
        XCTAssertEqual(testing, link + detailLinkPostfix)
    }
    
    func test_ComicViewModel_getThumbnailLinkDetail_shouldReturnLink() {
        // Given
        let vm = ComicViewModel()
        
        // When
        let link = "link"
        let testing = vm.getThumbnailLinkDetail(comic: Comic(thumbnail: APIthumbnail(path: link)))
        
        // Then
        XCTAssertEqual(testing, link + detailLinkPostfix)
    }
    
}
