//
//  DailyJournalApp.swift
//  DailyJournal
//
//  Created by Luka Gazdeliani on 20.12.23.
//

import SwiftUI

@main
struct DailyJournalApp: App {
    //MARK: Properties
    @StateObject var newsViewModel = DailyNewsViewModel()
    
    //MARK: Body
    var body: some Scene {
        //MARK: Properties
        WindowGroup {
            NavigationStack {
                TabView {
                    DailyNewsView(newsViewModel: newsViewModel)
                        .tabItem {
                            Image(systemName: "newspaper")
                            Text("News")
                        }
                        .tag("news")
                    
                    FavouriteView(favouriteViewModel: FavouriteViewModel(newsViewModel: newsViewModel))
                        .tabItem {
                            Image(systemName: "star")
                            Text("Favourites")
                        }
                        .tag("fav")
                }
            }
        }
    }
}
