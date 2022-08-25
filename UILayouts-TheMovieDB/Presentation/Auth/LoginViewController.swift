//
//  ViewController.swift
//  UILayouts-TheMovieDB
//
//  Created by Mwai Banda on 8/24/22.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    private var loginViewModel = LoginViewModel()
    private var disposeBag = DisposeBag()
    private lazy var header: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.attributedText = NSAttributedString(string: "TheMovieDB", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 35, weight: .heavy)])
        label.heightAnchor.constraint(equalToConstant: 55).isActive = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var vStack: UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = .systemGray5
        stack.axis = .vertical
        stack.spacing = 15
        stack.distribution = .fill
        stack.alignment = .center
        stack.layer.cornerRadius = 15
        stack.layoutMargins = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layer.shadowColor = UIColor.black.cgColor
        stack.layer.shadowOpacity = 0.25
        stack.layer.shadowOffset = .zero
        stack.layer.shadowRadius = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var emailTextfield: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.darkGray.cgColor
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 8.0
        textField.heightAnchor.constraint(equalToConstant: 55).isActive = true
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    private lazy var passwordTextfield: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.darkGray.cgColor
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 8.0
        textField.heightAnchor.constraint(equalToConstant: 55).isActive = true
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var spacer: UIView = {
            let spacer = UIView()
            spacer.isUserInteractionEnabled = false
            spacer.setContentHuggingPriority(.fittingSizeLevel, for: .vertical)
            spacer.setContentCompressionResistancePriority(.fittingSizeLevel, for: .vertical)
            spacer.translatesAutoresizingMaskIntoConstraints = false
            return spacer
    }()
    
    private lazy var loginButton: UIButton = {
            let button = UIButton()
            button.backgroundColor = .black
            button.alpha  =  0.5
            button.setTitle("Login", for: .normal)
            button.layer.cornerRadius = 8.0
            button.heightAnchor.constraint(equalToConstant: 55).isActive = true
            button.addTarget(self, action: #selector(onLoginButtonTapped), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        view.addSubview(header)
        view.addSubview(vStack)
        vStack.addArrangedSubview(emailTextfield)
        vStack.addArrangedSubview(passwordTextfield)
        vStack.addArrangedSubview(spacer)
        vStack.addArrangedSubview(loginButton)

        setupConstraints()
        setupSubscribers()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            header.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            header.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.85),
            
            vStack.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            vStack.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            vStack.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.85),
            vStack.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.3),
            
            emailTextfield.widthAnchor.constraint(equalTo: vStack.widthAnchor, multiplier: 0.9),
            passwordTextfield.widthAnchor.constraint(equalTo: vStack.widthAnchor, multiplier: 0.9),

            loginButton.widthAnchor.constraint(equalTo: vStack.widthAnchor, multiplier: 0.9)
        ])
    }
    
    func setupSubscribers() {
        emailTextfield.becomeFirstResponder()

        emailTextfield.rx.text
            .map { $0 ?? ""}
            .bind(to: loginViewModel.email)
            .disposed(by: disposeBag)
        
        passwordTextfield.rx.text
            .map { $0 ?? ""}
            .bind(to: loginViewModel.password)
            .disposed(by: disposeBag)

        loginViewModel.isValidInput
            .bind(to: loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        loginViewModel.isValidInput
            .map({ $0 ? 1.0 : 0.5 })
            .bind(to: loginButton.rx.alpha)
            .disposed(by: disposeBag)
    }
    
    @objc func onLoginButtonTapped() {
        let tabBar = UITabBarController()
        let movieListViewController = UINavigationController(rootViewController: TrendingViewController())
        movieListViewController.title = Constants.TRENDING_TITLE
        let featuredViewController = UINavigationController(rootViewController: FeaturedViewController())
        featuredViewController.title = Constants.FEATURED_TITLE

        tabBar.setViewControllers([movieListViewController, featuredViewController], animated: true)
        tabBar.modalPresentationStyle = .fullScreen
        self.present(tabBar, animated: true)
    }
}

