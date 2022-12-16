//
//  FiltersView.swift
//  Ecommerce Concept
//
//  Created by Андрей on 12.12.2022.
//

import UIKit
import SnapKit

final class FiltersView: UIView {
    
    lazy var tableView = makeTableView()
    lazy var doneButton = makeDoneButton()
    lazy var cancelButton = makeCancelButton()
    lazy var titleLabel = makeLabel(withText: "Filter options")
    lazy var HStack = UIStackView(arrangedSubviews: [cancelButton,
                                                     titleLabel,
                                                     doneButton],
                                  axis: .horizontal,
                                  distribution: .equalCentering)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 30
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(HStack)
        
        HStack.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(44)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(24)
            make.height.equalTo(37)
        }
        
        addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(HStack.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(46)
            make.trailing.equalToSuperview().offset(-31)
            make.bottom.equalToSuperview().offset(-44)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeDoneButton() -> UIButton {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "AccentColor")
        button.layer.cornerRadius = 10
        button.setTitle("Done", for: .normal)
        
        button.snp.makeConstraints { make in
            make.width.equalTo(86)
            make.height.equalTo(37)
        }
        return button
    }
    
    func makeLabel(withText text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        return label
    }
    
    func makeCancelButton() -> UIButton {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "Midnight")
        button.setImage(UIImage(named: "icCross"), for: .normal)
        button.layer.cornerRadius = 10
        
        button.snp.makeConstraints { make in
            make.width.height.equalTo(37)
        }
        return button
    }
    
    func makeTableView() -> UITableView {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.separatorStyle = .none
        return tableView
    }
    
}

