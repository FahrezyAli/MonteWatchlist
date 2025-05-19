//
//  MovieServices.swift
//  MonteWatchlist
//
//  Created by Ali Ahmad Fahrezy on 19/05/25.
//

import Foundation

final class OMDBServices {
    private let apiKey =
        Bundle.main.infoDictionary?["OMDB_API_KEY"] as? String ?? ""

    func fetchMovieDetails(imdbID: String) async throws -> MovieDTO {
        guard
            let url = URL(
                string: "https://www.omdbapi.com/?i=\(imdbID)&apikey=\(apiKey)"
            )
        else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        let movieDTO = try decoder.decode(MovieDTO.self, from: data)

        return movieDTO
    }

    func searchMovies(query: String) async throws -> [SearchResultMovie] {
        guard
            let url = URL(
                string:
                    "https://www.omdbapi.com/?s=\(query)&apikey=\(apiKey)&type=movie"
            )
        else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        let searchResult = try decoder.decode(
            SearchResultResponse.self,
            from: data
        )

        return searchResult.search
    }
}
