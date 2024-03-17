//
//  NetworkLayer.swift
//  MovieDB_2
//
//  Created by Alejandro Rodríguez Cañete on 15/3/24.
//

import Foundation

struct NetworkLayer {
    // Fetches a list of movies based on the search query provided.
    func fetchData(name: String, completion: @escaping (MoviesResponse) -> Void) {
        // Construct the URL for fetching movie data based on the search query
        if let urlString = "https://www.omdbapi.com/?apikey=87341a3d&s=\(name)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url = URL(string: urlString) {
            // Print the URL for debugging purposes
            print(url)
            // Initialize a URLSession data task to fetch data from the URL
            let session = URLSession.shared
            let dataTask = session.dataTask(with: url) { data, response, error in
                // Handle network errors
                if let error = error {
                    print("Network Error:", error.localizedDescription)
                    return
                }
                // Ensure that data is received
                guard let data = data else {
                    print("No data received")
                    return
                }
                do {
                    // Parse the received data into a MoviesResponse object
                    let parsingData = try JSONDecoder().decode(MoviesResponse.self, from: data)
                    // Call the completion handler with the parsed data
                    completion(parsingData)
                } catch {
                    // Handle parsing errors
                    print("Parsing Error:", error)
                }
            }
            // Resume the data task
            dataTask.resume()
        } else {
            print("Invalid URL")
        }
    }
    // Fetches detailed information about a specific movie based on its IMDb ID.
    func fetchDetail(imdbID id:String, completion: @escaping (SearchMovieResponse) -> Void) {
        // Construct the URL for fetching movie details based on the IMDb ID
        if let urlString = "https://www.omdbapi.com/?apikey=87341a3d&i=\(id)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url = URL(string: urlString) {
            // Print the URL for debugging purposes
            print(url)
            // Initialize a URLSession data task to fetch data from the URL
            let session = URLSession.shared
            let dataTask = session.dataTask(with: url) { data, response, error in
                // Handle network errors
                if let error = error {
                    print("Network Error:", error.localizedDescription)
                    return
                }
                // Ensure that data is received
                guard let data = data else {
                    print("No data received")
                    return
                }
                do {
                    // Parse the received data into a SearchMovieResponse object
                    let parsingData = try JSONDecoder().decode(SearchMovieResponse.self, from: data)
                    // Call the completion handler with the parsed data
                    completion(parsingData)
                } catch {
                    // Handle parsing errors
                    print("Parsing Error:", error)
                }
            }
            // Resume the data task
            dataTask.resume()
        } else {
            print("Invalid URL")
        }
    }
}
