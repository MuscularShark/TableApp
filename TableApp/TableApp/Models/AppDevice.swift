//
//  LocalDevice.swift
//  TableApp
//
//  Created by Сергей Гнидь on 12.10.2021.
//

import UIKit

class AppDevice {
    var title: String
    var info: String
    var image: UIImage
    
    init(title: String, info: String, image: UIImage) {
        self.title = title
        self.info = info
        self.image = image
    }
    
    static func getIphones() -> [AppDevice] {
        let allPhones = Device.allPhones.map { device -> AppDevice in
            let iPhones = AppDevice(title: device.rawValue, info: "PPI: \(device.ppi ?? 0), Diagonal: \(device.diagonal)", image: UIImage(named: device.image) ?? UIImage())
            return iPhones
        }
        return allPhones
    }
    
    static func getIpads() -> [AppDevice] {
        let allPads = Device.allPads.map { device -> AppDevice in
            let iPads = AppDevice(title: device.rawValue, info: "PPI: \(device.ppi ?? 0), Diagonal: \(device.diagonal)", image: UIImage(named: device.image) ?? UIImage())
            return iPads
        }
        return allPads
    }
    
    static func getAllDevices() -> [AppDevice] {
        return getIphones() + getIpads()
    }
}


