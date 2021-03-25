
import SwiftUI

struct PopularMoviesView: View {
    @State var moviesToShow: [Movie]
    @State var showingAlert = false
    @State var alertTitle = ""
    @State var alertDescription = ""
    @State var currentPageNumber = 1
    @State var totalPages = 1
    
    func loadPopularMovies(forPage page: Int = 1) {
        HttpClient.shared.getPopularMovies(fromPage: page) { (httpClientResponse) in
            switch httpClientResponse {
            case .success(let popularMovies):
                moviesToShow = popularMovies.results
                currentPageNumber = popularMovies.page
                totalPages = popularMovies.total_pages
            case .failure(let error):
                moviesToShow = [Movie]()
                alertTitle = "Error"
                alertDescription = "Fetching failed with error:\n\(error.localizedDescription)"
                showingAlert = true
            }
        }
    }
    
    var body: some View {
        NavigationView {
            List(moviesToShow, id:\.id) { movie in
                NavigationLink(destination: MovieDetailsView(movie: movie)) {
                    MovieTileView(movie: movie)
                }
            }
            .listStyle(PlainListStyle())
            .navigationBarItems(leading: Button(action: {
                alertTitle = "Popular movies"
                alertDescription = "By Nikola Marković"
                showingAlert = true
            }) {
                Image(systemName: "info.circle.fill")
                    .foregroundColor(.blue)
            }, trailing: Button(action: {
                loadPopularMovies()
            }) {
                Image(systemName: "arrow.clockwise.circle.fill")
                    .foregroundColor(.blue)
            })
            .navigationBarTitle("Popular movies", displayMode: .automatic)
            .onAppear(perform: {
                loadPopularMovies(forPage: currentPageNumber)
            })
            .alert(isPresented: $showingAlert) {
                Alert(title: Text(alertTitle), message: Text(alertDescription), dismissButton: .default(Text("OK")))
            }
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar, content: {
                    Button(action: {
                        loadPopularMovies(forPage: currentPageNumber - 1)
                    }) {
                        Image(systemName: "arrow.backward.circle.fill")
                    }.disabled(currentPageNumber <= 1)
                    Spacer()
                    Text("Page \(currentPageNumber) of \(totalPages)")
                    Spacer()
                    Button(action: {
                        loadPopularMovies(forPage: currentPageNumber + 1)
                    }) {
                        Image(systemName: "arrow.forward.circle.fill")
                    }.disabled(currentPageNumber == totalPages)
                })
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PopularMoviesView(moviesToShow: MockData.mockArray)
    }
}
