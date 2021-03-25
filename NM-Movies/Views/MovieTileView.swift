//
//  MovieTileView.swift
//  NM-Movies
//
//  Created by Nikola on 24.3.21..
//

import SwiftUI

struct MovieTileView: View {
    
    var movie: Movie
    var body: some View {
        HStack(alignment: .center, spacing: 4, content: {
            ImageFromUrlView(url: movie.poster_path ?? "")
            VStack(alignment: .leading, spacing: 4, content: {
                HStack(alignment: .top) {
                    Text(movie.title ?? "")
                        .font(.body)
                        .fontWeight(.bold)
                        .lineLimit(2)
                    Spacer()
                    RatingView(voteAverage: movie.vote_average ?? .zero)
                }
                Text(movie.overview)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                Spacer()
            })
        })
        .padding(.all, 8.0)
    }
}

struct MovieTileView_Previews: PreviewProvider {
    static var previews: some View {
        MovieTileView(movie: MockData.mockArray.first!)
            .previewLayout(.fixed(width: 320, height: 100))
    }
}
