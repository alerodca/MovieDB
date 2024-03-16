//
//  HomeViewModel.swift
//  MovieDB_2
//
//  Created by Alejandro Rodríguez Cañete on 16/3/24.
//

import UIKit

protocol HomeViewModelDelegate: AnyObject {
    func didFetchMovies()
}

class HomeViewModel {
    // MARK: - Variables
    private var results: MoviesResponse?
    weak var delegate: HomeViewModelDelegate?

    // MARK: - Fetch Movies
    func fetchMovies(searchText: String) {
        let itemName = searchText.replacingOccurrences(of: " ", with: "+")
        NetworkLayer().fetchData(name: itemName) { [weak self] result in
            self?.results = result
            self?.delegate?.didFetchMovies()
        }
    }

    // MARK: - Number of Rows
    func numberOfRows() -> Int {
        return results?.Search.count ?? 0
    }

    // MARK: - Movie at Index
    func movie(at index: Int) -> Item? {
        return results?.Search[index]
    }
}

