//
//  TableViewCell.swift
//  MovieDB_2
//
//  Created by Alejandro Rodríguez Cañete on 16/3/24.
//

import UIKit

class TableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var imageViewCell: UIImageView! // Image view for displaying movie poster
    @IBOutlet weak var titlelLabel: UILabel! // Label for displaying movie title
    @IBOutlet weak var yearLabel: UILabel! // Label for displaying movie release year
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

