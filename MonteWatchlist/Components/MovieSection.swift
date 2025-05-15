//
//  MovieSection.swift
//  MonteWatchlist
//
//  Created by Ali Ahmad Fahrezy on 15/05/25.
//

import SwiftUI

// Movie section component
struct MovieSection: View {
    let title: String
    let movies: [Movie]

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 15) {
                    ForEach(movies) { movie in
                        MovieCard(movie: movie)
                    }
                }
                .padding(.horizontal)
            }
        }
        .enableInjection()
    }

    #if DEBUG
        @ObserveInjection var forceRedraw
    #endif
}
