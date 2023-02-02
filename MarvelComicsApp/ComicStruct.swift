//
//  ComicStruct.swift
//  MarvelComicsApp
//
//  Created by Jakub Prus on 15/01/2023.
//

import Foundation

/*
    --- API CONSTRUCTION MODEL ---
 
    API struct hierarchy:
 
    *APIrequest*
        - data: APIdata
            - results: [Comic]
                - id: Sting
                - title: String
                - description: String
                - thumbnail: APIthumbnail
                    - path: String              # URL String to image wihtout "https" and size
                    - link: String              # URL String to image 150x225px
                    - linkDetail: String        # URL String to image 216x324px
                - creators: APIauthors
                    - items: [APIauthor]
                        - name: String
 

 
 
 
 
    --- IMAGE URL CONSTRUCTION MODEL ---
 
    Scheme to construct an image from api:
    <URL from API> + <sizing> + <.extension>
    
    Remember: convert URL from "http" to "https" & <.extension> is ".jpg" preferred
 
    Link for naming sizing and ratios of images:
    https://developer.marvel.com/documentation/images
 
 
*/

struct APIauthor: Codable{
    var name: String? = ""
}

struct APIauthors: Codable {
    var items: [APIauthor]? = [APIauthor]()
}

struct APIthumbnail: Codable {
    var path: String? = ""
    var link: String {
        guard var pathUnwrapped = path else { return "" }
        if let range = pathUnwrapped.range(of: "http"){
            pathUnwrapped = pathUnwrapped.replacingCharacters(in: range, with: "https")
        }
        let ext = "/portrait_xlarge.jpg"
        return pathUnwrapped+ext
    }
    var linkDetail: String {
        guard var pathUnwrapped = path else { return "" }
        if let range = pathUnwrapped.range(of: "http"){
            pathUnwrapped = pathUnwrapped.replacingCharacters(in: range, with: "https")
        }
        let ext = "/portrait_incredible.jpg"
        return pathUnwrapped+ext
    }
}

struct Comic: Codable, Identifiable {
    var id: Int? = Int()
    var title: String? = ""
    var description: String? = ""
    var thumbnail: APIthumbnail? = APIthumbnail()
    var creators: APIauthors? = APIauthors()
}

struct APIdata: Codable {
    var results: [Comic]? = [Comic]()
}

struct APIrequest: Codable{
    var data: APIdata? = APIdata()
}
