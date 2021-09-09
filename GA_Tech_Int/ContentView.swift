//
//  ContentView.swift
//  GA_Tech_Int
//
//  Created by George Aldridge on 07/09/2021.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: PostListViewModel
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
                    leading: Button("Refresh") {
                        viewModel.setUp()
                        selection = "Rating Sort"
                    },
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
                            }.onChange(of: selection, perform: { value in
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

//                    trailing: Picker("Sort", selection: $selection) {
//                        ForEach(filterOptions, id:\.self) { option in
//                            Text(option)
//                                .tag(option)
//                        }.onChange(of: selection, perform: { value in
//                            if (value == "Rating (Asc)") {
//                                viewModel.posts.sort{ $0.averageUserRating < $1.averageUserRating}
//                            } else if (value == "Rating (Desc)") {
//                                viewModel.posts.sort{ $0.averageUserRating > $1.averageUserRating}
//                            } else {
//                                viewModel.setUp() //Refreshing for default as default sort order unknown
//                            }
//                        })
//                    }.pickerStyle(MenuPickerStyle())
//                )
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: PostListViewModel())
    }
}
