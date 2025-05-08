import SwiftUI

struct Movie: Identifiable {
    let id = UUID()
    let coverImage: String  // Can be URL or local asset name
    let title: String
    let year: Int
    let genres: [String]
    let description: String
}

// Sample data
extension Movie {
    static var sampleData: [Movie] = [
        Movie(
            coverImage:
                "https://image.tmdb.org/t/p/w500/1pdfLvkbY9ohJlCjQH2CZjjYVvJ.jpg",
            title: "Interstellar",
            year: 2014,
            genres: ["Sci-Fi", "Adventure", "Drama"],
            description:
                "The adventures of a group of explorers who make use of a newly discovered wormhole to surpass the limitations on human space travel and conquer the vast distances involved in an interstellar voyage."
        ),
        Movie(
            coverImage:
                "https://image.tmdb.org/t/p/w500/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg",
            title: "The Shawshank Redemption",
            year: 1994,
            genres: ["Drama", "Crime"],
            description:
                "Framed for murder, banker Andy Dufresne is sentenced to life at Shawshank prison. But Andy isn't going to let that stop him from living."
        ),
        Movie(
            coverImage:
                "https://image.tmdb.org/t/p/w500/3h1JZGDhZ8nzxdgvkxha0qBqi05.jpg",
            title: "The Dark Knight",
            year: 2008,
            genres: ["Action", "Crime", "Drama"],
            description:
                "Batman raises the stakes in his war on crime. With the help of Lt. Jim Gordon and District Attorney Harvey Dent, Batman sets out to dismantle the remaining criminal organizations that plague the streets."
        ),
        Movie(
            coverImage:
                "https://image.tmdb.org/t/p/w500/lyQBXzOQSuE59IsHyhrp0qIiPAz.jpg",
            title: "Pulp Fiction",
            year: 1994,
            genres: ["Crime", "Drama"],
            description:
                "A burger-loving hit man, his philosophical partner, a drug-addled gangster's moll and a washed-up boxer converge in this sprawling, comedic crime caper."
        ),
    ]
}
