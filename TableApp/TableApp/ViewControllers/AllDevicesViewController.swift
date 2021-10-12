//
//  AllDevicesViewController.swift
//  TableApp
//
//  Created by Сергей Гнидь on 11.10.2021.
//

import UIKit

class AllDevicesViewController: UIViewController {
    
    private var device: [GetterDevices] = EditingDevice().allDevices
    
    private let heightCell: CGFloat = 70
    
    @IBOutlet weak private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nibName = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "tableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
}

extension AllDevicesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            device.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            print(indexPath.row)
        default :
            break
        }
    }
}

extension AllDevicesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as? TableViewCell
        if let cell = cell {
            cell.commonInit(device: device[indexPath.item])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return device.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DeviceInfo()
        let device = device[indexPath.item]
        vc.device = device
        vc.commonInit(device: device)
        navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
