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
    @State private var isEditingComment = false
    @State private var editableComment: String = ""
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
                            Button(
                                action: {
                                    movie.isFavorite.toggle()
                                },
                                label: {
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
                            ).buttonStyle(PlainButtonStyle())
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

                if isEditingComment {
                    TextEditor(text: $editableComment)
                        .font(.body)
                        .lineSpacing(5)
                        .frame(minHeight: 100)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                        )
                        .padding(.bottom, 10)
                } else {
                    Text(movie.comment ?? "No comment")
                        .font(.body)
                        .lineSpacing(5)
                        .padding(.bottom, 10)
                }

                Spacer()
            }
            .padding()
        }
        .preferredColorScheme(.dark)
        .navigationTitle(movie.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                if isEditingComment {
                    Button("Cancel") {
                        isEditingComment = false
                        editableComment = movie.comment ?? ""
                    }
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(
                    action: {
                        if isEditingComment {
                            movie.comment = editableComment
                        } else {
                            editableComment = movie.comment ?? ""
                        }
                        isEditingComment.toggle()
                    },
                    label: {
                        if isEditingComment {
                            Text("Save")
                        } else {
                            Image(systemName: "pencil")
                        }
                    }
                )

            }
        }
        .navigationBarBackButtonHidden(isEditingComment)
        .preferredColorScheme(.dark)
        .enableInjection()
    }

    #if DEBUG
        @ObserveInjection var forceRedraw
    #endif
}

#Preview {
    MovieDetailView(movie: Movie.sampleData[0])
}
