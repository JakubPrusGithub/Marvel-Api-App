//
//  ComicsClass.swift
//  MarvelComicsApp
//
//  Created by Jakub Prus on 15/01/2023.
//  Refactored by Jakub Prus on 08/04/2023.
//

import Foundation

protocol ComicsProvider {
    func downloadData() async -> APIrequest?
}

class ComicsDownloader: ComicsProvider {
    func downloadData() async -> APIrequest? {
        let ts = String("\(NSDate().timeIntervalSince1970)")                                      // Timestamp since 1970
        
        let publicKey = "e3b3568badbe60e5a37984a5ce579546"                                        // Provided by Marvel - keep it secure
        let privateKey = "e76d76c04475c769b78e5b509d372b2189120e98"                               // Provided by Marvel - keep it secure
        
        var hash = ts+privateKey+publicKey                                                        // Hash is constructed by combining:
                                                                                                  // timestamp + privateKey + publicKey
        
        hash = hash.MD5                                                                           // Converting hash to md5 format
        
        let query = "https://gateway.marvel.com:443/v1/public/comics?format=comic"                // Query for random comics
        
        let link = query + "&ts=" + ts + "&apikey=" + publicKey + "&hash=" + hash                 // Constructing final link for API call
        guard let url = URL(string: link) else { return nil }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let response = response as? HTTPURLResponse,
                  response.statusCode >= 200 && response.statusCode < 300
            else {
                throw URLError(.badServerResponse)
            }
            let comics = try JSONDecoder().decode(APIrequest.self, from: data)
            return comics
            
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}

class MockComicsDownloader: ComicsProvider {
    
    let comics = APIrequest(data: APIdata(
        results: [
            Comic(id: 1, title: "First title", description: "First description", thumbnail: .sampleAPIthumbnail, creators: APIauthors(items: [APIauthor(name: "First author")])),
            
            Comic(id: 2, title: "Second title", description: "Second description", thumbnail: .sampleAPIthumbnail, creators: APIauthors(items: [APIauthor(name: "Second author")])),
            
            Comic(id: 3, title: "Third title", description: "Third description", thumbnail: .sampleAPIthumbnail, creators: APIauthors(items: [APIauthor(name: "Third author")]))
        ]))
    
    func downloadData() async -> APIrequest? {
        try? await Task.sleep(nanoseconds: 3_000_000_000)
        return comics
    }
}
