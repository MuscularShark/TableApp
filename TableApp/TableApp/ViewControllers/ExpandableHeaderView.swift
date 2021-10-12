//
//  ExpandableHeaderView.swift
//  TableApp
//
//  Created by Сергей Гнидь on 11.10.2021.
//

import UIKit

protocol ExpandableHeaderViewDelegate {
    func toggleSection(header: ExpandableHeaderView, section: Int)
}

class ExpandableHeaderView: UITableViewHeaderFooterView {
    
    var delegate: ExpandableHeaderViewDelegate?
    var section: Int?
    
    func setup(withTitle title: String, section: Int, delegate: ExpandableHeaderViewDelegate) {
        self.delegate = delegate
        self.section = section
        self.textLabel?.text = title
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.backgroundColor = .lightText
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1

    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectHeaderAction)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func selectHeaderAction(gestureRecognizer: UITapGestureRecognizer) {
        let cell = gestureRecognizer.view as! ExpandableHeaderView
        delegate?.toggleSection(header: self, section: cell.section!)
    }
}
