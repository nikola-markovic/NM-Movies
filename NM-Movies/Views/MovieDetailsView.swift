//
//  MovieDetailsView.swift
//  NM-Movies
//
//  Created by Nikola on 24.3.21..
//

import SwiftUI

struct MovieDetailsView: View {
    
    @State var movie: Movie
    
    func loadMovieData() {
        HttpClient.shared.getMovieDetails(movieId: movie.id) { (movieDetailResponse) in
            switch movieDetailResponse {
            case .success(let movieDetails):
                movie = movieDetails
            case .failure(let error):
                debugPrint("Can't fetch details for movie \(movie.id)\(error.localizedDescription)")
                break
            }
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Spacer()
                    ImageFromUrlView(url: movie.poster_path ?? "", height: UIScreen.main.bounds.height / 3)
                    Spacer()
                }
                HStack {
                    Text("\(movie.title ?? "") (\(movie.original_language ?? ""))".uppercased())
                        .font(.title2)
                        .bold()
                    Spacer()
                    VStack(alignment: .trailing) {
                        RatingView(voteAverage: movie.vote_average ?? .zero)
                        Text("\(movie.vote_count ?? 0)")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                if movie.original_title != movie.title {
                    Text("aka \(movie.original_title ?? "")")
                        .font(.title3)
                }
                Text(movie.genres?.compactMap({ $0.name }).joined(separator: ", ") ?? "")
                    .bold()
                    .foregroundColor(.blue)
                Text("Story:\n\(movie.overview)")
                    .foregroundColor(.gray)
                if movie.revenue ?? 0 > 0 {
                    Text("Revenue: \(movie.revenue ?? 0)")
                }
                ProductionCompaniesView(production_companies: movie.production_companies)
                Spacer()
            }.padding(16)
            Spacer()
        }
        .navigationBarTitle("Movie Details", displayMode: .inline)
        .onAppear(perform: {
            loadMovieData()
        })
    }
}

struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsView(movie: MockData.mockArray.first!)
    }
}
