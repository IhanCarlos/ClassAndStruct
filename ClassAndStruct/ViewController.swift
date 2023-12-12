//
//  ViewController.swift
//  ClassAndStruct
//
//  Created by ihan carlos on 11/12/23.
//

import UIKit

class ViewController: UIViewController {
    
    var account: BankAccount?
    
    lazy var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.black.cgColor, UIColor.gray.cgColor, UIColor.white.cgColor, UIColor.green.cgColor]
        gradientLayer.locations = [0.0, 0.26, 0.66, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        return gradientLayer
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.opacity = 0.55
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 5
        view.layer.masksToBounds = true
        return view
    }()

    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Nome do Titular:"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()

    lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Digite o nome do titular"
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 6
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        return textField
    }()

    lazy var balanceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Saldo Inicial:"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()

    lazy var balanceTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Digite o saldo inicial"
        textField.keyboardType = .decimalPad
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 6
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        return textField
    }()

    lazy var startButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Iniciar", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
    }

    func setupUI() {
        view.backgroundColor = .white
        
        view.layer.addSublayer(gradientLayer)
        view.addSubview(containerView)
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        view.addSubview(balanceLabel)
        view.addSubview(balanceTextField)
        view.addSubview(startButton)
        
        gradientLayer.frame = view.bounds

        NSLayoutConstraint.activate([
            
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            containerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            containerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            
            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),

            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            nameTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),

            balanceLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            balanceLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),

            balanceTextField.topAnchor.constraint(equalTo: balanceLabel.bottomAnchor, constant: 8),
            balanceTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            balanceTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),

            startButton.topAnchor.constraint(equalTo: balanceTextField.bottomAnchor, constant: 20),
            startButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            startButton.heightAnchor.constraint(equalToConstant: 40),
            startButton.widthAnchor.constraint(equalToConstant: 150)
        ])
    }

    func setupActions() {
        startButton.addTarget(self, action: #selector(startAction), for: .touchUpInside)
    }

    @objc func startAction() {
        guard let ownerName = nameTextField.text, !ownerName.isEmpty,
              let initialBalanceText = balanceTextField.text,
              let initialBalance = Double(initialBalanceText) else {
            showAlert(message: "Digite valores válidos.")
            return
        }

        account = BankAccount(owner: ownerName, initialBalance: initialBalance)
        showAlert(message: "Conta criada com sucesso para \(ownerName) com saldo inicial de \(initialBalance).")
    }

    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alerta", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.interactWithUser()
        }))
        present(alert, animated: true, completion: nil)
    }

    func interactWithUser() {
        guard let account = account else {
            showAlert(message: "Erro: Conta não inicializada.")
            return
        }

        let alert = UIAlertController(title: "Bem-vindo ao Sistema Bancário!", message: nil, preferredStyle: .alert)

        let depositAction = UIAlertAction(title: "Fazer um depósito", style: .default) { _ in
            self.promptForAmount(title: "Depósito") { amount in
                account.deposit(amount: amount)
                self.showAlert(message: "\(account.owner) fez um depósito de \(amount). Novo saldo: \(account.balance)")
            }
        }

        let withdrawAction = UIAlertAction(title: "Fazer uma retirada", style: .default) { _ in
            self.promptForAmount(title: "Retirada") { amount in
                account.withdraw(amount: amount)
                self.showAlert(message: "\(account.owner) fez uma retirada de \(amount). Novo saldo: \(account.balance)")
            }
        }

        let displayAction = UIAlertAction(title: "Exibir transações", style: .default) { _ in
            account.displayTransactions()
            self.interactWithUser()
        }

        let closeAction = UIAlertAction(title: "Encerrar o programa", style: .destructive, handler: nil)

        alert.addAction(depositAction)
        alert.addAction(withdrawAction)
        alert.addAction(displayAction)
        alert.addAction(closeAction)

        present(alert, animated: true, completion: nil)
    }

    func promptForAmount(title: String, completion: @escaping (Double) -> Void) {
        let alert = UIAlertController(title: title, message: "Digite o valor:", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Valor"
            textField.keyboardType = .decimalPad
        }

        let confirmAction = UIAlertAction(title: "Confirmar", style: .default) { _ in
            if let amountString = alert.textFields?.first?.text,
               let amount = Double(amountString) {
                completion(amount)
            }
        }

        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)

        alert.addAction(confirmAction)
        alert.addAction(cancelAction)

        present(alert, animated: true, completion: nil)
    }
}
