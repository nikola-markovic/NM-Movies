//
//  RatingView.swift
//  NM-Movies
//
//  Created by Nikola on 24.3.21..
//

import SwiftUI

struct RatingView: View {
    @State var voteAverage: Double = .zero
    
    var body: some View {
        HStack {
            Image(systemName: "star.fill").foregroundColor(.yellow)
            Text(String(format: "%g", voteAverage))
                .fontWeight(.bold)
                .foregroundColor(Color.yellow)
                .lineLimit(1)
        }
    }
}
