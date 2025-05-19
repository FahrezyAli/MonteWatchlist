//
//  MovieDetailView.swift
//  MonteWatchlist
//
//  Created by Ali Ahmad Fahrezy on 07/05/25.
//

import CachedAsyncImage
import SwiftUI

struct MovieDetailView: View {
    let movie: Movie

    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                ZStack {
                    // Cover image
                    CachedAsyncImage(
                        url: URL(string: movie.poster),
                        content: { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(10)
                                .shadow(radius: 5)
                        },
                        placeholder: {
                            ProgressView()
                        }
                    )
                    .frame(maxWidth: .infinity)
                    .padding(.bottom)

                    // Favorite button
                    VStack {
                        HStack {
                            Spacer()
                            Button(action: {
                                movie.isFavorite.toggle()
                            }) {
                                Image(
                                    systemName:
                                        movie.isFavorite
                                        ? "heart.fill" : "heart"
                                )
                                .font(.title)
                                .foregroundColor(
                                    movie.isFavorite ? .red : .white
                                )
                            }
                        }
                        Spacer()
                    }
                    .padding()
                }
                // Title and year
                HStack(alignment: .firstTextBaseline) {
                    Text(movie.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Spacer()

                    Text("(\(movie.year))")
                        .font(.title2)
                        .foregroundColor(.secondary)
                }

                // Genres
                HStack {
                    ForEach(movie.genres, id: \.self) { genre in
                        Text(genre)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(
                                colorScheme == .dark
                                    ? Color.blue.opacity(0.3)
                                    : Color.blue.opacity(0.1)
                            )
                            .foregroundColor(.blue)
                            .cornerRadius(20)
                    }
                }

                // Description
                Text(movie.plot)
                    .font(.body)
                    .lineSpacing(5)
            
                // Monte's Comment
                Text("Monte's Comment")
                    .font(.headline)
                    .padding(.top, 10)
            
                Text(movie.comment)
                    .font(.body)
                    .lineSpacing(5)
                    .padding(.bottom, 10)
            
                Spacer()
            }
            .padding()
        }
        .preferredColorScheme(.dark)
        .navigationTitle(movie.title)
        .navigationBarTitleDisplayMode(.inline)
        .enableInjection()
    }

    #if DEBUG
        @ObserveInjection var forceRedraw
    #endif
}

#Preview {
    MovieDetailView(movie: Movie.sampleData[0])
}
