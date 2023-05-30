//
//  ControlCVC.swift
//  khu-wafer
//
//  Created by 김담인 on 2023/05/31.
//

import UIKit

class ControlCVC: UICollectionViewCell {
    
    // MARK: - Components
    private let titleLabel: UILabel = {
       let lb = UILabel()
        lb.text = "AREA"
        lb.textColor = .white
        lb.font = .boldSystemFont(ofSize: 16)
        lb.textAlignment = .center
        return lb
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .orange
        self.layer.cornerRadius = 15
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setCellTitle(num: Int) {
        self.titleLabel.text = "AREA \(num)"
    }
    
}

extension ControlCVC {
    private func setLayout() {
        self.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
