import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    @State private var selectedGenre = "All"

    let allGenres: [String] = {
        var genres = ["All"]
        let movieGenres = Set(Movie.sampleData.flatMap { $0.genres })
        genres.append(contentsOf: movieGenres.sorted())
        return genres
    }()

    // Filtered movies based on search and genre selection
    var filteredMovies: [Movie] {
        var result = Movie.sampleData

        // Apply genre filter
        if selectedGenre != "All" {
            result = result.filter { $0.genres.contains(selectedGenre) }
        }

        // Apply search filter
        if !searchText.isEmpty {
            result = result.filter {
                $0.title.localizedCaseInsensitiveContains(searchText)
                    || $0.description.localizedCaseInsensitiveContains(searchText)
            }
        }
        return result
    }

    // Group filtered movies by genre
    var moviesByGenre: [String: [Movie]] {
        Dictionary(grouping: filteredMovies) { movie in
            movie.genres.first ?? "Uncategorized"
        }
    }

    var body: some View {
        NavigationStack {
            VStack {
                // Search field
                SearchBar(text: $searchText)
                    .padding(.horizontal)

                // Genre filter buttons
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(allGenres, id: \.self) { genre in
                            Button(genre) {
                                selectedGenre = genre
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(selectedGenre == genre ? Color.blue : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical, 8)

                // List of movies grouped by genre
                if filteredMovies.isEmpty {
                    ContentUnavailableView("No movies found", systemImage: "film")
                } else {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 20) {
                            ForEach(moviesByGenre.keys.sorted(), id: \.self) { genre in
                                VStack(alignment: .leading) {
                                    Text(genre)
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .padding(.horizontal)

                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack(spacing: 15) {
                                            ForEach(moviesByGenre[genre] ?? []) { movie in
                                                NavigationLink(
                                                    destination: MovieDetailView(movie: movie)
                                                ) {
                                                    AsyncImage(url: URL(string: movie.coverImage)) {
                                                        image in
                                                        image
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fill)
                                                    } placeholder: {
                                                        ProgressView()
                                                    }
                                                    .frame(width: 150, height: 220)
                                                    .cornerRadius(10)
                                                    .shadow(radius: 5)
                                                }
                                            }
                                        }
                                        .padding(.horizontal)
                                    }
                                }
                            }
                        }
                        .padding(.vertical)
                    }
                }
            }
            .navigationTitle("Movies")
        }
        .enableInjection()
    }

    #if DEBUG
    @ObserveInjection var forceRedraw
    #endif
}

// Search bar component remains the same
struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            TextField("Search movies...", text: $text)
                .padding(8)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)

                        if !text.isEmpty {
                            Button(action: {
                                text = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
        }
        .enableInjection()
    }

    #if DEBUG
    @ObserveInjection var forceRedraw
    #endif
}

#Preview {
    ContentView()
}
