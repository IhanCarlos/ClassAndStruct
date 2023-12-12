//
//  ViewModel.swift
//  ClassAndStruct
//
//  Created by ihan carlos on 11/12/23.
//

import Foundation

// Struct que representa uma transação bancária
struct Transaction {
    var description: String
    var amount: Double
}

// Classe que representa uma conta bancária
class BankAccount {
    var owner: String
    var balance: Double
    var transactions: [Transaction]

    init(owner: String, initialBalance: Double) {
        self.owner = owner
        self.balance = initialBalance
        self.transactions = []
    }

    func deposit(amount: Double) {
        balance += amount
        let transaction = Transaction(description: "Depósito", amount: amount)
        transactions.append(transaction)
        print("\(owner) fez um depósito de \(amount). Novo saldo: \(balance)")
    }

    func withdraw(amount: Double) {
        if amount <= balance {
            balance -= amount
            let transaction = Transaction(description: "Retirada", amount: amount)
            transactions.append(transaction)
            print("\(owner) fez uma retirada de \(amount). Novo saldo: \(balance)")
        } else {
            print("Saldo insuficiente para retirada.")
        }
    }

    func displayTransactions() {
        print("\nHistórico de Transações para \(owner):")
        for transaction in transactions {
            print("\(transaction.description): \(transaction.amount)")
        }
        print("Saldo Atual: \(balance)\n")
    }
}

// Função para interação com o usuário
func interactWithUser() {
    print("Bem-vindo ao Sistema Bancário!")
    print("Digite o nome do titular da conta:")
    
    guard let ownerName = readLine(), !ownerName.isEmpty else {
        print("Nome inválido. Encerrando o programa.")
        return
    }

    print("Digite o saldo inicial da conta:")
    guard let initialBalanceInput = readLine(),
          let initialBalance = Double(initialBalanceInput) else {
        print("Saldo inválido. Encerrando o programa.")
        return
    }

    let account = BankAccount(owner: ownerName, initialBalance: initialBalance)

    while true {
        print("\nEscolha uma opção:")
        print("1. Fazer um depósito")
        print("2. Fazer uma retirada")
        print("3. Exibir transações")
        print("4. Encerrar o programa")

        guard let choice = readLine(), let option = Int(choice) else {
            print("Escolha inválida. Tente novamente.")
            continue
        }

        switch option {
        case 1:
            print("Digite o valor do depósito:")
            guard let depositAmountInput = readLine(),
                  let depositAmount = Double(depositAmountInput) else {
                print("Valor inválido. Tente novamente.")
                continue
            }
            account.deposit(amount: depositAmount)

        case 2:
            print("Digite o valor da retirada:")
            guard let withdrawAmountInput = readLine(),
                  let withdrawAmount = Double(withdrawAmountInput) else {
                print("Valor inválido. Tente novamente.")
                continue
            }
            account.withdraw(amount: withdrawAmount)

        case 3:
            account.displayTransactions()

        case 4:
            print("Encerrando o programa. Obrigado!")
            return

        default:
            print("Escolha inválida. Tente novamente.")
        }
    }
}
