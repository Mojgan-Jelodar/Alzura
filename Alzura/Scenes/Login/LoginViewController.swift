//
//  LoginViewController.swift
//  Alzura
//
//  Created by Mozhgan on 11/12/22.
//

import UIKit
import Combine
final class LoginViewController: UIViewController {
    deinit {
        print("Deinit:: \(self)")
    }
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var msgLabel: UILabel!
    @IBOutlet weak var usernameTextfield: UITextField! {
        didSet {
            usernameTextfield.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        }
    }
    
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        }
    }
    
    private var viewModel : LoginViewModel!
    private var subscribers : Set<AnyCancellable> = .init()
    
    init(viewModel: LoginViewModel!) {
        self.viewModel = viewModel
        super.init(nibName: "\(LoginViewController.self)", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bind()
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        if viewModel.isValid {
            msgLabel.text = ""
            viewModel.transform(viewEvent: .login)
        } else {
            msgLabel.text = viewModel.brokenRules.joined(separator: "\n")
        }
    }
    
   @objc func textFieldDidChange(_ textfield : UITextField) {
        if textfield == usernameTextfield {
            viewModel.username = textfield.text
        } else if textfield == passwordTextField {
            viewModel.password = textfield.text
        }
    }
    private func bind() {
        viewModel.viewState.sink(receiveValue: { [weak self] viewState in
            switch viewState {
            case .failed(let error):
                self?.msgLabel.text = error.localizedDescription
            case .isLoading:
                self?.loginBtn.isAnimated = true
            case .loaded :
                self?.loginBtn.isAnimated = false
            }
        }).store(in: &subscribers)
    }
}
