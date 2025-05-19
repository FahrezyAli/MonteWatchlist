//
//  Movie.swift
//  MonteWatchlist
//
//  Created by Ali Ahmad Fahrezy on 07/05/25.
//

import SwiftData

// Movie model
// This model represents a movie with its attributes
// such as imdbID, poster, title, year, genres, plot, and comment.

@Model
final class Movie {
    @Attribute(.unique) var imdbID: String
    @Attribute var poster: String
    @Attribute var title: String
    @Attribute var year: String
    @Attribute var genres: [String]
    @Attribute var plot: String
    @Attribute var comment: String?
    @Attribute var isFavorite: Bool

    init(
        imdbID: String,
        poster: String,
        title: String,
        year: String,
        genres: [String],
        plot: String,
        comment: String? = nil,
    ) {
        self.imdbID = imdbID
        self.poster = poster
        self.title = title
        self.year = year
        self.genres = genres
        self.plot = plot
        self.comment = comment
        self.isFavorite = false
    }
}

// MovieDTO model
struct MovieDTO: Codable {
    let imdbID: String
    let poster: String
    let title: String
    let year: String
    let genres: String
    let plot: String

    enum CodingKeys: String, CodingKey {
        case imdbID = "imdbID"
        case poster = "Poster"
        case title = "Title"
        case year = "Year"
        case genres = "Genre"
        case plot = "Plot"
    }
}

// SearchResultMovie model
struct SearchResultMovie: Codable, Identifiable {
    var id: String { imdbID }
    let imdbID: String
    let title: String
    let year: String
    let poster: String
    let type: String

    enum CodingKeys: String, CodingKey {
        case imdbID = "imdbID"
        case title = "Title"
        case year = "Year"
        case poster = "Poster"
        case type = "Type"
    }
}

// SearchResultResponse model
struct SearchResultResponse: Codable {
    let search: [SearchResultMovie]
    let totalResults: String
    let response: String

    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
    }
}

// Convert MovieDTO to Movie
extension Movie {
    convenience init(dto: MovieDTO) {
        self.init(
            imdbID: dto.imdbID,
            poster: dto.poster,
            title: dto.title,
            year: dto.year,
            genres: dto.genres.components(separatedBy: ", "),
            plot: dto.plot
        )
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
            comment: "A mind-bending journey through space and time.",
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
            comment: "A timeless tale of hope and resilience."
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
            comment:
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
            comment: "A cult classic with unforgettable dialogue."
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
            comment: "A vibrant and action-packed sequel."
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
            comment: "An epic crossover event that redefined superhero movies."
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
            comment:
                "A thought-provoking sequel that explores the nature of reality."
        ),
        Movie(
            imdbID: "tt1375666",
            poster:
                "https://m.media-amazon.com/images/M/MV5BMjAxMzY3NjY4MF5BMl5BanBnXkFtZTcwODI5OTM0Mw@@._V1_SX300.jpg",
            title: "Inception",
            year: "2010",
            genres: ["Action", "Adventure", "Sci-Fi"],
            plot:
                "A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a CEO.",
            comment: "A visually stunning and mind-bending thriller."
        ),
        Movie(
            imdbID: "tt0133093",
            poster:
                "https://m.media-amazon.com/images/M/MV5BNzQzOTk3NjAtNDQxZi00ZjQ5LWFmNTEtODM1ZTAwZDJlYjYzXkEyXkFqcGc@._V1_SX300.jpg",
            title: "The Matrix",
            year: "1999",
            genres: ["Action", "Sci-Fi"],
            plot:
                "A computer hacker learns from mysterious rebels about the true nature of his reality and his role in the war against its controllers.",
            comment: "A groundbreaking sci-fi classic."
        ),
        Movie(
            imdbID: "tt0109830",
            poster:
                "https://m.media-amazon.com/images/M/MV5BNWIwODRlYzUtYjYwZi00ZTAwLTg2YjMtYjQzYjYzYjYzYjYzXkEyXkFqcGc@._V1_SX300.jpg",
            title: "Forrest Gump",
            year: "1994",
            genres: ["Drama", "Romance"],
            plot:
                "The presidencies of Kennedy and Johnson, the Vietnam War, and other history unfold through the perspective of an Alabama man with an IQ of 75.",
            comment: "A heartwarming story of an extraordinary life."
        ),
        Movie(
            imdbID: "tt0120737",
            poster:
                "https://m.media-amazon.com/images/M/MV5BN2EyZjM3NzUtYTAwZi00ZjQ5LWFmNTEtODM1ZTAwZDJlYjYzXkEyXkFqcGc@._V1_SX300.jpg",
            title: "The Lord of the Rings: The Fellowship of the Ring",
            year: "2001",
            genres: ["Action", "Adventure", "Drama"],
            plot:
                "A meek Hobbit from the Shire and eight companions set out on a journey to destroy the powerful One Ring and save Middle-earth.",
            comment: "An epic fantasy adventure."
        ),
        Movie(
            imdbID: "tt0088763",
            poster:
                "https://m.media-amazon.com/images/M/MV5BMjA3N2YwYzUtYjYwZi00ZTAwLTg2YjMtYjQzYjYzYjYzYjYzXkEyXkFqcGc@._V1_SX300.jpg",
            title: "Back to the Future",
            year: "1985",
            genres: ["Adventure", "Comedy", "Sci-Fi"],
            plot:
                "Marty McFly, a 17-year-old high school student, is accidentally sent 30 years into the past in a time-traveling DeLorean invented by his close friend, Doc Brown.",
            comment: "A fun and iconic time-travel adventure."
        )
    ]
}
