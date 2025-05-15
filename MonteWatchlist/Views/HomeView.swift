//
//  ContentView.swift
//  MonteWatchlist
//
//  Created by Ali Ahmad Fahrezy on 07/05/25.
//

import SwiftData
import SwiftUI

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.colorScheme) private var colorScheme
    @Query private var movies: [Movie]
    @State private var searchText = ""
    @State private var selectedGenre = "All"

    // Insert placeholder movies if the database is empty
    private func insertPlaceholdersIfNeeded() {
        // Only insert if database is empty
        guard movies.isEmpty else { return }

        let placeholders = Movie.sampleData

        for movie in placeholders {
            modelContext.insert(movie)
        }

        try? modelContext.save()
    }

    // List of all genres
    var allGenres: [String] {
        let movieGenres = Set(movies.flatMap { $0.genres })
        return ["All"] + movieGenres.sorted()
    }

    // Filtered movies based on search and genre selection
    var filteredMovies: [Movie] {
        var result = movies
        // Apply genre filter
        if selectedGenre != "All" {
            result = result.filter { $0.genres.contains(selectedGenre) }
        }

        // Apply search filter
        if !searchText.isEmpty {
            result = result.filter {
                $0.title.localizedCaseInsensitiveContains(searchText)
            }
        }
        return result
    }

    // Sample movie lists for different sections
    var todaysPicks: [Movie] {
        Array(movies.shuffled().prefix(10))
    }

    var forYou: [Movie] {
        Array(movies.shuffled().prefix(10))
    }

    var bestThisYear: [Movie] {
        Array(movies.shuffled().prefix(10))
        // Uncomment the following lines to filter by current year
        // let currentYear = Calendar.current.component(.year, from: Date())
        // let filtered = movies.filter { Int($0.year) == currentYear }
        // return Array(filtered.shuffled().prefix(10))
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
                            .background(
                                selectedGenre == genre
                                    ? (colorScheme == .dark
                                        ? Color.blue.opacity(0.7) : Color.blue)
                                    : (colorScheme == .dark
                                        ? Color.gray.opacity(0.4)
                                        : Color.gray.opacity(0.2))
                            )
                            .foregroundColor(
                                selectedGenre == genre
                                    ? Color.white
                                    : (colorScheme == .dark
                                        ? Color.white.opacity(0.9)
                                        : Color.primary)
                            )
                            .cornerRadius(20)
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical, 8)

                // Default view when no filters are applied
                if selectedGenre == "All" && searchText.isEmpty {
                    ScrollView {
                        LazyVStack(alignment: .leading, spacing: 20) {
                            MovieSection(
                                title: "Today's Picks",
                                movies: todaysPicks
                            )
                            MovieSection(title: "For You", movies: forYou)
                            MovieSection(
                                title: "Best This Year",
                                movies: bestThisYear
                            )
                        }
                        .padding(.vertical)
                    }

                    // Filtered view when filters are applied but no movies found
                } else if filteredMovies.isEmpty {
                    ContentUnavailableView(
                        "No movies found",
                        systemImage: "film"
                    )

                    // Filtered view when movies are found
                } else {
                    ScrollView {
                        LazyVGrid(
                            columns: [
                                GridItem(.flexible()), GridItem(.flexible())
                            ],
                            spacing: 16
                        ) {
                            ForEach(filteredMovies) { movie in
                                MovieCard(movie: movie)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Monte's Watchlist")
        }
        .preferredColorScheme(.dark)
        .enableInjection()
        .onAppear(perform: insertPlaceholdersIfNeeded)
    }

    #if DEBUG
        @ObserveInjection var forceRedraw
    #endif
}

#Preview {
    HomeView()
        .modelContainer(for: Movie.self, inMemory: true)
}
