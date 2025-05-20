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

    var body: some View {
        VStack {
            NavigationLink(
                destination: MovieDetailView(movie: movie)
            ) {
                CachedAsyncImage(
                    url: URL(string: movie.poster),
                ) { phase in
                    Group {
                        if let image = phase.image {
                            image
                                .resizable()
                                .scaledToFit()
                        } else {
                            ProgressView()  // Loading state
                        }
                    }
                    .overlay(
                        Group {
                            if movie.isFavorite {
                                Image(systemName: "heart.fill")
                                    .foregroundColor(.red)
                                    .padding(6)
                            }
                        },
                        alignment: .bottomTrailing
                    )
                }
                .frame(width: 150, height: 220)
                .background(Color.clear)
                .cornerRadius(8)
                .contentShape(Rectangle())
            }
            .navigationTransition(
                .fade(.in).animation(.easeInOut(duration: 0.3))
            )
            .buttonStyle(PlainButtonStyle())
            .highPriorityGesture(
                TapGesture(count: 2).onEnded {
                    movie.isFavorite.toggle()
                }
            )

            Text(movie.title)
                .font(.headline)
                .lineLimit(1)
        }
        .frame(width: 150, height: 260)
    }

    #if DEBUG
        @ObserveInjection var forceRedraw
    #endif
}
