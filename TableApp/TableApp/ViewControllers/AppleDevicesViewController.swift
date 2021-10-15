//
//  ViewController.swift
//  TableApp
//
//  Created by Сергей Гнидь on 08.10.2021.
//

import UIKit

class AppleDevicesViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
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
    func toggleSection(header: ExpandableHeaderView, section: Int) {
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
                print(devices[indexPath.section].deviceArray.count)
            }
            else {
                print("Hello")
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TableViewCell

        cell.commonInit(device: devices[indexPath.section].deviceArray[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 55
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if devices[indexPath.section].expanded {
            return 60
        }
        return 0
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ExpandableHeaderView") as! ExpandableHeaderView
        header.setup(withTitle: devices[section].title, section: section, delegate: self)
        header.setupView()
        return header
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DeviceInfo()
        let device = devices[indexPath.section].deviceArray[indexPath.item]
        vc.device = device
        vc.commonInit(device: device)
        navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

