//
//  AuthVC.swift
//  InstaClone
//
//  Created by mehmet duran on 7.10.2022.
//

import UIKit
import Firebase

final class AuthVC:UIViewController {
    
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
    
    private var signInButton:UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBackground
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(UIColor.label, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray.cgColor
        button.layer.cornerRadius = 10
        
        return button
    }()
    
    private var signUpButton:UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBackground
        button.setTitle("Sign Up", for: .normal)
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
        
        view.backgroundColor = .systemBackground
        addSubviews()
        allConfigs()
        
        signInButton.addTarget(self, action: #selector(signinClicked), for: .touchDown)
        signUpButton.addTarget(self, action: #selector(signupClicked), for: .touchDown)
    }
}

//MARK: ConfigurationWidgets
extension AuthVC {
    
    private func allConfigs() {
        configTitleLabel()
        configTxtfieldsStackview()
        configButtonsStackview()
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
    private func configTxtfieldsStackview(){
        stackViewTxtFields.addArrangedSubview(emailTxtField)
        stackViewTxtFields.addArrangedSubview(passwordTxtField)
        
        NSLayoutConstraint.activate([
            stackViewTxtFields.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 40),
            stackViewTxtFields.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackViewTxtFields.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            stackViewTxtFields.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.15)
        ])
    }
    
    private func configButtonsStackview() {
        stackViewButton.addArrangedSubview(signInButton)
        stackViewButton.addArrangedSubview(signUpButton)
        
        NSLayoutConstraint.activate([
            stackViewButton.topAnchor.constraint(equalTo: stackViewTxtFields.bottomAnchor, constant: 30),
            stackViewButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackViewButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            stackViewButton.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.08)
        ])
    }
    
    @objc private func signinClicked(){
        
        guard let email = emailTxtField.text, let password = passwordTxtField.text else {
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] resul, error in
            guard let self = self else { return }
            
            if error != nil {
                self.makeAlert(title: "Error!", message: error?.localizedDescription ?? "error")
            }else {
                let vc = TabbarController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            }
        }
    }
    
    @objc private func signupClicked(){
        
        let vc = SignUpVC()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    private func makeAlert(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive))
        present(alert, animated: true)
    }
}

