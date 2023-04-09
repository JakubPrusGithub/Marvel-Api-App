//
//  DetailComicView.swift
//  MarvelComicsApp
//
//  Created by Jakub Prus on 15/01/2023.
//  Refactored by Jakub Prus on 08/04/2023.
//

import SwiftUI

struct DetailComicView: View {
    
    @StateObject var vm = ComicViewModel()
    let comic: Comic
    
    // The sheet is presented first by default
    @State var presentingSheet = true
    
    var body: some View {
        VStack {
            AsyncImage(
                url: URL(string: vm.getThumbnailLinkDetail(comic: comic)),
                content: { image in
                    image
                        .resizable()
                        .scaledToFit()
                },
                placeholder: {
                    ProgressView()
                }
            ) // AsyncImage
            
            Text("Thumbnail art for \(comic.title ?? "No title")")
                .foregroundColor(.gray)
            
            Spacer()
            
        } // VStack
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $presentingSheet){
            VStack(alignment: .leading, spacing: 15) {
                Text(comic.title ?? "No title")
                    .font(.title)
                    .bold()
                Text(vm.getAuthors(comic: comic))
                    .font(.callout)
                    .foregroundColor(.gray)
                Text(comic.description ?? "No description provided")
            }
            .padding()
            .presentationDetents([.medium, .large, .fraction(0.3)])
        } // sheet
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        //DetailComicView(comic: Comic(title: "Title of a Marvel Comic", description: "Very long and detailed description about currently selected Marvel comic", creators: APIauthors(items: [APIauthor(name: "Written by anonymous")])))
        DetailComicView(comic: Comic())
    }
}
