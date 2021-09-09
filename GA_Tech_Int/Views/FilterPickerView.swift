//
//  FilterPickerView.swift
//  GA_Tech_Int
//
//  Created by George Aldridge on 07/09/2021.
//

//import SwiftUI
//
//struct FilterPickerView: View {
//    @State var selection: String = "Sort"
//    @State var filterOptions: [String] = ["Default", "Rating"]
//    @ObservedObject var viewModel: PostListViewModel
    
//    func sortPosts(value: String) {
//        if value == "Default" {
//            viewModel.setUp() //Unsure what default filter is so this resets
//        } else if value == "Rating" {
//            viewModel.posts.sort{ $0.averageUserRating > $1.averageUserRating}
//        } else {
//            viewModel.setUp()
//        }
//    }
    
//    var body: some View {
//        Picker(selection, selection: $selection) {
//            ForEach(filterOptions, id:\.self) { option in
//                Text(option)
//                    .tag(option)
//            }.onChange(of: selection, perform: { value in
//                if (selection == "Rating") {
//                    viewModel.posts.sort{ $0.averageUserRating > $1.averageUserRating}
//                } else {
//                    viewModel.setUp()
//                }
//            })
//        }.pickerStyle(MenuPickerStyle())
//    }
//}


//struct FilterPickerView_Previews: PreviewProvider {
//    static var previews: some View {
//        FilterPickerView()
//    }
//}

