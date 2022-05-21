//
//  ViewController.swift
//  HW-12
//
//  Created by Vadim Kim on 21.05.2022.
//

import UIKit

class PomidorViewController: UIViewController {
    

    // MARK: - Views

    private lazy var parentView: UIView = {
        let view = UIView()

        return view
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

    }

    private func setupLayout() {
        parentView.translatesAutoresizingMaskIntoConstraints = false
        parentView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        parentView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        parentView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier:  2 / 3).isActive = true
        parentView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 2 / 3).isActive = true

    }

    private func setupView() {
        parentView.backgroundColor = .black

    }
}

