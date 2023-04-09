//
//  MainViewModel.swift
//  MarvelComicsApp
//
//  Created by Jakub Prus on 08/04/2023.
//

import Foundation

class MainViewModel: ObservableObject {
    @Published var allComics = APIrequest()
    
    @Published var searchedTitle = ""
    
    var searchResults: [Comic] {
        guard
            let comics = allComics.data,
            let results = comics.results
        else { return [Comic]() }
        
        if searchedTitle.isEmpty {
            return results
        }
        else {
            return results.filter { ($0.title?.localizedCaseInsensitiveContains(searchedTitle)) ?? false }
        }
    }
}
