//
//  LocalDevice.swift
//  TableApp
//
//  Created by Сергей Гнидь on 12.10.2021.
//

import Foundation
import UIKit

class GetterDevices {
    var title: String
    var info: String
    var image: UIImage
    
    init(title: String, info: String, image: UIImage) {
        self.title = title
        self.info = info
        self.image = image
    }
    
    static func getIphones() -> [GetterDevices] {
        let allPhones = Device.allPhones.map { device -> GetterDevices in
            let iPhones = GetterDevices(title: device.rawValue, info: "PPI: \(device.ppi ?? 0), Diagonal: \(device.diagonal)", image: UIImage(named: device.image) ?? UIImage())
            return iPhones
        }
        return allPhones
    }
    
    static func getIpads() -> [GetterDevices] {
        let allPads = Device.allPads.map { device -> GetterDevices in
            let iPads = GetterDevices(title: device.rawValue, info: "PPI: \(device.ppi ?? 0), Diagonal: \(device.diagonal)", image: UIImage(named: device.image) ?? UIImage())
            return iPads
        }
        return allPads
    }
    
    static func getAllDevices() -> [GetterDevices] {
        return getIphones() + getIpads()
    }
}

class EditingDevice {
    var allDevices = [GetterDevices]()
    
    init() {
        self.allDevices = GetterDevices.getAllDevices()
    }
}
