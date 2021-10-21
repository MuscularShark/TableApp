//
//  ExpandableHeaderView.swift
//  TableApp
//
//  Created by Сергей Гнидь on 13.10.2021.
//

import UIKit

protocol ExpandableHeaderViewDelegate: class {
    func expandableHeaderView(header: ExpandableHeaderView, section: Int)
}

class ExpandableHeaderView: UITableViewHeaderFooterView {
    @IBOutlet private weak var sectionNameLabel: UILabel!
    @IBOutlet private weak var bodySectionView: UIView!
    
    private weak var valueOfDelegate: ExpandableHeaderViewDelegate?
    
    private var numberOfSection: Int?
    
    private var text: String?
    
    static func nib() -> UINib { return UINib(nibName: ExpandableHeaderView.identifier, bundle: nil) }
    
    func setup(withTitle title: String, section: Int, delegate: ExpandableHeaderViewDelegate) {
        valueOfDelegate = delegate
        numberOfSection = section
        sectionNameLabel.text = title
    }
    
    func setupView() {
        bodySectionView.layer.cornerRadius = 20
        bodySectionView.layer.borderWidth = 1.5
        bodySectionView.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    @IBAction func clickBtn(_ sender: UIButton) {
        guard let section = numberOfSection else { return }
        valueOfDelegate?.expandableHeaderView(header: self, section: section)
    }
}
