//
//  DeatilViewController.swift
//  MovieDB_2
//
//  Created by Alejandro Rodríguez Cañete on 17/3/24.
//

import UIKit

class DeatilViewController: UIViewController {

    // MARK: - Variables
    @IBOutlet weak var titleLabel: UILabel! // Label for displaying movie title
    @IBOutlet weak var posterImage: UIImageView! // Image view for displaying movie poster
    @IBOutlet weak var releasedLabel: UILabel! // Label for displaying movie release date
    @IBOutlet weak var durationLabel: UILabel! // Label for displaying movie duration
    @IBOutlet weak var genereLabel: UILabel! // Label for displaying movie genre
    @IBOutlet weak var descriptionLabel: UILabel! // Label for displaying movie description/synopsis
    @IBOutlet weak var websiteLabel: UILabel! // Label for displaying movie website
    
    var movieDetails: SearchMovieResponse? // Holds details of the movie
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    // Function to configure the view with movie details
    func configureView() {
        guard let details = movieDetails else { return }
        
        titleLabel.text = details.title
        posterImage.loadImage(from: details.poster)
        releasedLabel.text = "Released: \(determineValue(value: details.released))" // Display movie release date
        durationLabel.text = "Duration: \(determineValue(value: details.duration))" // Display movie duration
        genereLabel.text = "Genre: \(determineValue(value: details.genre))" // Display movie genre
        descriptionLabel.text = "Sypnosis: \(determineValue(value: details.plot))" // Display movie synopsis
        websiteLabel.text = "Website: \(determineValue(value: details.web))" // Display movie website
    }
    
    // Function to determine the value to be displayed, handling nil or "N/A" values
    func determineValue(value: String?) -> String {
        guard let unwrappedValue = value else { return "Unknown" }
        return unwrappedValue != "N/A" ? unwrappedValue : "Unknown"
    }
}

