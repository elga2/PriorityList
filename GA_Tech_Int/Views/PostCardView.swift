//
//  PostCardView.swift
//  GA_Tech_Int
//
//  Created by George Aldridge on 08/09/2021.
//

import Foundation
import SwiftUI

struct PostCardView: View {
    @ObservedObject var post: PostViewModel
    
    var body: some View {
        
        //Rounding user rating to 1 decimal place
        let roundedRating = String(format: "%1.f", post.averageUserRating)
        
        //Formatting individual card view
        HStack {
            ArtworkView(image: post.artwork)
                .frame(width: 100, height: 100, alignment: .center)
            HStack {
                VStack(alignment: .leading) {
                    Text(post.trackName)
                        .font(.system(size: 17, weight: .bold, design: .default))
                    Text(post.version)
                        .font(.system(size: 12, weight: .regular, design: .default))
                    HStack {
                        VStack(alignment: .leading) {
                            Text(post.versionReleaseDate)
                                .font(.system(size: 12, weight: .regular, design: .default))
                            Text("\((Int(post.fileSize)!/1000000))" + " MB")
                                .font(.system(size: 12, weight: .regular, design: .default))
                            Text("\(post.userRatingCount)")
                                .font(.system(size: 12, weight: .regular, design: .default))
                        }
                        Spacer()
                        Text("\(post.averageUserRating, specifier: "%.1f")")
                            .font(.system(size: 40, weight: .regular, design: .default))
                            .foregroundColor(Color("Rating"+"\(roundedRating)"))
                    }
                }
            }
        }
    }
}

//struct PostCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostCardView(post: PostListViewModel().posts[0])
//    }
//}
