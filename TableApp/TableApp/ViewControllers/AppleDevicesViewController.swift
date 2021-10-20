//
//  AppleDevicesViewController.swift
//  TableApp
//
//  Created by Сергей Гнидь on 08.10.2021.
//

import UIKit

class AppleDevicesViewController: UIViewController {
    @IBOutlet private weak var deviceTableView: UITableView!

    private let cellHeight: CGFloat = 60

    private let sectionFooterHeight: CGFloat = 2

    private var devices = [
        DeviceSection(title: "IPhone", deviceArray: AppDevice.getIphones(), expanded: false),
        DeviceSection(title: "IPad", deviceArray: AppDevice.getIpads(), expanded: false)
    ]

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
        deviceTableView.register(ExpandableHeaderView.nib(), forHeaderFooterViewReuseIdentifier: "ExpandableHeaderView")
    }
}

// MARK: - ExpandableHeaderViewDelegate

extension AppleDevicesViewController: ExpandableHeaderViewDelegate {
    func expandableHeaderView(header: ExpandableHeaderView, section: Int) {
        devices[section].expanded = !devices[section].expanded
        deviceTableView.beginUpdates()
        for row in 0..<devices[section].deviceArray.count {
            deviceTableView.reloadRows(at: [IndexPath(row: row, section: section)], with: .automatic)
        }
        deviceTableView.endUpdates()
    }
}

// MARK: - UITableViewDelegate

extension AppleDevicesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            if devices[indexPath.section].deviceArray.count > 1 {
                devices[indexPath.section].deviceArray.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            } else {
                devices.remove(at: indexPath.section)
                tableView.deleteSections([indexPath.section], with: .automatic)
            }
        default:
            break
        }
    }
}

// MARK: - UITableViewDataSource

extension AppleDevicesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return devices.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devices[section].deviceArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "deviceTableViewCell", for: indexPath)
        guard let cell = tableViewCell as? DeviceTableViewCell else { return UITableViewCell() }
        cell.configure(forDevice: devices[indexPath.section].deviceArray[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellHeight
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return devices[indexPath.section].expanded ? cellHeight : 0
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return sectionFooterHeight
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let expandableHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ExpandableHeaderView")
        guard let header = expandableHeader as? ExpandableHeaderView else { return nil }
        header.setup(withTitle: devices[section].title, section: section, delegate: self)
        header.setupView()
        return header
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let deviceInfoScreen = DeviceInfoViewController()
        let device = devices[indexPath.section].deviceArray[indexPath.item]
        deviceInfoScreen.device = device
        deviceInfoScreen.configurate(forDevice: device)
        navigationController?.pushViewController(deviceInfoScreen, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
