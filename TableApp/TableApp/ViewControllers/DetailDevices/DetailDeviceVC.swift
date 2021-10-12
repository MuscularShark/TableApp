//
//  DetailDeviceVCViewController.swift
//  TableApp
//
//  Created by Сергей Гнидь on 12.10.2021.
//

import UIKit

class DetailDeviceVC: UIViewController, UINavigationControllerDelegate {

    
    @IBOutlet weak var imageDevice: UIImageView!
    
    @IBOutlet weak var modelDevice: UITextField!
    
    @IBOutlet weak var infoDevice: UITextView!
    
    @IBOutlet weak var viewElements: UIView!
    
    var imageName: UIImage?
    
    var modelText: String?
    
    var infoText: String?
    
    var device: GetterDevices?
    
    var saveClosure: (( _ device: GetterDevices) -> ())?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setButtons()
        setupView()
        navigationItem.title = "Device Info"
    }

    // MARK: - Setup All in Vc
    
    func setupView() {
        viewElements.layer.cornerRadius = 15
        viewElements.layer.borderColor = UIColor.lightGray.cgColor
        viewElements.layer.borderWidth = 2
    }
    
    func setup() {
        guard let imageName = imageName, let modelText = modelText, let infoText = infoText else {
            return
        }
        guard let imageDevice = imageDevice, let modelDevice = modelDevice, let infoDevice = infoDevice else {
            return
        }
        imageDevice.image = imageName
        modelDevice.text = modelText
        infoDevice.text = infoText
    }
    
    // MARK: - EditImageAlert
    
    @objc func edit(_ sender: UIButton) {
        let actionSheet = UIAlertController(title: "Alert",
                                            message:"",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(
            title: "Change photo",
            style: .default,
            handler:{ (action) in
                    self.showImagePickerController(sourceType: .photoLibrary)}
        ))
        actionSheet.addAction(UIAlertAction(
            title: "Choose camera",
            style: .default,
            handler:{ (action) in
                if UIImagePickerController.isSourceTypeAvailable(.camera){
                    self.showImagePickerController(sourceType: .camera) }
                else {
                    let alertController = UIAlertController(
                        title: nil,
                        message: "Device has no camera.",
                        preferredStyle: .alert)
                              
                    let okAction = UIAlertAction(
                        title: "Alright",
                        style: .default,
                        handler: nil)
                                    
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }))
        actionSheet.addAction(UIAlertAction(
            title: "Cancel",
            style: .cancel,
            handler:nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    
    //MARK: - Save
    
    @objc func save() {
        guard let device = device else {
            let newDevice = GetterDevices(title: self.modelDevice.text ?? "",
                                         info: self.infoDevice.text ?? "",
                                         image: self.imageDevice.image ?? UIImage(named: "Unknown")!)
            
            self.saveClosure?(newDevice)
            self.navigationController?.popViewController(animated: true)
            return
        }
        device.image = imageDevice.image ?? UIImage(named: "Unknown")!
        device.title = modelDevice.text ?? ""
        device.info = infoDevice.text ?? ""
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Init DetailVC
    
    func commonInit(device: GetterDevices) {
        self.imageName = device.image
        self.modelText = device.title
        self.infoText = device.info
    }
    
    
    // MARK: - Buttons in navbar
    
    private func setButtons() {
        let saveButtonItem = UIBarButtonItem.init(title: "Edit",
                                                  style: .plain, target: self,
                                                  action: #selector(edit))
        
        let editButtonItem = UIBarButtonItem.init(title: "Save",
                                                  style: .plain, target: self,
                                                  action: #selector (save))
        let btns = [saveButtonItem, editButtonItem]
        
        self.navigationItem.rightBarButtonItems = btns
    }

}




extension DetailDeviceVC : UIImagePickerControllerDelegate {
    
    func showImagePickerController(sourceType: UIImagePickerController.SourceType) {
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = sourceType
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            imageDevice.image = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageDevice.image = originalImage
        }
        
        dismiss(animated: true, completion: nil)
    }
}
