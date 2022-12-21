//
//  FiltersView.swift
//  Ecommerce Concept
//
//  Created by Андрей on 12.12.2022.
//

import UIKit
import SnapKit
import RangeSeekSlider

final class FiltersView: UIView {
    lazy var tableView = makeTableView()
    lazy var pricePickerView = makePricePickerView()
    
    lazy var priceSlider = makeSlider()
    lazy var confirmButton = makeConfirmButton()
    
    lazy var doneButton = makeDoneButton()
    lazy var cancelButton = makeCancelButton()
    lazy var titleLabel = makeLabel(withText: "Filter options")
    
    lazy var brandLabel = makeLabel(with: "Brand")
    lazy var priceLabel = makeLabel(with: "Price")
    lazy var sizeLabel = makeLabel(with: "Size")
    
    lazy var brandPickerButton = makePickerButton()
    lazy var pricePickerButton = makePickerButton()
    lazy var sizePickerButton = makePickerButton()
    
    lazy var HStack = UIStackView(arrangedSubviews: [cancelButton,
                                                     titleLabel,
                                                     doneButton],
                                  axis: .horizontal,
                                  distribution: .equalCentering)
    
    lazy var VStack = UIStackView(arrangedSubviews: [brandLabel,
                                               brandPickerButton,
                                               priceLabel,
                                               pricePickerButton,
                                               sizeLabel,
                                               sizePickerButton],
                             axis: .vertical,
                             distribution: .fillEqually)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 30
        layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        makeSubviews()
        makeConstraints()
    }
    
    private func makeSubviews() {
        addSubview(HStack)
        addSubview(VStack)
        addSubview(tableView)
        addSubview(pricePickerView)
    }
    
    private func makeConstraints() {
        HStack.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(44)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(24)
            make.height.equalTo(37)
        }
        
        pricePickerView.snp.makeConstraints { make in
            make.top.equalTo(HStack.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(30)
        }
        
        VStack.snp.makeConstraints { make in
            make.top.equalTo(HStack.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(60)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(HStack.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(30)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeDoneButton() -> UIButton {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "AccentColor")
        button.layer.cornerRadius = 10
        button.setTitle("Done", for: .normal)
        button.titleLabel?.font = UIFont(name: "MarkPro-Medium", size: 18)
        
        button.snp.makeConstraints { make in
            make.width.equalTo(86)
            make.height.equalTo(37)
        }
        return button
    }
    
    private func makeLabel(withText text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        return label
    }
    
    private func makeCancelButton() -> UIButton {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "Midnight")
        button.setImage(UIImage(named: "icCross"), for: .normal)
        button.layer.cornerRadius = 10
        
        button.snp.makeConstraints { make in
            make.width.height.equalTo(37)
        }
        return button
    }
    
    private func makeTableView() -> UITableView {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.backgroundColor = UIColor(named: "Background")
        tableView.isHidden = true
        return tableView
    }
    
    private func makeSlider() -> RangeSeekSlider {
        let slider = RangeSeekSlider()
        slider.enableStep = true
        slider.step = 50
        slider.minValue = 0
        slider.maxValue = 10000
        slider.selectedMinValue = 0
        slider.selectedMaxValue = 10000
        slider.lineHeight = 2
        slider.colorBetweenHandles = UIColor(named: "AccentColor")
        slider.handleColor = UIColor(named: "AccentColor")
        slider.tintColor = UIColor(named: "Midnight")
        return slider
    }
    
    private func makeConfirmButton() -> UIButton {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "AccentColor")
        button.setTitle("Confirm", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "MarkPro-Bold", size: 20)
        button.layer.cornerRadius = 10
        return button
    }
    
    private func makePricePickerView() -> UIView {
        let view = UIView()
        view.backgroundColor = .white
        view.isHidden = true
        
        view.addSubview(priceSlider)
        view.addSubview(confirmButton)
        
        priceSlider.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(confirmButton.snp.top).offset(30)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview().inset(30)
            make.height.equalTo(40)
        }
        
        return view
    }
    
    private func makeLabel(with title: String) -> UILabel {
        let label = UILabel()
        label.text = title
        label.font = UIFont(name: "MarkPro-Medium", size: 18)
        return label
    }
    
    private func makePickerButton() -> UIButton {
        var configuration = UIButton.Configuration.filled()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0)
        configuration.background.image = UIImage(named: "icPicker")
        configuration.background.backgroundColor = .clear
        let button = UIButton(configuration: configuration)
        button.setTitle("4.5 to 5.5 inches", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "MarkPro", size: 18)
        button.contentHorizontalAlignment = .left
        return button
    }
    
}

