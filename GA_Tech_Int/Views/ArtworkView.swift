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
            if image != nil {
                image?
                    .resizable()
            } else {
                Color(.systemBlue)
                Image(systemName: "questionmark")
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
        }
        //.frame(width: 100, height: 100)
    }
}

//struct ArtworkView_Previews: PreviewProvider {
//    static var previews: some View {
//        ArtworkView(image: )
//    }
//}
