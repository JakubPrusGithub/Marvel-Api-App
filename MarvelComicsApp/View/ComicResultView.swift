//
//  ComicResultView.swift
//  MarvelComicsApp
//
//  Created by Jakub Prus on 08/04/2023.
//

import SwiftUI

struct ComicResultView: View {
    
    @StateObject var vm = ComicViewModel()
    let comic: Comic
    
    var body: some View {
        NavigationLink(destination: DetailComicView(comic: comic)){
            HStack(){
                AsyncImage(
                    url: URL(string: vm.getThumbnailLink(comic: comic)),
                    content: { image in
                        image
                            .resizable()
                            .scaledToFit()
                            //.frame(height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    },
                    placeholder: {
                        ProgressView()
                    }
                ) // AsyncImage
                .frame(width: 135, height: 200)
                Spacer()
                VStack(alignment: .leading){
                    Text(comic.title ?? "No title")
                        .font(.title3)
                        .lineLimit(2)
                        .bold()
                    Text("Written by " + vm.getAuthors(comic: comic))
                        .font(.caption)
                        .foregroundColor(.gray)
                    Spacer()
                    Text(comic.description ?? "No description provided")
                    Spacer()
                } // VStack
                .padding(10)
                
            } // HStack
            .frame(maxWidth: .infinity, maxHeight: 200)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(10)
            .shadow(radius: 5)
            
        } // NavigationLink
        .foregroundColor(.black)
    }
}

struct ComicResult_Previews: PreviewProvider {
    static var previews: some View {
        ComicResultView(comic: Comic())
    }
}
