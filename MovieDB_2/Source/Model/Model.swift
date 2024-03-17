//
//  Model.swift
//  MovieDB_2
//
//  Created by Alejandro Rodríguez Cañete on 15/3/24.
//

import Foundation

// Struct representing the response containing an array of items retrieved from the API
struct MoviesResponse: Decodable {
    let Search: [Item]  // Array of movie items
    
    // CodingKeys to map JSON keys to struct properties
    enum CodingKeys: String, CodingKey {
        case Search
    }
}

// Struct representing a single movie item
struct Item: Codable {
    let title: String   // Title of the movie
    let year: String    // Release year of the movie
    let imdbID: String  // IMDb ID of the movie
    let type: String    // Type of the movie (e.g., movie, series)
    let poster: String  // URL of the movie poster
    
    // CodingKeys to map JSON keys to struct properties
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}

// Struct representing detailed information about a single movie
struct SearchMovieResponse: Decodable {
    let title: String       // Title of the movie
    let year: String        // Release year of the movie
    let imdbID: String      // IMDb ID of the movie
    let type: String        // Type of the movie (e.g., movie, series)
    let poster: String      // URL of the movie poster
    let released: String    // Release date of the movie
    let genre: String       // Genre(s) of the movie
    let duration: String    // Duration of the movie
    let plot: String        // Plot summary of the movie
    let web: String?        // Optional URL of the movie website
    
    // CodingKeys to map JSON keys to struct properties
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
        case released = "Released"
        case genre = "Genre"
        case duration = "Runtime"
        case plot = "Plot"
        case web = "Website"
    }
}

