//
//  PopularMoviesViewModel.swift
//  NM-Movies
//
//  Created by Nikola on 25.3.21..
//

import Foundation

class PopularMoviesViewModel: ObservableObject {
    @Published var movies = [Movie]()
    
    var currentPageNumber = 1
    var totalPages = 1
    var alertTitle = ""
    var alertDescription = ""
    @Published var showingAlert = false
    
    func loadPopularMovies(forPage page: Int = 1) {
        HttpClient.shared.getPopularMovies(fromPage: page) { (httpClientResponse) in
            switch httpClientResponse {
            case .success(let popularMovies):
                self.movies = popularMovies.results
                self.currentPageNumber = popularMovies.page
                self.totalPages = popularMovies.total_pages
            case .failure(let error):
                self.movies = [Movie]()
                self.alertTitle = "Error"
                self.alertDescription = "Fetching failed with error:\n\(error.localizedDescription)"
                self.showingAlert = true
            }
        }
    }
    
    func refresh() {
        loadPopularMovies(forPage: currentPageNumber)
    }
    
    func loadPreviousPage() {
        loadPopularMovies(forPage: currentPageNumber - 1)
    }
    
    func loadNextPage() {
        loadPopularMovies(forPage: currentPageNumber + 1)
    }
}
