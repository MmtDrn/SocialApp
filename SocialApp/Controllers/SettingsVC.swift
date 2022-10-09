//
//  SettingsVC.swift
//  InstaClone
//
//  Created by mehmet duran on 7.10.2022.
//

import UIKit

final class SettingsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        allConfig()
    }

}
//MARK: - Configuration
extension SettingsVC {
    
    private func allConfig() {
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out",style: .plain,
                                                            target: self,action: #selector(logoutClicked))
    }
}

//MARK: - Funcs
extension SettingsVC {
    
    @objc private func logoutClicked(){
        print("logout clicked")
    }
}
