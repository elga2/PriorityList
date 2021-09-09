//
//  EmptyStateView.swift
//  GA_Tech_Int
//
//  Created by George Aldridge on 07/09/2021.
//

import SwiftUI

//Screen to be displayed when no data has been retrieved
struct EmptyStateView: View {
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "clock.arrow.circlepath")
                .font(.system(size: 85))
                .padding(.bottom)
            Text("Loading data...")
                .bold()
                .font(.title)
            Spacer()
        }
        .padding()
        .foregroundColor(Color("O2Blue"))
    }
}

struct EmptyStateView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyStateView()
    }
}
