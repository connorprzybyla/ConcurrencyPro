//
//  ViewController.swift
//  ConcurrencyPro
//
//  Created by Connor Przybyla on 4/27/22.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupStackView()
    }
    
    // MARK: - Private
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Concurrency in iOS"
        return label
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter number of tasks"
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 0.5
        textField.backgroundColor = .secondarySystemBackground
        return textField
    }()
    
    private let submitButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Submit"
        let button = UIButton(configuration: configuration)
        return button
    }()
    
    private func setupStackView() {
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(submitButton)
        
        submitButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc private func didTapButton(_ sender: UIButton) {
        print("Did tap submit!")
    }
}
