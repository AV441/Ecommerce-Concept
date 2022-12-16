//
//  FiltersViewController.swift
//  Ecommerce Concept
//
//  Created by Андрей on 12.12.2022.
//

import UIKit
import SnapKit

final class FiltersViewController: UIViewController {
    
    var viewModel: FiltersViewModel!
    var filtersView: FiltersView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       configureView()
    }
    
    private func configureView() {
        view.backgroundColor = .clear
        
        filtersView = FiltersView()
        view.addSubview(filtersView)
        
        filtersView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(375)
        }
        
        filtersView.tableView.dataSource = self
        filtersView.tableView.delegate = self
        
        filtersView.cancelButton.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        filtersView.doneButton.addTarget(self, action: #selector(doneTapped), for: .touchUpInside)
    }
 
    @objc
    private func cancelTapped() {
        viewModel.coordinator.closeFilters()
    }
    
    @objc
    private func doneTapped() {
        viewModel.coordinator.closeFilters()
    }
    
}

extension FiltersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = viewModel.sections[section]
        switch section {
            
        case .brand:
            return section.rawValue
        case .price:
            return section.rawValue
        case .size:
            return section.rawValue
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let accessoryView = UIImageView(image: UIImage(named: "icDisclosure"))
        accessoryView.frame = CGRect(x: 0, y: 0, width: 16, height: 8)
        cell.accessoryView = accessoryView
        cell.layer.cornerRadius = 5
        cell.layer.borderColor = UIColor(named: "CategoryGray")?.cgColor
        cell.layer.borderWidth = 1
        cell.textLabel?.text = "Samsung"
        return cell
    }
    
    
}

extension FiltersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 27
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 37
    }
    
}
