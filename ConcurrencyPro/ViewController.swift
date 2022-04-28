//
//  ViewController.swift
//  ConcurrencyPro
//
//  Created by Connor Przybyla on 4/27/22.
//

import UIKit

class ViewController: UIViewController {
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Enter amount of threads"
        return label
    }()
    
    private let textField = UITextField()
    
    private let submitButton: UIButton = {
        var configuration = UIButton.Configuration.gray()
        configuration.title = "Submit"
        let button = UIButton(configuration: configuration)
        return button
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupStackView()
    }
    
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
