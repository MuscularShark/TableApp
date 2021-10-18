//
//  ViewController.swift
//  TableApp
//
//  Created by Сергей Гнидь on 08.10.2021.
//

import UIKit

class AppleDevicesViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private let heightCell: CGFloat = 60
    
    private let heightForFooterInSection: CGFloat = 2
    
    private var devices = [
        DeviceSections(title: "IPhone", deviceArray: GetterDevices.getIphones(), expanded: false),
        DeviceSections(title: "IPad", deviceArray: GetterDevices.getIpads(), expanded: false)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    private func setupCell() {
        let nibName = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "tableViewCell")
        tableView.register(ExpandableHeaderView.nib(), forHeaderFooterViewReuseIdentifier: "ExpandableHeaderView")
    }
}

extension AppleDevicesViewController: ExpandableHeaderViewDelegate{
    func setExpandableHeaderView(header: ExpandableHeaderView, section: Int) {
        devices[section].expanded = !devices[section].expanded
        tableView.beginUpdates()
        for row in 0..<devices[section].deviceArray.count {
            tableView.reloadRows(at: [IndexPath(row: row, section: section)], with: .automatic)
        }
        tableView.endUpdates()
    }
}

extension AppleDevicesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            if devices[indexPath.section].deviceArray.count > 1 {
                devices[indexPath.section].deviceArray.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            else {
                devices.remove(at: indexPath.section)
                tableView.deleteSections([indexPath.section], with: .automatic)
            }
        default :
            break
        }
    }
}

extension AppleDevicesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return devices.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devices[section].deviceArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath)
        guard let cell = tableViewCell as? TableViewCell else { return UITableViewCell() }
        cell.commonInit(device: devices[indexPath.section].deviceArray[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return heightCell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if devices[indexPath.section].expanded {
            return heightCell
        }
        return 0
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return heightForFooterInSection
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let expandableHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ExpandableHeaderView")
        guard let header = expandableHeader as? ExpandableHeaderView else { return nil}
        header.setup(withTitle: devices[section].title, section: section, delegate: self)
        header.setupView()
        return header
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let deviceInfoScreen = DeviceInfoViewController()
        let device = devices[indexPath.section].deviceArray[indexPath.item]
        deviceInfoScreen.device = device
        deviceInfoScreen.commonInit(device: device)
        navigationController?.pushViewController(deviceInfoScreen, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

