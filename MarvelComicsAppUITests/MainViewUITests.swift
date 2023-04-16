//
//  MainViewUITests.swift
//  MarvelComicsAppUITests
//
//  Created by Jakub Prus on 15/04/2023.
//

import XCTest

// Naming Structure: test_UnitOfWork_StateUnderTest_ExpectedBehaviour

// Testing Structure: Given, When, Then

final class MainViewUITests: XCTestCase {
    
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws { }
    
    func test_MainView_ForEach_isClickable() {
        // Given
        app.launch()
        
        // When
        sleep(5)
        
        // Then
        app.scrollViews.otherElements.buttons.firstMatch.tap()
    }
    
    func test_MainView_Sheet_isDraggable() {
        // Given
        app.launch()

        // When
        sleep(5)
        app.scrollViews.otherElements.buttons.firstMatch.tap()
        sleep(1)

        // Then
        
        app.buttons["Sheet Grabber"].swipeUp()
        app.buttons["Sheet Grabber"].swipeUp()
    }
    
    func test_MainView_Sheet_isDismissable() {
        // Given
        app.launch()

        // When
        sleep(5)
        app.scrollViews.otherElements.buttons.firstMatch.tap()
        sleep(1)

        // Then
        let popoverdismissregionElement = app.windows.children(matching: .other).element(boundBy: 1)/*@START_MENU_TOKEN@*/.otherElements["PopoverDismissRegion"]/*[[".otherElements[\"dismiss popup\"]",".otherElements[\"PopoverDismissRegion\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        popoverdismissregionElement.tap()
        sleep(1)
        XCTAssertFalse(popoverdismissregionElement.exists)
    }
    
    func test_MainView_backButton_isAbleToReturnToMainView(){
        // Given
        app.launch()
        
        // When
        sleep(5)
        app.scrollViews.otherElements.buttons.firstMatch.tap()
        sleep(1)
        let popoverdismissregionElement = app.windows.children(matching: .other).element(boundBy: 1)/*@START_MENU_TOKEN@*/.otherElements["PopoverDismissRegion"]/*[[".otherElements[\"dismiss popup\"]",".otherElements[\"PopoverDismissRegion\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        popoverdismissregionElement.tap()
        sleep(1)
        
        app.navigationBars["Details"].buttons["Marvel Comics"].tap()
        
        // Then
        let marvelComicsStartScreen = app.navigationBars["Marvel Comics"].staticTexts["Marvel Comics"]
        XCTAssertTrue(marvelComicsStartScreen.exists)
    }
    
    func test_MainView_Searchbar_isClickable() {
        // Given
        app.launch()
        
        // When
        let searchbar = app.navigationBars["Marvel Comics"].searchFields["Search your comic's title"]
        searchbar.tap()
        
        // Then
        XCTAssertTrue(searchbar.exists)
        XCTAssertTrue(searchbar.isHittable)
        XCTAssertTrue(searchbar.isEnabled)
    }
    
    func test_MainView_Searchbar_presentsClickableResults(){
        // Given
        app.launch()
        sleep(5)
        
        // When
        app.navigationBars["Marvel Comics"].searchFields["Search your comic's title"].tap()
        
        // --- Searching "Title" keyword ---
        app/*@START_MENU_TOKEN@*/.keys["T"]/*[[".keyboards.keys[\"T\"]",".keys[\"T\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["i"]/*[[".keyboards.keys[\"i\"]",".keys[\"i\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["t"]/*[[".keyboards.keys[\"t\"]",".keys[\"t\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["l"]/*[[".keyboards.keys[\"l\"]",".keys[\"l\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["e"]/*[[".keyboards.keys[\"e\"]",".keys[\"e\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        // Then
        let result = app.scrollViews.otherElements.buttons.firstMatch
        XCTAssertTrue(result.exists)
    }
}
