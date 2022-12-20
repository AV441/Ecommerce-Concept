//
//  FiltersViewController.swift
//  Ecommerce Concept
//
//  Created by Андрей on 12.12.2022.
//

import UIKit
import SnapKit
import RangeSeekSlider

final class FiltersViewController: UIViewController {
    private var viewModel: FiltersViewModelProtocol
    private var filtersView: FiltersView!

    init(viewModel: FiltersViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        addTargets()
        bindViewModel()
    }
    
    private func configureView() {
        view.backgroundColor = .clear
        
        filtersView = FiltersView()
        filtersView.tableView.dataSource = self
        filtersView.tableView.delegate = self
        filtersView.priceSlider.delegate = self
        
        filtersView.brandPickerButton.setTitle(viewModel.selectedBrand, for: .normal)
        filtersView.pricePickerButton.setTitle("$\(viewModel.minPrice.formattedWithSeparator) - $\(viewModel.maxPrice.formattedWithSeparator)", for: .normal)
        
        filtersView.priceSlider.selectedMinValue = viewModel.minPrice
        filtersView.priceSlider.selectedMaxValue = viewModel.maxPrice
        
        view.addSubview(filtersView)
        
        filtersView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(375)
        }
    }
 
    private func addTargets() {
        filtersView.cancelButton.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
        filtersView.doneButton.addTarget(self, action: #selector(didTapDoneButton), for: .touchUpInside)
        filtersView.brandPickerButton.addTarget(self, action: #selector(didTapBrandPickerButton), for: .touchUpInside)
        filtersView.pricePickerButton.addTarget(self, action: #selector(didTapPricePickerButton), for: .touchUpInside)
        filtersView.confirmButton.addTarget(self, action: #selector(didTapConfirmButton), for: .touchUpInside)
    }
    
    @objc
    private func didTapCancelButton() {
        viewModel.cancelFilters()
    }
    
    @objc
    private func didTapDoneButton() {
        viewModel.applyFilters()
    }
    
    @objc
    private func didTapBrandPickerButton() {
        filtersView.tableView.isHidden = false
    }
    
    @objc
    private func didTapPricePickerButton() {
        filtersView.pricePickerView.isHidden = false
    }
    
    @objc
    private func didTapConfirmButton() {
        let title = "$\(viewModel.minPrice.formattedWithSeparator) - $\(viewModel.maxPrice.formattedWithSeparator)"
        filtersView.pricePickerButton.setTitle(title, for: .normal)
        filtersView.pricePickerView.isHidden = true
    }
    
    
    private func bindViewModel() {
        viewModel.updateBrand = { [unowned self] in
            let title = viewModel.selectedBrand
            filtersView.brandPickerButton.setTitle(title, for: .normal)
        }
    }
    
}

extension FiltersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.brands.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let brand = viewModel.brands[indexPath.row]
        if brand == viewModel.selectedBrand {
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        }
        cell.textLabel?.text = brand
        return cell
    }
    
}

extension FiltersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectBrand(forIndex: indexPath.row)
        tableView.isHidden = true
    }
    
}

extension FiltersViewController: RangeSeekSliderDelegate {
    
    func rangeSeekSlider(_ slider: RangeSeekSlider, stringForMinValue minValue: CGFloat) -> String? {
        return "$\(minValue)"
    }
    
    func rangeSeekSlider(_ slider: RangeSeekSlider, stringForMaxValue maxValue: CGFloat) -> String? {
        return "$\(maxValue)"
    }
    
    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        viewModel.setMinPrice(minValue)
        viewModel.setMaxPrice(maxValue)
    }
    
}
