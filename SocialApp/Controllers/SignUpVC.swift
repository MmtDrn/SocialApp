//
//  SignUpVC.swift
//  InstaClone
//
//  Created by mehmet duran on 9.10.2022.
//

import UIKit
import Firebase

class SignUpVC: UIViewController {
    
    private var labelTitle:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "SOCİAL APP"
        label.font = .systemFont(ofSize: 50)
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.numberOfLines = 0
        label.textAlignment = .center
        
        return label
    }()
    
    private var emailTxtField:UITextField = {
        let txtField = UITextField()
        txtField.textAlignment = .center
        txtField.placeholder = "email"
        txtField.layer.borderWidth = 1
        txtField.layer.borderColor = UIColor.systemGray.cgColor
        txtField.layer.cornerRadius = 10
        
        return txtField
    }()
    
    private var passwordTxtField:UITextField = {
        let txtField = UITextField()
        txtField.isSecureTextEntry = true
        txtField.textAlignment = .center
        txtField.placeholder = "password"
        txtField.layer.borderWidth = 1
        txtField.layer.borderColor = UIColor.systemGray.cgColor
        txtField.layer.cornerRadius = 10
        
        return txtField
    }()
    
    private var usernameTxtField:UITextField = {
        let txtField = UITextField()
        txtField.textAlignment = .center
        txtField.placeholder = "user name"
        txtField.layer.borderWidth = 1
        txtField.layer.borderColor = UIColor.systemGray.cgColor
        txtField.layer.cornerRadius = 10
        
        return txtField
    }()
    
    private var createButton:UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBackground
        button.setTitle("Create", for: .normal)
        button.setTitleColor(UIColor.label, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray.cgColor
        button.layer.cornerRadius = 10
        
        return button
    }()
    
    private var cancelButton:UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBackground
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(UIColor.label, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray.cgColor
        button.layer.cornerRadius = 10
        
        return button
    }()
    
    private var stackViewButton:UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 30
        
        return stackView
    }()
    
    private var stackViewTxtFields:UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        allConfig()
    }

}

extension SignUpVC {
    
    private func allConfig(){
        view.backgroundColor = .systemBackground
        cancelButton.addTarget(self, action: #selector(cancelClicked), for: .touchDown)
        createButton.addTarget(self, action: #selector(createClicked), for: .touchDown)
        stackviewTxtfieldsConfig()
        stackviewButtonsConfig()
        configTitleLabel()
    }
    
    private func addSubviews(){
        view.addSubview(labelTitle)
        view.addSubview(stackViewTxtFields)
        view.addSubview(stackViewButton)
    }
    
    private func configTitleLabel(){
        NSLayoutConstraint.activate([
            labelTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            labelTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            labelTitle.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
    private func stackviewTxtfieldsConfig(){
        stackViewTxtFields.addArrangedSubview(emailTxtField)
        stackViewTxtFields.addArrangedSubview(passwordTxtField)
        stackViewTxtFields.addArrangedSubview(usernameTxtField)
        
        NSLayoutConstraint.activate([
            stackViewTxtFields.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 20),
            stackViewTxtFields.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackViewTxtFields.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            stackViewTxtFields.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.25)
        ])
    }
    private func stackviewButtonsConfig(){
        stackViewButton.addArrangedSubview(createButton)
        stackViewButton.addArrangedSubview(cancelButton)
        
        NSLayoutConstraint.activate([
            stackViewButton.topAnchor.constraint(equalTo: stackViewTxtFields.bottomAnchor, constant: 30),
            stackViewButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackViewButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            stackViewButton.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.08)
        ])
    }
}

//MARK: - Funcs
extension SignUpVC {
    
    @objc private func cancelClicked(){
        goToVC(AuthVC())
    }
    
    @objc private func createClicked(){
        
        guard let email = emailTxtField.text, let password = passwordTxtField.text, let username = usernameTxtField.text else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            
            guard let self = self else { return }
            if error != nil {
                self.makeAlert(title: "Error!", message: error?.localizedDescription ?? "error")
            }else{
                
                let user = Auth.auth().currentUser?.createProfileChangeRequest()
                user?.displayName = username
                user?.commitChanges()
                self.goToVC(AuthVC())
            }
        }
        
    }
    private func makeAlert(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive))
        present(alert, animated: true)
    }
    private func goToVC(_ viewController:UIViewController) {
        let vc = viewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}
