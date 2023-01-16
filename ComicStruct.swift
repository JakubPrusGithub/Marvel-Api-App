//
//  ComicStruct.swift
//  ZadanieRekrutacyjne01
//
//  Created by Jakub Prus on 15/01/2023.
//

import Foundation

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
    var status: String? = ""
    var data: APIdata? = APIdata()
    
    
    
//    enum CodingKeys:String, CodingKey {
//        case status = "status"
//        case data = "data"
//    }
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.status = try container.decode(String.self, forKey: .status)
//        self.data = try container.decode(APIdata.self, forKey: .data)
//        self.id = UUID()
//    }
}
