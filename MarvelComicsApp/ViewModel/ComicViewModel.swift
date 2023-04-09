//
//  ComicViewModel.swift
//  MarvelComicsApp
//
//  Created by Jakub Prus on 09/04/2023.
//

import Foundation

class ComicViewModel: ObservableObject {
    
    
    func getAuthors(comic: Comic) -> String {
        guard
            let creators = comic.creators,
            let authors = creators.items,
            authors.count > 0
        else{
            return "Anonymous"
        }
        var result = ""
        for i in 0..<(authors.count) {
            result += (authors[i].name ?? "Anonymous") + ", "
        }
        
        // Delete ", " and replace it with period
        result = String(result.dropLast(2))
        result += "."
        return result
    }
    
    func getThumbnailLink(comic: Comic) -> String{
        guard let thumbnail = comic.thumbnail else { return "" }
        return thumbnail.link
    }
    
    func getThumbnailLinkDetail(comic: Comic) -> String{
        guard let thumbnail = comic.thumbnail else { return "" }
        return thumbnail.linkDetail
    }
}
