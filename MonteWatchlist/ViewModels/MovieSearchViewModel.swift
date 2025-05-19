//
//  MovieSearchViewModel.swift
//  MonteWatchlist
//
//  Created by Ali Ahmad Fahrezy on 19/05/25.
//

import Foundation

@MainActor
final class MovieSearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var movies: [SearchResultMovie] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let movieService = OMDBServices()

    func searchMovies() async {
        isLoading = true
        do {
            let movies = try await movieService.searchMovies(query: searchText)
            self.movies = movies
            self.isLoading = false
            self.errorMessage = nil
        } catch {
            self.errorMessage = error.localizedDescription
            self.isLoading = false
        }
    }

    func reset() {
        searchText = ""
        movies = []
        isLoading = false
        errorMessage = nil
    }
}
