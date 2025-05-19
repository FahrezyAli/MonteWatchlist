//
//  MovieCard.swift
//  MonteWatchlist
//
//  Created by Ali Ahmad Fahrezy on 15/05/25.
//

import CachedAsyncImage
import SwiftUI
import SwiftUINavigationTransitions

// Movie card component
struct MovieCard: View {
    let movie: Movie
    let isFavorite: Bool = true  // Replace with actual logic

    var body: some View {
        VStack {
            NavigationLink(
                destination: MovieDetailView(movie: movie)
            ) {
                CachedAsyncImage(
                    url: URL(string: movie.poster)
                ) { image in
                    ZStack(alignment: .bottomTrailing) {
                        image
                            .resizable()
                            .scaledToFit()

                        if movie.isFavorite {
                            Image(systemName: "heart.fill").foregroundColor(
                                .red
                            )
                            .padding(6)
                        }
                    }
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 150, height: 220)
                .cornerRadius(10)
                .shadow(radius: 5)
                .onTapGesture(count: 2) {
                    movie.isFavorite.toggle()
                }
            }
            .navigationTransition(
                .slide.combined(with: .fade(.in))
            )
            Text(movie.title)
                .font(.headline)
                .lineLimit(1)
        }
        .frame(width: 150, height: 260)
        .enableInjection()
    }

    #if DEBUG
        @ObserveInjection var forceRedraw
    #endif
}
