//
//  DetailDeviceVCViewController.swift
//  TableApp
//
//  Created by Сергей Гнидь on 12.10.2021.
//

import UIKit

class DeviceInfoViewController: UIViewController {
    @IBOutlet private weak var deviceImageView: UIImageView!
    @IBOutlet private weak var modelDeviceTextField: UITextField!
    @IBOutlet private weak var infoDeviceTextView: UITextView!
    @IBOutlet private weak var bodyDeviceInfoView: UIView!
    
    private var imageName: UIImage?
    
    private var modelText: String?
    
    private var infoText: String?
    
    var device: AppDevice?
    
    private var saveAction: ((_ device: AppDevice) -> ())?

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupButtons()
        setupView()
        setupNavigationTitle()
    }
    
    private func setup() {
        guard let imageName = imageName,
              let modelText = modelText,
              let infoText = infoText,
              let imageDevice = deviceImageView,
              let modelDevice = modelDeviceTextField,
              let infoDevice = infoDeviceTextView
        else { return }
        imageDevice.image = imageName
        modelDevice.text = modelText
        infoDevice.text = infoText
    }
    
    @objc private func edit(_ sender: UIButton) {
        let changePhotoBtn = UIAlertAction(
            title: "Change photo",
            style: .default,
            handler: { _ in
                self.showImagePickerController(sourceType: .photoLibrary)
            })
        
        let chooseCameraBtn = UIAlertAction(
            title: "Choose camera",
            style: .default,
            handler: { _ in
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    self.showImagePickerController(sourceType: .camera)
                } else {
                    let okAction = UIAlertAction(
                        title: "Alright",
                        style: .default,
                        handler: nil)
                                    
                    self.showAlert(title: "", message: "Device has no camera.", action: okAction, type: .alert)
                }
            })
        let cancelBtn = UIAlertAction(
            title: "Cancel",
            style: .cancel,
            handler: nil)
        
        showAlert(title: "Alert", message: "", action: changePhotoBtn, chooseCameraBtn, cancelBtn, type: .actionSheet)
    }
    
    @objc private func save() {
        guard let device = device else {
            let newDevice = AppDevice(title: modelDeviceTextField.text ?? "",
                                      info: infoDeviceTextView.text ?? "",
                                      image: deviceImageView.image ?? UIImage(named: "Unknown")!)
            saveAction?(newDevice)
            navigationController?.popViewController(animated: true)
            return
        }
        
        device.image = deviceImageView.image ?? UIImage(named: "Unknown")!
        device.title = modelDeviceTextField.text ?? ""
        device.info = infoDeviceTextView.text ?? ""
        navigationController?.popViewController(animated: true)
    }
    
    func commonInit(device: AppDevice) {
        self.imageName = device.image
        self.modelText = device.title
        self.infoText = device.info
    }
    
    private func setupNavigationTitle() {
        navigationItem.title = "Device Info"
    }
    
    private func setupButtons() {
        let saveButtonItem = UIBarButtonItem(
            title: "Change photo",
            style: .plain,
            target: self,
            action: #selector(edit))
        
        let editButtonItem = UIBarButtonItem(
            title: "Save",
            style: .plain,
            target: self,
            action: #selector(save))
        
        let controlBtns = [saveButtonItem, editButtonItem]
        
        navigationItem.rightBarButtonItems = controlBtns
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            deviceImageView.image = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            deviceImageView.image = originalImage
        }
        dismiss(animated: true, completion: nil)
    }
}

extension DeviceInfoViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        modelDeviceTextField.resignFirstResponder()
        infoDeviceTextView.resignFirstResponder()
        return true
    }
}

private extension DeviceInfoViewController {
    private func setupView() {
        bodyDeviceInfoView.layer.cornerRadius = 15
        bodyDeviceInfoView.layer.borderColor = UIColor.lightGray.cgColor
        bodyDeviceInfoView.layer.borderWidth = 2
    }
}
