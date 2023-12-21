//
//  DailyNewsViewModel.swift
//  DailyJournal
//
//  Created by Luka Gazdeliani on 20.12.23.
//

import SwiftUI

final class DailyNewsViewModel: ObservableObject {
    //MARK: Properties
    @Published var titleText: String = ""
    @Published var newsText: String = ""
    @Published var datePicker = Date()
    @Published var datePickerFilter = Date()
    @Published var newsArray: [News] = []
    @Published var isFilterButtonClicked = false
    @Published var favouriteNews: [News] = []
    
    //MARK: Methods
    func removeAt(_ indexSet: IndexSet) {
        newsArray.remove(atOffsets: indexSet)
    }
    
    func moveFromTo(indicies: IndexSet, newOffSet: Int) {
        newsArray.move(fromOffsets: indicies, toOffset: newOffSet)
    }
    
    func saveButtonActions() {
        if titleText == "" || newsText == "" {
            
        } else {
            saveNews()
        }
    }
    
    private func saveNews() {
        newsArray.append(News(title: titleText, newsBody: newsText, date: datePicker.formatted(date: .abbreviated, time: .omitted)))
        titleText = ""
        newsText = ""
        datePicker = Date.now
    }
    
    //TODO: დაუმთავრებელია. ჯობდა ალბათ ID დამემატებინა NewsModel-ში. Save ღილაკზე დაჭერისას, ამის ზედა ფუნქციაში შემემოწმებინა ნიუსი მაგ აიდით უკვე ხომ არ არსებობს newsArray-ში და თუ არსებობს გამოეძახებინა edit ფუნქცია.
    func editListItem(news: News) {
        let date = DateFormatter().date(from: news.date) ?? Date.now
        titleText = news.title
        newsText = news.newsBody
        datePicker = date // does not return the actual date of news. instead returns today's date
    }
    
    func filterNewsArray() {
        newsArray.removeAll(where: { $0.date != datePickerFilter.formatted(date: .abbreviated, time: .omitted) } )
        // აუ აქ ბოლოს გამახსენდა რო ორიგინალი ლისთიც შემენახა და ფილტრის მოხსნა დამემატებინა ამ ორიგინალის დასაბრუნებლად
    }
    
    func listFilterButtonClicked() {
        isFilterButtonClicked = true
    }
    
    func filterApplied() {
        isFilterButtonClicked = false
        filterNewsArray()
    }
    
    func addToFavourites(news: News) {
        favouriteNews.append(news)
        newsArray.removeAll(where: { $0 == news })
    }
}
