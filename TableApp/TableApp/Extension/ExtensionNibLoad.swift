//
//  ExtensionNibLoad.swift
//  TableApp
//
//  Created by Сергей Гнидь on 20.10.2021.
//

import UIKit

extension UINib {
    class func loadNib<T: UINib>() -> T{
        let nib = UINib(nibName: String(describing: T.self), bundle: nil)
        guard let loadNib = nib as? T else { fatalError() }
        return loadNib
    }
}
