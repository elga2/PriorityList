//
//  PostListViewModel.swift
//  GA_Tech_Int
//
//  Created by George Aldridge on 07/09/2021.
//

import Foundation
import SwiftUI

//Represent all results from a call to the API
class PostListViewModel: ObservableObject {
    @Published public var posts: [PostViewModel] = []
    
    private let dataModel: DataModel = DataModel()
    private let artworkLoader: ArtworkLoader = ArtworkLoader()
    
    init() {
        setUp()
    }
    
    //Removes and resets data/artwork before loading newly pulled data
    public func setUp() {
        posts.removeAll()
        artworkLoader.reset()
        dataModel.loadPosts() { posts in
            posts.forEach { self.appendPost(post: $0)}
        }
    }
    
    private func appendPost(post: PostData) {
        let postViewModel = PostViewModel(post: post)
        DispatchQueue.main.async {
            self.posts.append(postViewModel)
        }
        
        artworkLoader.loadArtwork(forPost: post) { image in
            DispatchQueue.main.async {
                postViewModel.artwork = image
            }
        }
    }
}

class PostViewModel: Identifiable, ObservableObject {
    let id: Int
    let trackName: String
    let version: String
    let versionReleaseDate: String
    let fileSize: String
    let userRatingCount: Int
    let averageUserRating: Double
    let releaseNotes: String
    @Published var artwork: Image?
    
    init(post: PostData) {
        self.id = post.id
        self.trackName = post.trackName
        self.version = post.version
        self.versionReleaseDate = post.versionReleaseDate
        self.fileSize = post.fileSize
        self.userRatingCount = post.userRatingCount
        self.averageUserRating = post.averageUserRating
        self.releaseNotes = post.releaseNotes
    }
}

