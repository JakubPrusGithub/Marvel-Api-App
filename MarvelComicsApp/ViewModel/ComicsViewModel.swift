//
//  ComicsViewModel.swift
//  MarvelComicsApp
//
//  Created by Jakub Prus on 08/04/2023.
//

import Foundation

class ComicsViewModel: ObservableObject {
    @Published var allComics = APIrequest()
    
}
