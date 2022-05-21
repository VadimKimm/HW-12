//
//  ViewController.swift
//  HW-12
//
//  Created by Vadim Kim on 21.05.2022.
//

import UIKit

class PomidorViewController: UIViewController {

    //defining the timer mode
    private var isWorkTime = true

    private var isStarted = false

    //uses for pause and resume animation of circle
    private var isAnimationStarted = false

    private var timer = Timer()

    private let workTime = 25
    private let restTime = 5

    private lazy var workTimeInSeconds: Double = {
        Double(workTime.toSeconds())
    }()

    private lazy var restTimeInSeconds: Double = {
        Double(restTime.toSeconds())
    }()

    private var counter = 0.0

    private lazy var circularProgressBar: CircularProgressBarView = {
        let circularProgressBar = CircularProgressBarView(frame: .zero)

        return circularProgressBar
    }()

    private lazy var timerLabelTextForWork: String = {
        String("\(workTime < 10 ? "0\(workTime):00" : "\(workTime):00")")
    }()

    private lazy var timerLabelTextForRest: String = {
        String("\(restTime < 10 ? "0\(restTime):00" : "\(restTime):00")")
    }()

    private lazy var timerLabel: UILabel = {
        var label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = timerLabelTextForWork
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

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        circularProgressBar.center = CGPoint(x: parentView.frame.size.width / 2, y: parentView.frame.size.height / 2)

    }

    // MARK: - Settings

    private func setupHierarchy() {
        view.addSubview(parentView)

        parentView.addSubview(circularProgressBar)
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

    }

    // MARK: - @objc functions

    @objc func startPauseButtonAction(sender: UIButton) {
        changeButtonImage()

        if isStarted {
            timer.invalidate()
        } else {
            timer.invalidate()

            /*timeInterval was setted to 0.01 for more accuracy and due to the fact that when timeInterval = 1 and
             startPauseButton is pressed many times per second, the circle animation and timer can't be synchronized
            */
            timer = Timer.scheduledTimer(timeInterval: 0.01,
                                         target: self,
                                         selector: #selector(PomidorViewController.startTimer),
                                         userInfo: nil,
                                         repeats: true)
        }

        if isAnimationStarted {
            circularProgressBar.toggleAnimationState()
        } else {
            circularProgressBar.startAnimation(duration: isWorkTime ? workTimeInSeconds : restTimeInSeconds)
            isAnimationStarted.toggle()
        }

        isStarted.toggle()

    }

    @objc func startTimer() {

        if isWorkTime {
            makeCountDown(of: workTimeInSeconds)
        } else {
            makeCountDown(of: restTimeInSeconds)
        }
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

    //uses for timer's countdown
    private func makeCountDown(of time: Double) {

        counter += 0.01

        let minutes = Int(time - counter) / 60
        let seconds = Int(time - counter) % 60

        timerLabel.text = String("\(minutes < 10 ? "0\(minutes)" : "\(minutes)"):\(seconds < 10 ? "0\(seconds)" : "\(seconds)")")

        if counter >= time  {
            timer.invalidate()
            changeButtonImage()
            changeTimerMode()
        }
    }

    //trigerres when the timer ends
    private func changeTimerMode() {
        var color = UIColor()
        var cgColor = UIColor.red.cgColor

        isStarted.toggle()
        isWorkTime.toggle()
        isAnimationStarted.toggle()

        //setting up counter for the next uses
        counter = 0

        if isWorkTime {
            color = UIColor.red
            cgColor = UIColor.red.cgColor
            timerLabel.text = timerLabelTextForWork
        } else {
            color = UIColor.green
            cgColor = UIColor.green.cgColor
            timerLabel.text = timerLabelTextForRest

        }

        //changing objects color
        startPauseButton.configuration?.baseForegroundColor = color
        timerLabel.textColor = color
        circularProgressBar.changeCircularPathColor(to: cgColor)
    }
}


