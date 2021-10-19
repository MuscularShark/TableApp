//
//  AllDevicesViewController.swift
//  TableApp
//
//  Created by Сергей Гнидь on 11.10.2021.
//

import UIKit

class AllDevicesViewController: UIViewController {
    
    @IBOutlet private weak var deviceTableView: UITableView!
    
    private var device: [AppDevice] = EditingDevice().allDevices
    
    private let heightCell: CGFloat = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        deviceTableView.reloadData()
    }
    
    private func setupCell() {
        let nibName = UINib(nibName: "DeviceTableViewCell", bundle: nil)
        deviceTableView.register(nibName, forCellReuseIdentifier: "deviceTableViewCell")
    }
}

extension AllDevicesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            device.remove(at: indexPath.row)
            deviceTableView.deleteRows(at: [indexPath], with: .automatic)
        default:
            break
        }
    }
}

extension AllDevicesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = deviceTableView.dequeueReusableCell(withIdentifier: "deviceTableViewCell", for: indexPath)
        guard let cell = tableViewCell as? DeviceTableViewCell else { return UITableViewCell()}
        cell.commonInit(device: device[indexPath.item])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return device.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let deviceInfoScreen = DeviceInfoViewController()
        let device = device[indexPath.item]
        deviceInfoScreen.device = device
        deviceInfoScreen.commonInit(device: device)
        navigationController?.pushViewController(deviceInfoScreen, animated: true)
        deviceTableView.deselectRow(at: indexPath, animated: true)
    }
}
