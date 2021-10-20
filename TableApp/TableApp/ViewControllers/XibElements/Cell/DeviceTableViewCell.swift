//
//  DeviceTableViewCell.swift
//  TableApp
//
//  Created by Сергей Гнидь on 11.10.2021.
//

import UIKit

class DeviceTableViewCell: UITableViewCell {
    @IBOutlet private weak var logoDeviceImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var infoLabel: UILabel!
    
    func configure(forDevice: AppDevice) {
        logoDeviceImageView.image = forDevice.image
        titleLabel.text = forDevice.title
        infoLabel.text = forDevice.info
    }
}
