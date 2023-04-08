//
//  MainView.swift
//  MarvelComicsApp
//
//  Created by Jakub Prus on 14/01/2023.
//  Refactored by Jakub Prus on 08/04/2023.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var vm = ComicsViewModel()
    @State var searchedTitle = ""
    var searchResults: [Comic] {
        if searchedTitle.isEmpty {
            return (vm.allComics.data?.results)!
        }else{
            return (vm.allComics.data?.results?.filter { ($0.title?.localizedCaseInsensitiveContains(searchedTitle))!})!
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(searchResults) { comic in
                    NavigationLink(destination: DetailView(comic: comic, imageURL: comic.thumbnail?.linkDetail ?? "")){
                        HStack(){
                            AsyncImage(
                                url: URL(string: comic.thumbnail?.link ?? ""),
                                content: { image in
                                    image.resizable()
                                        .scaledToFit()
                                        .frame(height: 200)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                },
                                placeholder: {ProgressView()}
                            )
                            VStack(alignment: .leading){
                                Text(comic.title ?? "No title")
                                    .font(.title3)
                                    .lineLimit(2)
                                    .bold()
                                Text("written by \(((comic.creators?.items!.isEmpty)! ? "anonymous" : comic.creators?.items![0].name)!)")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                Spacer()
                                Text((comic.description!.isEmpty ? "No description" : comic.description)!)
                                Spacer()
                            }
                            .padding(10)
                        }
                        .frame(maxWidth: .infinity, maxHeight: 200)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(10)
                    .shadow(radius: 5)
                    }
                    .foregroundColor(.black)
                }
            }
            .task{
                vm.allComics = await ComicsDownloader().downloadData() ?? APIrequest()
            }
            .navigationTitle("Marvel Comics")
            .searchable(text: $searchedTitle, prompt: "Search your comic's title")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
