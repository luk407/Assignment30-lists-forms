//
//  FavouriteView.swift
//  DailyJournal
//
//  Created by Luka Gazdeliani on 20.12.23.
//

import SwiftUI

struct FavouriteView: View {
    //MARK: Properties
    @ObservedObject var favouriteViewModel: FavouriteViewModel
    
    //MARK: Body
    var body: some View {
        VStack {
            Text("Favourite News")
                .font(.system(size: 20))
            
            favListView
        }
        .padding()
        .background(Color(red: 235/255, green: 248/255, blue: 255/255))
    }
    
    //MARK: List View
    private var favListView: some View {
        List {
            ForEach(favouriteViewModel.newsViewModel.favouriteNews, id: \.self) { news in
                listItemView(news: news)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .listRowBackground(listRowItemBackground)
        }
        .listStyle(.plain)
    }
    
    //MARK: List item View
    private func listItemView(news: News) -> some View {
        HStack {
            HStack {
                Text("\(news.title)")
                Spacer()
                Text("\(news.date)")
            }
        }
    }
    
    //MARK: List row Item Background
    private var listRowItemBackground: some View {
        RoundedRectangle(cornerRadius: 8)
            .foregroundStyle(.gray.opacity(0.2))
    }
}

//#Preview {
//    FavouriteView()
//}
