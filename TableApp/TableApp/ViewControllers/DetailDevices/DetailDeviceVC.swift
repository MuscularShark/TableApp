//
//  DetailDeviceVCViewController.swift
//  TableApp
//
//  Created by Сергей Гнидь on 12.10.2021.
//

import UIKit

class DetailDeviceVC: UIViewController {

    @IBOutlet weak var imageDevice: UIImageView!
    
    @IBOutlet weak var modelDevice: UILabel!
    
    @IBOutlet weak var infoDevice: UITextView!
    
    var imageName: String?
    
    var modelText: String?
    
    var infoText: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    func setup() {
        guard let imageName = imageName, let modelText = modelText, let infoText = infoText else {
            return
        }
        guard let imageDevice = imageDevice, let modelDevice = modelDevice, let infoDevice = infoDevice else {
            return
        }
        imageDevice.image = UIImage(named: imageName)
        modelDevice.text = modelText
        infoDevice.text = infoText
    }

    func commonInit(_ imageName: String, modelText: String, infoText: String) {
        self.imageName = imageName
        self.modelText = modelText
        self.infoText = infoText
    }

}
