//
//  ContentView.swift
//  GA_Tech_Int
//
//  Created by George Aldridge on 07/09/2021.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: PostListViewModel
    
    //Variables for the sort picker
    @State var selection: String = "Sort"
    @State var filterOptions: [String] = ["Default", "Rating (Asc)", "Rating (Desc)"]

    var body: some View {
        
        NavigationView {
            if viewModel.posts.isEmpty {
                EmptyStateView()
            } else {
                List(viewModel.posts) { post in
                    NavigationLink(destination: PostDetailView(post: post)) {
                        PostCardView(post: post)
                    }
                }
                .listStyle(PlainListStyle())
                .navigationBarTitle("\(viewModel.posts.count)" + " Results")
                .navigationBarItems(
                    //Refresh button that reloads the data
                    leading: Button("Refresh") {
                        viewModel.setUp()
                        selection = "Rating Sort"
                    },
                    //Sort picker giving the user 3 options
                    trailing: Picker(
                        selection: $selection,
                        label:
                            HStack {
                            Text("Sort")
                            Image(systemName: "chevron.down")
                            },
                        content: {
                            ForEach(filterOptions, id:\.self) { option in
                                Text(option)
                                    .tag(option)
                            }.onChange(of: selection, perform: { value in //When selection changes, sort out the data accordingly
                                if (value == "Rating (Asc)") {
                                    viewModel.posts.sort{ $0.averageUserRating < $1.averageUserRating}
                                } else if (value == "Rating (Desc)") {
                                    viewModel.posts.sort{ $0.averageUserRating > $1.averageUserRating}
                                } else {
                                    viewModel.setUp() //Refreshing for default as default sort order unknown
                                }
                            })
                        }
                    ).pickerStyle(MenuPickerStyle())
                )
            }
        }
//        .alert(item: $DataModel.appError) { app Error in
//            Alert(title: Text("Oh Oh"), message:
//            Text(appError.error.localizedDescription)
//            )
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: PostListViewModel())
    }
}
