//
//  ContentView.swift
//  DailyJournal
//
//  Created by Luka Gazdeliani on 20.12.23.
//

import SwiftUI

struct DailyNewsView: View {
    //MARK: Properties
    @ObservedObject var newsViewModel: DailyNewsViewModel
    
    //MARK: Body
    var body: some View {
        VStack(spacing: 20) {
            appHeader
            
            journalEntryForm
            
            newsListView
        }
        .padding()
        .background(Color(red: 235/255, green: 248/255, blue: 255/255))
    }
    
    //MARK: App Header
    private var appHeader: some View {
        HStack(spacing: 20, content: {
            Image(systemName: "newspaper.fill")
                .resizable()
                .frame(width: 20, height: 20)
            
            Text("JournalApp")
                .bold()
                .font(.system(size: 20))
            
            Spacer()
        })
        .foregroundStyle(.black)
    }
    
    //MARK: JournalEntryForm
    private var journalEntryForm: some View {
        VStack(spacing: 10, content: {
            titleTextFieldView
            
            newsTextFieldView
            
            datePickerView
            
            saveButtonView
        })
    }
    
    //MARK: Title text field
    private var titleTextFieldView: some View {
        TextField("Type the title...", text: $newsViewModel.titleText)
            .textFieldStyle(.roundedBorder)
    }
    
    //MARK: New text field
    private var newsTextFieldView: some View {
        TextField("Type the news...", text: $newsViewModel.newsText, axis: .vertical)
            .lineLimit(3...5)
            .textFieldStyle(.roundedBorder)
    }
    
    //MARK: Date Picker
    private var datePickerView: some View {
        DatePicker("Pick a Date...", selection: $newsViewModel.datePicker, displayedComponents: .date)
    }
    
    //MARK: Save Button
    private var saveButtonView: some View {
        HStack {
            Button {
                newsViewModel.saveButtonActions()
            } label: {
                if newsViewModel.titleText == "" || newsViewModel.newsText == "" {
                    Text("Fill all fields")
                } else {
                    Text("Save")
                }
            }
            .buttonStyle(.bordered)
            .foregroundStyle(.black)
        }
    }
    
    //MARK: News List
    private var newsListView: some View {
        VStack(spacing: 10) {
            if newsViewModel.newsArray.isEmpty {
                emptyStateView
            } else {
                listView
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    //MARK: Empty State View
    private var emptyStateView: some View {
        VStack(spacing: 40, content: {
            Spacer()
            
            Image(systemName: "list.bullet")
                .resizable()
                .frame(width: 50, height: 50)
            
            Spacer()
            
            Text("Oops... No news")
                .font(.system(size: 30))
            
            Spacer()
        })
        .frame(maxWidth: .infinity)
        .opacity(0.5)
        .background(.gray.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
    
    //MARK: List View
    private var listView: some View {
        VStack(spacing: 20) {
            List {
                newsSection
            }
            .listStyle(.plain)
            
            listFilterButton
        }
        .padding()
        .background(.gray.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 8))
        
    }
    
    //MARK: News Section
    private var newsSection: some View {
        Section("News") {
            ForEach(newsViewModel.newsArray, id: \.self) { news in
                listItemView(news: news)
                    .swipeActions(edge: .leading, content: {
                        Button {
                            newsViewModel.addToFavourites(news: news)
                        } label: {
                            Text("Add to favourites")
                        }
                        .tint(.yellow)
                    })
            }
            .onDelete(perform: { indexSet in
                newsViewModel.removeAt(indexSet)
            })
            .onMove(perform: { indices, newOffset in
                newsViewModel.moveFromTo(indicies: indices, newOffSet: newOffset)
            })
        }
        .listRowSeparator(.hidden)
        .listRowBackground(listRowItemBackground)
    }
    
    //MARK: List Item View
    private func listItemView(news: News) -> some View {
        HStack {
            Text("\(news.title)")
            Spacer()
            Text("\(news.date)")
        }
        .frame(height: 30)
        .padding(.horizontal)
        .onTapGesture {
            newsViewModel.editListItem(news: news)
        }
    }
    
    private var listRowItemBackground: some View {
        RoundedRectangle(cornerRadius: 8)
            .foregroundStyle(.gray.opacity(0.2))
    }
    
    //MARK: List Filter Button
    private var listFilterButton: some View {
        HStack {
            if !newsViewModel.isFilterButtonClicked {
                Button {
                    newsViewModel.listFilterButtonClicked()
                } label: {
                    Text("Filter List By Date")
                }
                .buttonStyle(.bordered)
                .foregroundStyle(.black)
            } else {
                Button { //პირდაპირ ეს ღილაკი რო გამოჩენილიყო და ზედა if მომეხნა შეიძლებოდა. რატო გავირთულე საქმე ნე ზნაიუ.
                    newsViewModel.filterApplied()
                } label: {
                    Text("Apply Filter")
                }
                .buttonStyle(.bordered)
                .foregroundStyle(.black)
                
                DatePicker("", selection: $newsViewModel.datePickerFilter, displayedComponents: .date)
            }
        }
    }
}

//#Preview {
//    DailyNewsView()
//}
