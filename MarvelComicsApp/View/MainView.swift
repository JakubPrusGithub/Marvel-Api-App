//
//  MainView.swift
//  MarvelComicsApp
//
//  Created by Jakub Prus on 14/01/2023.
//  Refactored by Jakub Prus on 08/04/2023.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var vm: MainViewModel
    
    init(comicsDownloader: ComicsProvider) {
        _vm = StateObject(wrappedValue: MainViewModel(comicsDownloader: comicsDownloader))
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                
                if vm.allComics.data == nil {
                    loadingScreen
                } else {
                    ForEach(vm.searchResults) { comic in
                        ComicResultView(comic: comic)
                    }
                }
                
            } // ScrollView
            .navigationTitle("Marvel Comics")
            .searchable(text: $vm.searchedTitle, prompt: "Search your comic's title")
            .task{
                await vm.fetchComics()
            }
            
        } // NavigationView
    }
}

extension MainView {
    
    var loadingScreen: some View {
        VStack(){
            ProgressView()
                .padding()
            Text("Downloading comics, please wait...")
                .foregroundColor(.gray)
        }
        .padding(100)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(comicsDownloader: MockComicsDownloader())
    }
}
