//
//  ArtworkView.swift
//  GA_Tech_Int
//
//  Created by George Aldridge on 08/09/2021.
//

import SwiftUI

struct ArtworkView: View {
    let image: Image?

    var body: some View {
        ZStack {
            if image != nil { //Display artwork image
                image?
                    .resizable()
            } else { //Alternate view if result has no artwork image
                Color(.systemBlue)
                Image(systemName: "questionmark")
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
        }
    }
}

//struct ArtworkView_Previews: PreviewProvider {
//    static var previews: some View {
//        ArtworkView(image: )
//    }
//}
