//
//  CircularProgressBarView.swift
//  HW-12
//
//  Created by Vadim Kim on 21.05.2022.
//

import UIKit

class CircularProgressBarView: UIView {

    // MARK: - Properties

    private let circleLayer = CAShapeLayer()
    private let progressLayer = CAShapeLayer()
    private let startPoint = CGFloat(-Double.pi / 2)
    private let endPoint = CGFloat(3 * Double.pi / 2)
    private let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")

    //uses for pause and resume animation of circle
    private var isAnimationPaused = true

    private lazy var circularPath: UIBezierPath = {
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: 120, startAngle: startPoint, endAngle: endPoint, clockwise: true)
        return circularPath
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        createCircularPath()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createCircularPath()
    }

    private func createCircularPath() {
        // settings of circle
        circleLayer.path = circularPath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineWidth = 2.0
        circleLayer.strokeEnd = 1.0
        circleLayer.strokeColor = UIColor.red.cgColor
        layer.addSublayer(circleLayer)

        // settings of animation path
        progressLayer.path = circularPath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineWidth = 5.0
        progressLayer.strokeEnd = 0
        progressLayer.strokeColor = UIColor.red.cgColor
        layer.addSublayer(progressLayer)
        }

    func startAnimation(duration: Double) {
        circularProgressAnimation.duration = duration
        circularProgressAnimation.fromValue = 0
        circularProgressAnimation.toValue = 1
        circularProgressAnimation.fillMode = .backwards
        circularProgressAnimation.isRemovedOnCompletion = false
        progressLayer.add(circularProgressAnimation, forKey: "progressAnim")

        isAnimationPaused = false
        }


    func changeCircularPathColor(to color: CGColor) {
        progressLayer.strokeColor = color
        circleLayer.strokeColor = color
    }

    private func pauseAnimation() {
        let pausedTime = progressLayer.convertTime(CACurrentMediaTime(), from: nil)
        progressLayer.speed = 0.0
        progressLayer.timeOffset = pausedTime
    }

    private func resumeAnimation() {
        let pausedTime = progressLayer.timeOffset
        progressLayer.speed = 1.0
        progressLayer.timeOffset = 0.0
        progressLayer.beginTime = 0.0

        let timeSincePause = progressLayer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        progressLayer.beginTime = timeSincePause
    }

    func toggleAnimationState() {

        if isAnimationPaused {
            resumeAnimation()
        } else {
            pauseAnimation()
        }

        isAnimationPaused.toggle()
    }
}

