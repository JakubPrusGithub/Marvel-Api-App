//
//  MainViewModelTests.swift
//  MarvelComicsAppTests
//
//  Created by Jakub Prus on 13/04/2023.
//

import XCTest
@testable import MarvelComicsApp

// Naming Structure: test_UnitOfWork_StateUnderTest_ExpectedBehaviour

// Testing Structure: Given, When, Then

final class MainViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_MainViewModel_init_shouldSetValuesCorrectly() {
        // Given
        let comicsDownloader = MockComicsDownloader()
        let comicsDownloader2 = ComicsDownloader()
        
        // When
        let vm = MainViewModel(comicsDownloader: comicsDownloader)
        let vm2 = MainViewModel(comicsDownloader: comicsDownloader2)
        
        // Then
        XCTAssertNotNil(vm.comicsDownloader)
        XCTAssertNotNil(vm2.comicsDownloader)
    }
    
    func test_MainViewModel_searchResults_shouldShowResults() {
        // Given
        let comicsDownloader = MockComicsDownloader()
        let vm = MainViewModel(comicsDownloader: comicsDownloader)
        
        vm.allComics = APIrequest(data: APIdata(results: [.sampleComic]))
        
        // When
        let title = Comic.sampleComic.title ?? "Title"
        vm.searchedTitle = title
        
        // Then
        XCTAssertEqual(vm.searchResults.count, 1)
    }
    
    func test_MainViewModel_searchResults_shouldShowAllWhenNoSearching() {
        // Given
        let comicsDownloader = MockComicsDownloader()
        let vm = MainViewModel(comicsDownloader: comicsDownloader)
        
        vm.allComics = APIrequest(data: APIdata(results: [.sampleComic]))
        
        // When
        let title = ""
        vm.searchedTitle = title
        
        // Then
        XCTAssertEqual(vm.searchResults.count, 1)
    }
    
    func test_MainViewModel_searchResults_shouldShowNothingWhenNoMatch() {
        // Given
        let comicsDownloader = MockComicsDownloader()
        let vm = MainViewModel(comicsDownloader: comicsDownloader)
        
        vm.allComics = APIrequest(data: APIdata(results: [.sampleComic]))
        
        // When
        let title = UUID().uuidString
        vm.searchedTitle = title
        
        // Then
        XCTAssertEqual(vm.searchResults.count, 0)
    }
    
    func test_MainViewModel_fetchComics_shouldCorrectlyFetch() async {
        // Given
        let comicsDownloader = MockComicsDownloader()
        let vm = MainViewModel(comicsDownloader: comicsDownloader)
        
        // When
        await vm.fetchComics()
        
        // Then
        XCTAssertNotNil(vm.allComics)
        XCTAssertEqual(vm.allComics, comicsDownloader.comics)
    }
}
