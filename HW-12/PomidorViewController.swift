//
//  ViewController.swift
//  HW-12
//
//  Created by Vadim Kim on 21.05.2022.
//

import UIKit

class PomidorViewController: UIViewController {

    private var isStarted = false

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

    private lazy var startPauseButton: UIButton = {
        let button = UIButton()
        var buttonConfig = UIButton.Configuration.plain()
        let imageConfig = getButtonImageConfig()
        let image = UIImage(systemName: "play", withConfiguration: imageConfig)

        buttonConfig.baseForegroundColor = .red
        buttonConfig.image = image

        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = buttonConfig

        return button
    }()

    // MARK: - Views

    private lazy var parentView: UIView = {
        let view = UIView()

        return view
    }()

    //incudes timerLabel and startPauseButton
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

        startPauseButton.addTarget(self, action: #selector(startPauseButtonAction), for: .touchUpInside)
    }

    // MARK: - Settings

    private func setupHierarchy() {
        view.addSubview(parentView)

        parentView.addSubview(timerStackView)

        timerStackView.addArrangedSubview(timerLabel)
        timerStackView.addArrangedSubview(startPauseButton)

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
        timerStackView.backgroundColor = .blue
    }

    // MARK: - @objc functions

    @objc func startPauseButtonAction(sender: UIButton) {
        changeButtonImage()
        
        isStarted.toggle()

    }

    // MARK: - Private functions

    private func getButtonImageConfig() -> UIImage.SymbolConfiguration {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 40, weight: .thin, scale: .default)

        return imageConfig
    }

    //changing button image to play/pause
    private func changeButtonImage() {
        let imageConfig = getButtonImageConfig()

        if isStarted {
            let image = UIImage(systemName: "play", withConfiguration: imageConfig)
            startPauseButton.setImage(image, for: .normal)
        } else {
            let image = UIImage(systemName: "pause", withConfiguration: imageConfig)
            startPauseButton.setImage(image, for: .normal)
        }
    }
}


