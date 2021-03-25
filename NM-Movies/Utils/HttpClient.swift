
import Foundation
import Combine

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol MoviesService {
    func getPopularMovies(fromPage page: Int, _ completion: @escaping (Result<PopularMoviesResult, Error>) -> ())
    
}

enum ApiEnd {
    static let baseUrl = "https://api.themoviedb.org/3/movie/"
    static let popularUrl = "\(baseUrl)popular"
    static let movieDetails = "\(baseUrl)"
    static let imagesRootUrl = "https://image.tmdb.org/t/p/w500/"
}

class HttpClient: MoviesService {
    
    private let apiKey = "80a8959d27156722b1ab1bdb6760f8bf"
    static var shared = HttpClient()
    
    private var cancable = Set<AnyCancellable>()
    
    func getPopularMovies(fromPage page: Int = 1, _ completion: @escaping (Result<PopularMoviesResult, Error>) -> ())  {
        let request = popularMoviesRequest(forPage: page)
        
        URLSession.shared.dataTaskPublisher(for: request)
            .tryCompactMap { (data, response) in
                let decoder = JSONDecoder()
                return try? decoder.decode(PopularMoviesResult.self, from: data)
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }) { (responseModel) in
                completion(.success(responseModel))
            }.store(in: &cancable)
    }
    
    private func popularMoviesRequest(forPage page: Int) -> URLRequest {
        var request = URLRequest(url: URL(string: "\(ApiEnd.popularUrl)?api_key=\(apiKey)&page=\(page)")!)
        request.httpMethod = HttpMethod.get.rawValue
        return request
    }
    
    func getMovieDetails(movieId: Int, _ completion: @escaping (Result<Movie, Error>) -> ())  {
        let request = movieDetailsRequest(forMovieId: movieId)
        
        URLSession.shared.dataTaskPublisher(for: request)
            .tryCompactMap { (data, response) in
                let decoder = JSONDecoder()
                return try? decoder.decode(Movie.self, from: data)
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }) { (responseModel) in
                completion(.success(responseModel))
            }.store(in: &cancable)
    }
    
    private func movieDetailsRequest(forMovieId id: Int) -> URLRequest {
        var request = URLRequest(url: URL(string: "\(ApiEnd.movieDetails)\(id)?api_key=\(apiKey)")!)
        request.httpMethod = HttpMethod.get.rawValue
        return request
    }

}
