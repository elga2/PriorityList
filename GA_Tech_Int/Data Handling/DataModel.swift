//
//  DataModel.swift
//  GA_Tech_Int
//
//  Created by George Aldridge on 07/09/2021.
//

import Foundation

// Defining post properties
struct PostData: Decodable  {
    let id : Int
    let trackName: String
    let version: String
    var versionReleaseDate: String
    let fileSize: String
    var userRatingCount: Int
    let averageUserRating: Double
    let releaseNotes: String
    let artworkUrl: String
    
    //Binding API field names to post properties
    enum CodingKeys: String, CodingKey {
        case id = "trackId"
        case trackName
        case version
        case versionReleaseDate = "currentVersionReleaseDate"
        case fileSize = "fileSizeBytes"
        case userRatingCount = "userRatingCountForCurrentVersion"
        case averageUserRating = "averageUserRatingForCurrentVersion"
        case releaseNotes
        case artworkUrl = "artworkUrl100"
    }
    
    //Parsing the data
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.releaseNotes = try values.decodeIfPresent(String.self, forKey: .releaseNotes) ?? "No release notes"
        self.id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
        self.trackName = try values.decodeIfPresent(String.self, forKey: .trackName) ?? "No track name"
        self.version = try values.decodeIfPresent(String.self, forKey: .version) ?? "No version"
        self.versionReleaseDate = try values.decodeIfPresent(String.self, forKey: .versionReleaseDate) ?? "2000-01-01T00:00:00Z"
        
        //Format date to specified format upon reading data
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXXXX"
        let date = dateFormatter.date(from: self.versionReleaseDate)
        dateFormatter.dateFormat = "E, d MMM yyyy HH:mm"

        self.versionReleaseDate = dateFormatter.string(from: date ?? Date())
        
        self.fileSize = try values.decodeIfPresent(String.self, forKey: .fileSize) ?? "No file size"
        self.userRatingCount = try values.decodeIfPresent(Int.self, forKey: .userRatingCount) ?? 0
        
        //Number formatting to 2 significant figures
        let formatter = NumberFormatter()
        formatter.usesSignificantDigits = true
        formatter.maximumSignificantDigits = 2
        formatter.minimumSignificantDigits = 1

        if let result = formatter.string(from: NSNumber(value: userRatingCount)) {
            self.userRatingCount = Int(result) ?? 0
        }
        
        self.averageUserRating = try values.decodeIfPresent(Double.self, forKey: .averageUserRating) ?? 0.0
        self.artworkUrl = try values.decodeIfPresent(String.self, forKey: .artworkUrl) ?? "No artwork"

    }
}

// Setting up array of post items
struct PostList: Decodable {
    let posts: [PostData]
    
    enum CodingKeys: String, CodingKey {
        case posts = "results"
    }
}

// Methods sending requests for data from API
class DataModel {
        
    private var dataTask: URLSessionDataTask?
    
    //Loading data from API
    func loadPosts(completion: @escaping(([PostData]) -> Void)) { //error needed if data doesn't load correctly
        dataTask?.cancel()
        guard let url = buildUrl() else {
            completion([])
            return
        }
        //Call for data asynchronously to prevent slowing user experience
        dataTask = URLSession.shared.dataTask(with: url) { data, _, _ in
            DispatchQueue.main.async {
                guard let data = data else {
                    completion([])
                    return
                }
                if let postList = try? JSONDecoder().decode(PostList.self, from: data) {
                    completion(postList.posts)
                }
            }
        }
        dataTask?.resume()
    }
    
    // Constructs URL based on given search parameters and keys
    // Scope for adding new or updated parameters later or combining with a search option
    private func buildUrl() -> URL? {
        
        let queryItems = [
            URLQueryItem(name: "term", value: "priority"),
            URLQueryItem(name: "country", value: "gb"),
            URLQueryItem(name: "entity", value: "software")
        ]
        var components = URLComponents(string: "https://itunes.apple.com/search")
        components?.queryItems = queryItems
        
        return components?.url
    }
}

