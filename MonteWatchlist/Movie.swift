//
//  Movie.swift
//  MonteWatchlist
//
//  Created by Ali Ahmad Fahrezy on 07/05/25.
//

import SwiftData

// Movie model
// This model represents a movie with its attributes
// such as imdbID, poster, title, year, genres, plot, and comments.

@Model
final class Movie {
    @Attribute var imdbID: String
    @Attribute var poster: String
    @Attribute var title: String
    @Attribute var year: String
    @Attribute var genres: [String]
    @Attribute var plot: String
    @Attribute var comments: String

    init(
        imdbID: String,
        poster: String,
        title: String,
        year: String,
        genres: [String],
        plot: String,
        comments: String
    ) {
        self.imdbID = imdbID
        self.poster = poster
        self.title = title
        self.year = year
        self.genres = genres
        self.plot = plot
        self.comments = comments
    }
}

// Sample data
extension Movie {
    static var sampleData: [Movie] = [
        Movie(
            imdbID: "tt0816692",
            poster:
                "https://m.media-amazon.com/images/M/MV5BYzdjMDAxZGItMjI2My00ODA1LTlkNzItOWFjMDU5ZDJlYWY3XkEyXkFqcGc@._V1_SX300.jpg",

            title: "Interstellar",
            year: "2014",
            genres: ["Adventure", "Drama", "Sci-Fi"],
            plot:
                "When Earth becomes uninhabitable in the future, a farmer and ex-NASA pilot, Joseph Cooper, is tasked to pilot a spacecraft, along with a team of researchers, to find a new planet for humans.",
            comments: "A mind-bending journey through space and time."
        ),
        Movie(
            imdbID: "tt0111161",
            poster:
                "https://m.media-amazon.com/images/M/MV5BMDAyY2FhYjctNDc5OS00MDNlLThiMGUtY2UxYWVkNGY2ZjljXkEyXkFqcGc@._V1_SX300.jpg",
            title: "The Shawshank Redemption",
            year: "1994",
            genres: ["Drama"],
            plot:
                "A banker convicted of uxoricide forms a friendship over a quarter century with a hardened convict, while maintaining his innocence and trying to remain hopeful through simple compassion.",
            comments: "A timeless tale of hope and resilience."
        ),
        Movie(
            imdbID: "tt0468569",
            poster:
                "https://m.media-amazon.com/images/M/MV5BMTMxNTMwODM0NF5BMl5BanBnXkFtZTcwODAyMTk2Mw@@._V1_SX300.jpg",
            title: "The Dark Knight",
            year: "2008",
            genres: ["Action", "Crime", "Drama"],
            plot:
                "When a menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman, James Gordon and Harvey Dent must work together to put an end to the madness.",
            comments:
                "An epic conclusion to Christopher Nolan's Batman trilogy."
        ),
        Movie(
            imdbID: "tt0110912",
            poster:
                "https://m.media-amazon.com/images/M/MV5BYTViYTE3ZGQtNDBlMC00ZTAyLTkyODMtZGRiZDg0MjA2YThkXkEyXkFqcGc@._V1_SX300.jpg",
            title: "Pulp Fiction",
            year: "1994",
            genres: ["Crime", "Drama"],
            plot:
                "The lives of two mob hitmen, a boxer, a gangster and his wife, and a pair of diner bandits intertwine in four tales of violence and redemption.",
            comments: "A cult classic with unforgettable dialogue."
        ),
        Movie(
            imdbID: "tt7126948",
            poster:
                "https://m.media-amazon.com/images/M/MV5BYTdkYjI0M2ItMmUxZi00YjU1LTgwM2ItODgxNDY0ODZhZDQzXkEyXkFqcGc@._V1_SX300.jpg",
            title: "Wonder Woman 1984",
            year: "2020",
            genres: ["Action", "Adventure", "Fantasy"],
            plot:
                "Wonder Woman finds herself battling two opponents, Maxwell Lord, a shrewd entrepreneur, and Barbara Minerva, a friend-turned-foe. Meanwhile, she also ends up crossing paths with her love interest.",
            comments: "A vibrant and action-packed sequel."
        ),
        Movie(
            imdbID: "tt4154756",
            poster:
                "https://m.media-amazon.com/images/M/MV5BMjMxNjY2MDU1OV5BMl5BanBnXkFtZTgwNzY1MTUwNTM@._V1_SX300.jpg",
            title: "Avengers: Infinity War",
            year: "2018",
            genres: ["Action", "Adventure", "Sci-Fi"],
            plot:
                "The Avengers and their allies must be willing to sacrifice all in an attempt to defeat the powerful Thanos before his blitz of devastation and ruin puts an end to the universe.",
            comments: "An epic crossover event that redefined superhero movies."
        ),
        Movie(
            imdbID: "tt10838180",
            poster:
                "https://m.media-amazon.com/images/M/MV5BMDMyNDIzYzMtZTMyMy00NjUyLWI3Y2MtYzYzOGE1NzQ1MTBiXkEyXkFqcGc@._V1_SX300.jpg",
            title: "The Matrix Resurrections",
            year: "2021",
            genres: ["Action", "Sci-Fi"],
            plot:
                "Return to a world of two realities: one, everyday life; the other, what lies behind it. To find out if his reality is a construct, to truly know himself, Mr. Anderson will have to choose to follow the white rabbit once more.",
            comments:
                "A thought-provoking sequel that explores the nature of reality."
        ),
    ]
}
