//
//  DevicesStorage.swift
//  TableApp
//
//  Created by Сергей Гнидь on 19.10.2021.
//

import UIKit

class DevicesStorage {
    var allDevices = [AppDevice]()
    
    init() {
        self.allDevices = AppDevice.getAllDevices()
    }
}
