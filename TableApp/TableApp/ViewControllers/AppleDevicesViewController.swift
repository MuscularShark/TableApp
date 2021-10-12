//
//  ViewController.swift
//  TableApp
//
//  Created by Сергей Гнидь on 08.10.2021.
//

import UIKit

class AppleDevicesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let device = Device.allPhones
    var devices = [
        Devices(deviceName: "IPhone", allDevices: Device.allPhones, expanded: false),
        Devices(deviceName: "IPad", allDevices: Device.allPads, expanded: false)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Device.allPhones)
        setupCell()
    }
    
    private func setupCell() {
        let nibName = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "tableViewCell")
    }
}

extension AppleDevicesViewController: ExpandableHeaderViewDelegate, UITableViewDelegate {
    func toggleSection(header: ExpandableHeaderView, section: Int) {
        devices[section].expanded = !devices[section].expanded
        
        tableView.beginUpdates()
        for row in 0..<devices[section].allDevices.count {
            tableView.reloadRows(at: [IndexPath(row: row, section: section)], with: .automatic)
        }
        tableView.endUpdates()
    }
}

extension AppleDevicesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return devices.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devices[section].allDevices.count
    }
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//
//        cell.textLabel?.text = devices[indexPath.section].allDevices[indexPath.row].rawValue
//        return cell
//    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TableViewCell
        cell.commonInit(devices[indexPath.section].allDevices[indexPath.row].image, title: devices[indexPath.section].allDevices[indexPath.row].rawValue, ppi: "Ppi:" + " \(devices[indexPath.section].allDevices[indexPath.row].ppi!)", diagonal: "Diagonal: \(devices[indexPath.section].allDevices[indexPath.row].diagonal)")
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if devices[indexPath.section].expanded {
            return 71
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ExpandableHeaderView()
        
        header.setup(withTitle: devices[section].deviceName, section: section, delegate: self)
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailDeviceVC()
        vc.commonInit(devices[indexPath.section].allDevices[indexPath.row].image, modelText: devices[indexPath.section].allDevices[indexPath.row].rawValue, infoText: "Ppi: \(devices[indexPath.section].allDevices[indexPath.row].ppi!), " + "Diagonal: \(devices[indexPath.section].allDevices[indexPath.row].diagonal)")
        self.navigationController?.pushViewController(vc, animated: true)
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}

