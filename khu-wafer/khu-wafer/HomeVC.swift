//
//  HomeVC.swift
//  khu-wafer
//
//  Created by 김담인 on 2023/05/30.
//

import UIKit

class HomeVC: UIViewController {
    
    // MARK: - Components
    private let headerLabel: UILabel = {
       let lb = UILabel()
        lb.text = "Khu WareHouse"
        lb.textColor = .black
        lb.font = .boldSystemFont(ofSize: 26)
        lb.textAlignment = .center
        return lb
    }()
    
    private let scannerButton: UIButton = {
       let btn = UIButton()
        btn.setTitle("Scanner", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .systemOrange
        btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
        btn.layer.cornerRadius = 15
        return btn
    }()
    
    private let controlButton: UIButton = {
       let btn = UIButton()
        btn.setTitle("Control", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .systemOrange
        btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
        btn.layer.cornerRadius = 15
        return btn
    }()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setLayout()
        setButtonAction()
    }
    
    // MARK: - Function
    private func setButtonAction() {
        scannerButton.addTarget(self, action: #selector(pushToScanncerVC), for: .touchUpInside)
        controlButton.addTarget(self, action: #selector(pushToControlVC), for: .touchUpInside)
    }
    
    @objc private func pushToScanncerVC() {
        let scannerVC = ScannerVC()
        self.navigationController?.pushViewController(scannerVC, animated: true)
    }
    
    @objc private func pushToControlVC() {
        let controlVC = ControlVC()
        self.navigationController?.pushViewController(controlVC, animated: true)
    }

}

// MARK: - Layout
extension HomeVC {
    
    private func setLayout() {
        [headerLabel,scannerButton, controlButton].forEach {
            self.view.addSubview($0)
        }
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        headerLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 135).isActive = true
        
        scannerButton.translatesAutoresizingMaskIntoConstraints = false
        scannerButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        scannerButton.topAnchor.constraint(equalTo: self.headerLabel.bottomAnchor, constant: 99).isActive = true
        scannerButton.widthAnchor.constraint(equalToConstant: 217).isActive = true
        scannerButton.heightAnchor.constraint(equalToConstant: 43).isActive = true
        
        controlButton.translatesAutoresizingMaskIntoConstraints = false
        controlButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        controlButton.topAnchor.constraint(equalTo: self.scannerButton.bottomAnchor, constant: 94).isActive = true
        controlButton.widthAnchor.constraint(equalToConstant: 217).isActive = true
        controlButton.heightAnchor.constraint(equalToConstant: 43).isActive = true

        
    }
}
