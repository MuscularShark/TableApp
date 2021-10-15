//
//  SectionCell.swift
//  TableApp
//
//  Created by Сергей Гнидь on 13.10.2021.
//

import UIKit

protocol ExpandableHeaderViewDelegate {
    func toggleSection(header: ExpandableHeaderView, section: Int)
}

final class ExpandableHeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet private weak var label: UILabel!

    @IBOutlet private weak var views: UIView!
    
    private var delegate: ExpandableHeaderViewDelegate?
    private var section: Int?
    
    private var text: String?
    
    static let identifier = "ExpandableHeaderView"
    
    static func nib() -> UINib { return UINib(nibName: "ExpandableHeaderView", bundle: nil)}
    
    func setup(withTitle title: String, section: Int, delegate: ExpandableHeaderViewDelegate) {
        self.delegate = delegate
        self.section = section
        self.label.text = title
    }
    
    func setupView() {
        views.layer.cornerRadius = 20
        views.layer.borderWidth = 1.5
        views.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    @IBAction func clickBtn(_ sender: UIButton) {
        guard let section = section  else { return }
            delegate?.toggleSection(header: self, section: section)
    }
}

