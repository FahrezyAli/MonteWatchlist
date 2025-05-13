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

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Cover image
                CachedAsyncImage(url: URL(string: movie.poster)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(10)
                        .shadow(radius: 5)
                } placeholder: {
                    ProgressView()
                }
                .frame(maxWidth: .infinity)
                .padding(.bottom)

                // Title and year
                HStack(alignment: .firstTextBaseline) {
                    Text(movie.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)

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
                            .background(Color.blue.opacity(0.2))
                            .foregroundColor(.blue)
                            .cornerRadius(20)
                    }
                }

                // Description
                Text(movie.plot)
                    .font(.body)
                    .lineSpacing(5)

                Spacer()
            }
            .padding()
        }
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
