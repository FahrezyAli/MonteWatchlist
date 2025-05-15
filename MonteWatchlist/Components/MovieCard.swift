//
//  MovieCard.swift
//  MonteWatchlist
//
//  Created by Ali Ahmad Fahrezy on 15/05/25.
//

import CachedAsyncImage
import SwiftUI

// Movie card component
struct MovieCard: View {
    let movie: Movie

    var body: some View {
        VStack {
            NavigationLink(
                destination: MovieDetailView(movie: movie)
            ) {
                CachedAsyncImage(
                    url: URL(string: movie.poster)
                ) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 150, height: 220)
                .cornerRadius(10)
                .shadow(radius: 5)
            }
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
