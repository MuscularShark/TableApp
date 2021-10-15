//
//  TableViewCell.swift
//  TableApp
//
//  Created by Сергей Гнидь on 11.10.2021.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet private weak var logoDevice: UIImageView!
    
    @IBOutlet private weak var title: UILabel!
    
    @IBOutlet private weak var info: UILabel!
    
    func commonInit(device: GetterDevices) {
        logoDevice.image = device.image
        title.text = device.title
        info.text = device.info
    }
}
