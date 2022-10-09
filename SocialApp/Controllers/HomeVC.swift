//
//  File.swift
//  InstaClone
//
//  Created by mehmet duran on 7.10.2022.
//

import UIKit
import Firebase

final class HomeVC:UIViewController {
    
    let currentUser = Auth.auth().currentUser
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        if let user = currentUser {
            print(user.displayName!)
        }
    }
}

//MARK: ConfigurationWidgets
extension HomeVC {
    
}
