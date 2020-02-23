//
//  TableViewCell.swift
//  CitySounds
//
//  Created by Scott on 2/8/20.
//  Copyright © 2020 RiptidaL. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

//    @IBOutlet weak var eventNameCellLabel: UILabel!
//    @IBOutlet weak var eventLocationCellLabel: UILabel!
//    @IBOutlet weak var eventDateCell: UILabel!
//    @IBOutlet weak var eventPicture: UIImageView!
//    @IBOutlet weak var eventGenreCellLabel: UILabel!
//    @IBOutlet weak var eventTimeCellLabel: UILabel!
//    @IBOutlet weak var eventPriceCellLabel: UILabel!
    

    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventLocation: UILabel!
    @IBOutlet weak var eventGenre: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
