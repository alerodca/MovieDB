//
//  HomeViewController.swift
//  MovieDB_2
//
//  Created by Alejandro Rodríguez Cañete on 15/3/24.
//

import UIKit

class HomeViewController: UIViewController {
    // MARK: - Variables
    var viewModel = HomeViewModel()

    // MARK: - IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register table view cell nib
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        // Assign delegates
        searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        
        // Set view model delegate
        viewModel.delegate = self
    }
    
    // Function to navigate to detail screen
    private func navigateToDetailScreen(with movieDetails: SearchMovieResponse) {
        let detailVC = DeatilViewController(nibName: "DeatilViewController", bundle: nil)
        detailVC.movieDetails = movieDetails
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - UISearchBarDelegate
extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Fetch movies only if search text length is greater than or equal to 3
        if searchText.count >= 3 {
            viewModel.fetchMovies(searchText: searchText)
        } else {
            // Reload table view if search text length is less than 3
            tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return number of rows based on fetched movies count
        guard let searchText = searchBar.text, searchText.count >= 3 else { return 0 }
        return viewModel.numberOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Configure table view cell with movie data
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell,
              let movie = viewModel.movie(at: indexPath.row) else {
            return UITableViewCell()
        }
        
        cell.titlelLabel.text = movie.title
        cell.yearLabel.text = movie.year
        cell.imageViewCell.loadImage(from: movie.poster)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Fetch movie details and navigate to detail screen on row selection
        guard let movie = viewModel.movie(at: indexPath.row) else { return }
        viewModel.fetchDetail(for: movie) { [weak self] movieDetails in
            DispatchQueue.main.async {
                if let details = movieDetails {
                    self?.navigateToDetailScreen(with: details)
                } else {
                    print("Failed to navigate to detail")
                }
            }
        }
    }
}

// MARK: - HomeViewModelDelegate
extension HomeViewController: HomeViewModelDelegate {
    func didFetchDetail(movieDetails: SearchMovieResponse?) {
        // Handle fetched movie details
        if let details = movieDetails {
            print(details)
        } else {
            print("Failed to fetch necessary data")
        }
    }
    
    func didFetchMovies() {
        // Reload table view on successful movie fetch
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
