//
//  AllDevicesViewController.swift
//  TableApp
//
//  Created by Сергей Гнидь on 11.10.2021.
//

import UIKit

class AllDevicesViewController: UIViewController {
    
    let device = Device.allPhones + Device.allPads
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nibName = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "tableViewCell")
       
    }
}

extension AllDevicesViewController: UITableViewDelegate {
    
}

extension AllDevicesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TableViewCell
        cell.commonInit(device[indexPath.item].image, title: device[indexPath.item].rawValue, ppi: "Ppi:" + " \(device[indexPath.item].ppi!)", diagonal: "Diagonal: \(device[indexPath.item].diagonal)")
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return device.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailDeviceVC()
        vc.commonInit(device[indexPath.item].image, modelText: device[indexPath.item].rawValue, infoText: "Ppi:" + " \(device[indexPath.item].ppi!) Diagonal: \(device[indexPath.item].diagonal)")
        self.navigationController?.pushViewController(vc, animated: true)
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}
