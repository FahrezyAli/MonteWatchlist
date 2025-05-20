//
//  AddMovieView.swift
//  MonteWatchlist
//
//  Created by Ali Ahmad Fahrezy on 19/05/25.
//

import CachedAsyncImage
import SwiftData
import SwiftUI

struct AddMovieView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var movieSearchViewModel: MovieSearchViewModel
    @Query private var movies: [Movie]
    @State private var selectedMovie: SearchResultMovie?
    @State private var searchText = ""
    @State private var comment = ""
    @State private var isLoading = false
    @State private var errorMessage: String?
    @State private var showAlert = false

    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                // Base layer - Always visible content
                VStack(alignment: .leading, spacing: 16) {
                    // Search bar, visible when no movie is selected
                    if selectedMovie == nil {
                        SearchBar(
                            text: $searchText,
                            onSubmit: {
                                Task {
                                    guard !searchText.isEmpty else {
                                        errorMessage =
                                            "Please enter a movie name."
                                        showAlert = true
                                        return
                                    }
                                    movieSearchViewModel.searchText = searchText
                                    await movieSearchViewModel.searchMovies()
                                    if let error = movieSearchViewModel
                                        .errorMessage
                                    {
                                        errorMessage = error
                                        showAlert = true
                                    }
                                }
                            }
                        )
                        .frame(height: 60)
                        .padding(.horizontal)
                    }

                    // Selected movie view, visible when a movie is selected
                    if let selectedMovie = selectedMovie {
                        HStack {
                            CachedAsyncImage(
                                url: URL(string: selectedMovie.poster)
                            ) { image in
                                image.resizable()
                            } placeholder: {
                                Color.gray
                            }
                            .frame(width: 40, height: 60)
                            .cornerRadius(4)

                            Text(selectedMovie.title)
                                .font(.headline)

                            Spacer()

                            Button(
                                action: {
                                    self.selectedMovie = nil
                                    self.searchText = ""
                                },
                                label: {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.gray)
                                }
                            ).buttonStyle(PlainButtonStyle())
                        }
                        .padding(.horizontal)
                    }

                    // Comments section (always visible, fixed position)
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Comments:")
                            .font(.subheadline)
                            .foregroundColor(
                                selectedMovie == nil ? .gray : .primary
                            )

                        TextEditor(text: $comment)
                            .frame(height: 100)
                            .padding(4)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color(.secondarySystemBackground))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(
                                                selectedMovie == nil
                                                    ? Color.gray.opacity(0.3)
                                                    : Color.blue.opacity(0.5),
                                                lineWidth: 1
                                            )
                                    )
                            )
                            .disabled(selectedMovie == nil)
                            .opacity(selectedMovie == nil ? 0.7 : 1)
                    }
                    .padding(.horizontal)

                    Spacer()
                }

                // Overlay layer - Search results dropdown
                if selectedMovie == nil && !movieSearchViewModel.movies.isEmpty
                {
                    LazyVStack(spacing: 0) {
                        Spacer().frame(height: 60)
                        List(movieSearchViewModel.movies) { movie in
                            Button(
                                action: {
                                    selectedMovie = movie
                                },
                                label: {
                                    HStack {
                                        CachedAsyncImage(
                                            url: URL(string: movie.poster)
                                        ) { image in
                                            image.resizable()
                                        } placeholder: {
                                            Color.gray
                                        }
                                        .frame(width: 40, height: 60)
                                        .cornerRadius(4)

                                        Text(movie.title)
                                            .foregroundColor(.primary)
                                        Text(movie.year)
                                            .foregroundColor(.secondary)
                                    }
                                }
                            )
                        }
                        .listStyle(.plain)
                        .frame(height: 200)
                        .background(Color(.systemBackground))
                        .cornerRadius(8)
                        .shadow(radius: 4)
                        .padding(.horizontal)
                    }
                    .transition(.opacity)
                    .zIndex(1)  // Ensure it appears above other content
                }
            }
            .navigationTitle("Add Movie")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        movieSearchViewModel.reset()
                        dismiss()
                    }
                }

                if selectedMovie != nil {
                    ToolbarItem(placement: .confirmationAction) {
                        if isLoading {
                            ProgressView()
                        } else {
                            Button("Add") {
                                Task {
                                    await addMovie()
                                }
                            }
                        }
                    }
                }
            }
            .alert("Error", isPresented: $showAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(errorMessage ?? "Unknown error")
            }
        }
        .enableInjection()
    }

    #if DEBUG
        @ObserveInjection var forceRedraw
    #endif

    private func addMovie() async {
        guard let selectedMovie = selectedMovie else { return }
        isLoading = true

        // cannot add the same movie twice
        if movies.contains(where: { $0.imdbID == selectedMovie.imdbID }) {
            errorMessage = "Movie already exists in the watchlist."
            showAlert = true
            isLoading = false
            return
        }

        // Fetch detailed movie information
        do {
            let detailedMovie =
                try await OMDBServices().fetchMovieDetails(
                    imdbID: selectedMovie.imdbID
                )
            let movie = Movie(dto: detailedMovie)
            movie.comment = comment
            modelContext.insert(movie)
            dismiss()
        } catch {
            errorMessage = error.localizedDescription
            showAlert = true
        }

        isLoading = false
        movieSearchViewModel.reset()
    }
}

#Preview {
    AddMovieView()
        .environmentObject(MovieSearchViewModel())
        .modelContainer(for: Movie.self, inMemory: true)
}
