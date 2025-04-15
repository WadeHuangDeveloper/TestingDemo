//
//  SignInViewController.swift
//  TestingDemo
//
//  Created by Huei-Der Huang on 2025/4/14.
//

import UIKit
import Combine

class SignInViewController: UIViewController {
    private var viewModel: SignInViewControllerViewModel
    private var welcomeLabel: UILabel!
    private var usernameTextField: UITextField!
    private var passwordTextField: UITextField!
    private var messageLabel: UILabel!
    private var signInButton: UIButton!
    private var mainStackView: UIStackView!
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: SignInViewControllerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupCombine()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        cancellables.removeAll()
    }
    
    private func initUI() {
        welcomeLabel = UILabel()
        welcomeLabel.text = UITextResource.welcomeText
        welcomeLabel.textAlignment = .center
        welcomeLabel.font = UIFontResource.title
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        usernameTextField = UITextField()
        usernameTextField.accessibilityIdentifier = "usernameTextField"
        usernameTextField.placeholder = UITextResource.usernamePlaceholder
        usernameTextField.borderStyle = .roundedRect
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        passwordTextField = UITextField()
        passwordTextField.accessibilityIdentifier = "passwordTextField"
        passwordTextField.placeholder = UITextResource.passwordPlaceholder
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        messageLabel = UILabel()
        messageLabel.text = "\(UITextResource.usernameTipText)\n\(UITextResource.passwordTipText)"
        messageLabel.textColor = .systemGray
        messageLabel.numberOfLines = 0
        messageLabel.font = UIFontResource.label
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        var configuration = UIButton.Configuration.filled()
        configuration.title = UITextResource.signInButtonTitle
        signInButton = UIButton(type: .system)
        signInButton.accessibilityIdentifier = "signInButton"
        signInButton.configuration = configuration
        signInButton.addTarget(self, action: #selector(onSignInButtonTapped), for: .touchUpInside)
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        
        mainStackView = UIStackView()
        mainStackView.addArrangedSubview(welcomeLabel)
        mainStackView.addArrangedSubview(usernameTextField)
        mainStackView.addArrangedSubview(passwordTextField)
        mainStackView.addArrangedSubview(messageLabel)
        mainStackView.addArrangedSubview(signInButton)
        mainStackView.axis = .vertical
        mainStackView.alignment = .fill
        mainStackView.distribution = .fill
        mainStackView.spacing = 20
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(mainStackView)
        view.backgroundColor = .systemBackground
        
        NSLayoutConstraint.activate([
            welcomeLabel.heightAnchor.constraint(equalToConstant: 100),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            signInButton.heightAnchor.constraint(equalToConstant: 50),
            
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mainStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -80),
        ])
    }
    
    @objc private func onSignInButtonTapped() {
        do {
            let username = try viewModel.validateUsername(usernameTextField.text)
            let password = try viewModel.validatePassword(passwordTextField.text)
            viewModel.signIn(username: username, password: password)
        } catch {
            let error = error as? ValidationError ?? ValidationError.invalidValue
            showAlert(message: error.errorDescription)
        }
    }
    
    @MainActor
    private func showAlert(message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
    
    private func setupCombine() {
        viewModel.event
            .receive(on: DispatchQueue.main)
            .sink { [weak self] event in
                switch event {
                case .signIn:
                    self?.showAlert(message: UITextResource.successAlert)
                }
            }
            .store(in: &cancellables)
    }
}

