//
//  ExtensionUITableViewCell.swift
//  TableApp
//
//  Created by Сергей Гнидь on 20.10.2021.
//

import UIKit

extension UITableViewCell {
    class var identifier: String {
        return String(describing: self)
    }
}
