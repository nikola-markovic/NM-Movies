
import SwiftUI

struct PopularMoviesView: View {
    @ObservedObject var model = PopularMoviesViewModel()
    
    var body: some View {
        NavigationView {
            List(model.movies, id:\.id) { movie in
                NavigationLink(destination: MovieDetailsView(movie: movie)) {
                    MovieTileView(movie: movie)
                }
            }
            .listStyle(PlainListStyle())
            .navigationBarItems(leading: Button(action: {
                model.alertTitle = "Popular movies"
                model.alertDescription = "By Nikola Marković"
                model.showingAlert = true
            }) {
                Image(systemName: "info.circle.fill")
                    .foregroundColor(.blue)
            }, trailing: Button(action: {
                model.refresh()
            }) {
                Image(systemName: "arrow.clockwise.circle.fill")
                    .foregroundColor(.blue)
            })
            .navigationBarTitle("Popular movies", displayMode: .automatic)
            .onAppear(perform: {
                model.refresh()
            })
            .alert(isPresented: $model.showingAlert) {
                Alert(title: Text(model.alertTitle), message: Text(model.alertDescription), dismissButton: .default(Text("OK")))
            }
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar, content: {
                    Button(action: {
                        model.loadPreviousPage()
                    }) {
                        Image(systemName: "arrow.backward.circle.fill")
                    }.disabled(model.currentPageNumber <= 1)
                    Spacer()
                    Text("Page \(model.currentPageNumber) of \(model.totalPages)")
                    Spacer()
                    Button(action: {
                        model.loadNextPage()
                    }) {
                        Image(systemName: "arrow.forward.circle.fill")
                    }.disabled(model.currentPageNumber == model.totalPages)
                })
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PopularMoviesView()
    }
}
