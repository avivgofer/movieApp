//
//  movieTableViewCell.swift
//  movieApp
//
//  Created by    aviv gofer on 04/01/2019.
//  Copyright © 2019 aviv gofer. All rights reserved.
//

import UIKit

class movieTableViewCell: UITableViewCell {
    
   
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var movieCategory: UILabel!
    @IBOutlet weak var movieName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
