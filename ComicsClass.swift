//
//  ComicsClass.swift
//  ZadanieRekrutacyjne01
//
//  Created by Jakub Prus on 15/01/2023.
//

import Foundation

final class AllComics: ObservableObject {
    @Published var comics = APIrequest()
    
    init() {
        fetchData()
    }
    
    func fetchData(){
        let ts = String("\(NSDate().timeIntervalSince1970)")
        let publicKey = "e3b3568badbe60e5a37984a5ce579546"
        let privateKey = "e76d76c04475c769b78e5b509d372b2189120e98"
        var hash = ts+privateKey+publicKey
        hash = hash.MD5
        let query = "https://gateway.marvel.com:443/v1/public/comics?format=comic&limit=10"
        let link = query + "&ts=" + ts + "&apikey=" + publicKey + "&hash=" + hash
        guard let url = URL(string: link) else {return}
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let data = data{
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(APIrequest.self, from: data)
                    DispatchQueue.main.async {
                        self.comics = response
                    }
                }
                catch {
                    print(error)
                }
            }
        }.resume()
    }
}
