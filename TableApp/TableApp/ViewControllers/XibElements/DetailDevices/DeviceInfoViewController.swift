//
//  DeviceInfoViewController.swift
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
    
    private func setupAlertChangePhoto() {
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
    
    private func saveDeviceInfoChange() {
        guard let unknownUIImage = UIImage(named: "Unknown") else { return }
        guard let device = device else {
            let newDevice = AppDevice(title: modelDeviceTextField.text ?? "",
                                      info: infoDeviceTextView.text ?? "",
                                      image: deviceImageView.image ?? unknownUIImage)
            saveAction?(newDevice)
            navigationController?.popViewController(animated: true)
            return
        }
        
        device.image = deviceImageView.image ?? unknownUIImage
        device.title = modelDeviceTextField.text ?? ""
        device.info = infoDeviceTextView.text ?? ""
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func pressSaveButton() {
        saveDeviceInfoChange()
    }
    
    @objc private func pressEditButton(_ sender: UIButton) {
        setupAlertChangePhoto()
    }
    
    func configurate(forDevice: AppDevice) {
        imageName = forDevice.image
        modelText = forDevice.title
        infoText = forDevice.info
    }
    
    private func setupNavigationTitle() {
        navigationItem.title = "Device Info"
    }
    
    private func setupButtons() {
        let saveButtonItem = UIBarButtonItem(
            title: "Change photo",
            style: .plain,
            target: self,
            action: #selector(pressEditButton))
        
        let editButtonItem = UIBarButtonItem(
            title: "Save",
            style: .plain,
            target: self,
            action: #selector(pressSaveButton))
        
        let controlBtns = [saveButtonItem, editButtonItem]
        
        navigationItem.rightBarButtonItems = controlBtns
    }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate

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

// MARK: - UITextFieldDelegate

extension DeviceInfoViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        modelDeviceTextField.resignFirstResponder()
        infoDeviceTextView.resignFirstResponder()
        return true
    }
}

// MARK: - Private

private extension DeviceInfoViewController {
    private func setupView() {
        bodyDeviceInfoView.layer.cornerRadius = 15
        bodyDeviceInfoView.layer.borderColor = UIColor.lightGray.cgColor
        bodyDeviceInfoView.layer.borderWidth = 2
    }
}
