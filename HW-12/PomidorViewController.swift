//
//  ViewController.swift
//  HW-12
//
//  Created by Vadim Kim on 21.05.2022.
//

import UIKit

class PomidorViewController: UIViewController {

    private lazy var timerLabel: UILabel = {
        var label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "timer"
        label.font = .systemFont(ofSize: Metric.timerLabelTextFont, weight: .thin)
        label.textColor = .red
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5

        return label
    }()


    // MARK: - Views

    private lazy var parentView: UIView = {
        let view = UIView()

        return view
    }()

    private lazy var timerStackView: UIStackView = {
        let stackView = UIStackView()

        stackView.axis = .vertical
        stackView.spacing = Metric.timerStackViewSpacing
        stackView.alignment = .center

        return stackView
    }()


    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupHierarchy()
        setupLayout()
        setupView()

    }

    // MARK: - Settings

    private func setupHierarchy() {
        view.addSubview(parentView)

        parentView.addSubview(timerStackView)

        timerStackView.addArrangedSubview(timerLabel)

    }

    private func setupLayout() {
        parentView.translatesAutoresizingMaskIntoConstraints = false
        parentView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        parentView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        parentView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier:  2 / 3).isActive = true
        parentView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 2 / 3).isActive = true

        timerStackView.translatesAutoresizingMaskIntoConstraints = false
        timerStackView.centerXAnchor.constraint(equalTo: parentView.centerXAnchor).isActive = true
        timerStackView.centerYAnchor.constraint(equalTo: parentView.centerYAnchor).isActive = true
        timerStackView.heightAnchor.constraint(equalTo: parentView.widthAnchor, multiplier: 2 / 3).isActive = true

    }

    private func setupView() {
        parentView.backgroundColor = .black
        timerStackView.backgroundColor = .orange
    }
}

