//
//  PostDetailView.swift
//  GA_Tech_Int
//
//  Created by George Aldridge on 08/09/2021.
//

import SwiftUI

struct PostDetailView: View {
    
    let post: PostViewModel
    
    var body: some View {
        
        //Rounding user rating to 1 decimal place
        let roundedRating = String(format: "%1.f", post.averageUserRating)

        //Formatting detail view
        VStack (alignment: .leading) {
            HStack {
                Spacer()
                ArtworkView(image: post.artwork)
                    .frame(width: 150, height: 150)
                    .padding()
                Spacer()
            }
            
            Text(post.trackName)
                .bold()
                .font(.title)
                .padding()

            Text("\(post.versionReleaseDate)")
                .font(.footnote)
                .padding(.leading)
            
            HStack {
                Text("Release Notes:")
                    .font(.title2)
                    .padding(.leading)
                    .padding(.bottom, 3)
                Spacer()
            }

            HStack {
                Text(post.releaseNotes)
                    .font(.body)
                    .padding(.leading)
                Spacer()
            }
            .padding(.bottom)
            
            HStack {
                Text("App Rating: ")
                Text("\(post.averageUserRating, specifier: "%.1f")")
                    .bold()
                    .foregroundColor(Color("Rating"+"\(roundedRating)"))
            }
            .font(.title)
            .padding(.leading)
            
            Spacer()
            
            HStack {
                Text("V." + "\(post.version)")
                    .padding()
                Spacer()
                Text("File Size: " + "\((Int(post.fileSize)!/1000000))" + " MB")
                    .padding()
            }
        }
    }
}
