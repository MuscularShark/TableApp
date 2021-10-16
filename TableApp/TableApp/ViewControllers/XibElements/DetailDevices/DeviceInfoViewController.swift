//
//  DetailDeviceVCViewController.swift
//  TableApp
//
//  Created by Сергей Гнидь on 12.10.2021.
//

import UIKit

class DeviceInfoViewController: UIViewController {

    @IBOutlet private weak var imageDevice: UIImageView!
    
    @IBOutlet private weak var modelDevice: UITextField!
    
    @IBOutlet private weak var infoDevice: UITextView!
    
    @IBOutlet private weak var viewElements: UIView!
    
    private var imageName: UIImage?
    
    private var modelText: String?
    
    private var infoText: String?
    
    var device: GetterDevices?
    
    private var saveClosure: (( _ device: GetterDevices) -> ())?

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setButtons()
        setupView()
        navigationItem.title = "Device Info"
    }
    
    private func setup() {
        guard let imageName = imageName,
              let modelText = modelText,
              let infoText = infoText,
              let imageDevice = imageDevice,
              let modelDevice = modelDevice,
              let infoDevice = infoDevice
        else {
            return
        }
        imageDevice.image = imageName
        modelDevice.text = modelText
        infoDevice.text = infoText
    }
    
    @objc private func edit(_ sender: UIButton) {
        let changePhotoBtn = UIAlertAction(
            title: "Change photo",
            style: .default,
            handler:{ (action) in
                    self.showImagePickerController(sourceType: .photoLibrary)}
        )
        
        let chooseCameraBtn = UIAlertAction(
            title: "Choose camera",
            style: .default,
            handler:{ (action) in
                if UIImagePickerController.isSourceTypeAvailable(.camera){
                    self.showImagePickerController(sourceType: .camera) }
                else {
                    let okAction = UIAlertAction(
                        title: "Alright",
                        style: .default,
                        handler: nil)
                                    
                    self.alert(title: "", message: "Device has no camera.", action: okAction, type: .alert)
                }
            })
        let cancelBtn = UIAlertAction(
            title: "Cancel",
            style: .cancel,
            handler:nil)
        
        alert(title: "Alert", message: "", action: changePhotoBtn, chooseCameraBtn, cancelBtn, type: .actionSheet)
    }
    
    @objc private func save() {
        guard let device = device else {
            let newDevice = GetterDevices(title: self.modelDevice.text ?? "",
                                          info: self.infoDevice.text ?? "",
                                          image: self.imageDevice.image ?? UIImage(named: "Unknown")!)
            saveClosure?(newDevice)
            navigationController?.popViewController(animated: true)
            return
        }
        
        device.image = imageDevice.image ?? UIImage(named: "Unknown")!
        device.title = modelDevice.text ?? ""
        device.info = infoDevice.text ?? ""
        navigationController?.popViewController(animated: true)
    }
    
    func commonInit(device: GetterDevices) {
        self.imageName = device.image
        self.modelText = device.title
        self.infoText = device.info
    }
    
    private func setButtons() {
        let saveButtonItem = UIBarButtonItem.init(
            title: "Change photo",
            style: .plain,
            target: self,
            action: #selector(edit))
        
        let editButtonItem = UIBarButtonItem.init(
            title: "Save",
            style: .plain,
            target: self,
            action: #selector (save))
        
        let controlBtns = [saveButtonItem, editButtonItem]
        
        self.navigationItem.rightBarButtonItems = controlBtns
    }
}

extension DeviceInfoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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

extension DeviceInfoViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        modelDevice.resignFirstResponder()
        infoDevice.resignFirstResponder()
        return true
    }
}

private extension DeviceInfoViewController {
    private func setupView() {
        viewElements.layer.cornerRadius = 15
        viewElements.layer.borderColor = UIColor.lightGray.cgColor
        viewElements.layer.borderWidth = 2
    }
}
