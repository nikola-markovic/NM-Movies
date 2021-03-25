import XCTest
@testable import NM_Movies

class ApiTests: XCTestCase {

    var sut = HttpClient.shared

    func test_getPopularMovies() {
        sut.getPopularMovies { (popularMoviesResponse) in
            switch popularMoviesResponse {
            case .success(let data):
                XCTAssertFalse(data.results.isEmpty, "Popular movies result incorrect")
            case .failure(let error):
                XCTAssertFalse(error.localizedDescription.isEmpty, "Error cannot be read")
            }
        }
    }
    
    func test_getMovieDetails() {
        let testId = 300
        sut.getMovieDetails(movieId: testId) { (movieDetailsResult) in
            switch movieDetailsResult {
            case .success(let movie):
                XCTAssertTrue(movie.id == testId, "Wrong movie details gathered!")
            case .failure(let error):
                XCTAssertFalse(error.localizedDescription.isEmpty, "Error cannot be read")
            }
        }
    }
}
