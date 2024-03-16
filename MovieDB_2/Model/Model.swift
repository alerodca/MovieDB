//
//  Model.swift
//  MovieDB_2
//
//  Created by Alejandro Rodríguez Cañete on 15/3/24.
//

import Foundation

struct MoviesResponse: Decodable {
    let Search: [Item]
}

struct Item: Codable {
    let title: String
    let year: String
    let imdbID: String
    let type: String
    let poster: String
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID = "imdbID"
        case type = "Type"
        case poster = "Poster"
    }
}

struct SearchMovieResponse: Decodable {
    
    let title: String
    let year: String
    let imdbID: String
    let type: String
    let poster: String
    let released: String
    let genre: String
    let duration: String
    let plot: String
    let web: String
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID = "imdbID"
        case type = "Type"
        case poster = "Poster"
        case released = "Released"
        case genre = "Genre"
        case duration = "Runtime"
        case plot = "Plot"
        case web = "Website"
    }
}
