//
//  ArtworkLoader.swift
//  GA_Tech_Int
//
//  Created by George Aldridge on 07/09/2021.
//

import Foundation
import SwiftUI

//Building the tasks to load the images from API asynchronously
class ArtworkLoader {
    private var dataTasks: [URLSessionDataTask] = []
    
    func loadArtwork(forPost post: PostData, completion: @escaping((Image?) -> Void)) {
        //Get URL string and converting to URL object
        guard let imageUrl = URL(string: post.artworkUrl) else {
            completion(nil)
            return
        }
        
        //Create data task if we are able to create URL then append to data tasks so we can download the image
        let dataTask = URLSession.shared.dataTask(with: imageUrl) { data, _, _ in
            guard let data = data, let artwork = UIImage(data: data) else {
                completion(nil)
                return
            }
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
