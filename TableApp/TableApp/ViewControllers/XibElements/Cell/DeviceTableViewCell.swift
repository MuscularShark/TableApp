//
//  TableViewCell.swift
//  TableApp
//
//  Created by Сергей Гнидь on 11.10.2021.
//

import UIKit

class DeviceTableViewCell: UITableViewCell {

    @IBOutlet private weak var logoDeviceImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var infoLabel: UILabel!
    
    func commonInit(device: AppDevice) {
        logoDeviceImageView.image = device.image
        titleLabel.text = device.title
        infoLabel.text = device.info
    }
}
