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
        if image != nil { //Display artwork image
            image?
                .resizable()
        } else { //Alternate placeholder
            Color(.systemBlue)
            Image(systemName: "questionmark")
                .font(.largeTitle)
                .foregroundColor(.white)
        }
    }
}
