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
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        searchBar.delegate = self
        tableView.dataSource = self
        viewModel.delegate = self
    }
}

// MARK: - UISearchBarDelegate
extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchText.count >= 3) {
            viewModel.fetchMovies(searchText: searchText)
        }
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell,
              let movie = viewModel.movie(at: indexPath.row) else {
            return UITableViewCell()
        }
        
        cell.titlelLabel.text = movie.title
        cell.yearLabel.text = movie.year
        cell.imageViewCell.loadImage(from: movie.poster)
        return cell
    }
}

// MARK: - HomeViewModelDelegate
extension HomeViewController: HomeViewModelDelegate {
    func didFetchMovies() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
