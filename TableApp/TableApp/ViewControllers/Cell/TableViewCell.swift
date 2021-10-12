//
//  TableViewCell.swift
//  TableApp
//
//  Created by Сергей Гнидь on 11.10.2021.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var logoDevice: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var ppi: UILabel!
    
    @IBOutlet weak var diagonal: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func commonInit(_ imageName: String, title: String, ppi: String, diagonal: String) {
        self.logoDevice.image = UIImage(named: imageName)
        self.title.text = title
        self.ppi.text = ppi
        self.diagonal.text = diagonal
    }
    
}
