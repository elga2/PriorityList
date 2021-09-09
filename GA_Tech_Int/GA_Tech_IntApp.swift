//
//  GA_Tech_IntApp.swift
//  GA_Tech_Int
//
//  Created by George Aldridge on 07/09/2021.
//

import SwiftUI

@main
struct GA_Tech_IntApp: App {
    @StateObject var postListViewModel = PostListViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: PostListViewModel())
        }
    }
}
