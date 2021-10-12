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
    
    @IBOutlet weak var info: UILabel!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func commonInit(device: GetterDevices) {
        self.logoDevice.image = device.image
        self.title.text = device.title
        self.info.text = device.info
    }

}
