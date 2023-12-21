//
//  FavouriteViewModel.swift
//  DailyJournal
//
//  Created by Luka Gazdeliani on 20.12.23.
//

import SwiftUI

final class FavouriteViewModel: ObservableObject {
    //MARK: Properties
    @ObservedObject var newsViewModel: DailyNewsViewModel
    
    //MARK: Init
    init(newsViewModel: DailyNewsViewModel) {
        self.newsViewModel = newsViewModel
    }
}
