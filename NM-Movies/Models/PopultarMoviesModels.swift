
import Foundation

struct PopularMoviesResult: Codable {
    var page = 1
    var results = [Movie]()
    var total_pages = 1
}

struct Movie: Codable {
    var id: Int = 0
    var title: String?
    var original_title: String?
    var original_language: String?
    var overview: String
    var homepage: String?
    var release_date: String?
    var vote_average: Double?
    var vote_count: Int?
    var poster_path: String?
    
    var genres: [Genre]?
    
    var tagline: String?
    var imdb_id: String?
    var runtime: Int?
    var revenue: Int?
    var production_companies: [ProductionCompany]?
}

struct ProductionCompany: Codable {
    var id: Int?
    var logo_path: String?
    var name: String?
    var origin_country: String?
}

struct Genre: Codable {
    var id = 0
    var name = ""
}
