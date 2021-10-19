//
//  SectionCell.swift
//  TableApp
//
//  Created by Сергей Гнидь on 13.10.2021.
//

import UIKit

protocol ExpandableHeaderViewDelegate: class {
    func setExpandableHeaderView(header: ExpandableHeaderView, section: Int)
}

class ExpandableHeaderView: UITableViewHeaderFooterView {
    @IBOutlet private weak var sectionNameLabel: UILabel!
    @IBOutlet private weak var bodySectionView: UIView!
    
    private weak var delegate: ExpandableHeaderViewDelegate?
    
    private var section: Int?
    
    private var text: String?
    
    static let identifier = "ExpandableHeaderView"
    
    static func nib() -> UINib { return UINib(nibName: "ExpandableHeaderView", bundle: nil) }
    
    func setup(withTitle title: String, section: Int, delegate: ExpandableHeaderViewDelegate) {
        self.delegate = delegate
        self.section = section
        self.sectionNameLabel.text = title
    }
    
    func setupView() {
        bodySectionView.layer.cornerRadius = 20
        bodySectionView.layer.borderWidth = 1.5
        bodySectionView.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    @IBAction func clickBtn(_ sender: UIButton) {
        guard let section = section else { return }
        delegate?.setExpandableHeaderView(header: self, section: section)
    }
}
