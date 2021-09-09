//
//  ArtworkLoader.swift
//  GA_Tech_Int
//
//  Created by George Aldridge on 07/09/2021.
//

import Foundation
import SwiftUI

//Building the taks to load the images from API asynchronously
class ArtworkLoader {
    private var dataTasks: [URLSessionDataTask] = []
    
    func loadArtwork(forPost post: PostData, completion: @escaping((Image?) -> Void)) {
        //Build URL for artwork
        guard let imageUrl = URL(string: post.artworkUrl) else {
            completion(nil)
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: imageUrl) { data, _, _ in
            //Make sure we got data for image
            guard let data = data, let artwork = UIImage(data: data) else {
                completion(nil)
                return
            }
            //Create image object
            let image = Image(uiImage: artwork)
            completion(image)
        }
        dataTasks.append(dataTask)
        dataTask.resume()
    }
    
    func reset() {
        dataTasks.forEach { $0.cancel() }
    }
}
