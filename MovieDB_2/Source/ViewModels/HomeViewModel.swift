//
//  HomeViewModel.swift
//  MovieDB_2
//
//  Created by Alejandro Rodríguez Cañete on 16/3/24.
//

import UIKit

protocol HomeViewModelDelegate: AnyObject {
    func didFetchMovies()
    func didFetchDetail(movieDetails: SearchMovieResponse?)
}

class HomeViewModel {
    // MARK: - Variables
    private var results: MoviesResponse? // Stores the fetched movies
    weak var delegate: HomeViewModelDelegate? // Delegate to communicate with the view controller
    private var networkLayer = NetworkLayer() // Instance of NetworkLayer for making network requests

    // MARK: - Fetch Movies
    func fetchMovies(searchText: String) {
        // Format the search text and fetch movies using NetworkLayer
        let itemName = searchText.replacingOccurrences(of: " ", with: "+")
        networkLayer.fetchData(name: itemName) { [weak self] result in
            self?.results = result // Update the results with fetched movies
            self?.delegate?.didFetchMovies() // Notify the delegate that movies have been fetched
        }
    }

    // MARK: - Fetch Detail
    func fetchDetail(for movie: Item, completion: @escaping (SearchMovieResponse?) -> Void) {
        // Fetch detailed information for a specific movie using its IMDb ID
        networkLayer.fetchDetail(imdbID: movie.imdbID) { [weak self] result in
            completion(result) // Pass the fetched movie details to the completion handler
        }
    }

    // MARK: - Number of Rows
    func numberOfRows() -> Int {
        // Return the number of movies in the results, or 0 if results is nil
        return results?.Search.count ?? 0
    }

    // MARK: - Movie at Index
    func movie(at index: Int) -> Item? {
        // Return the movie item at the specified index in the results
        return results?.Search[index]
    }
}
