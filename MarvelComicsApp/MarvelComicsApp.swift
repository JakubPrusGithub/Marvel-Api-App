//
//  MarvelComicsApp.swift
//  MarvelComicsApp
//
//  Created by Jakub Prus on 14/01/2023.
//  Refactored by Jakub Prus on 08/04/2023.
//

import SwiftUI

@main
struct MarvelComicsApp: App {
    var body: some Scene {
        WindowGroup {
            MainView(comicsDownloader: ComicsDownloader())  // Real API Call
            //MainView(comicsDownloader: MockComicsDownloader())    // Dependency Injection
        }
    }
}
