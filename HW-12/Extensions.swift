//
//  Extensions.swift
//  HW-12
//
//  Created by Vadim Kim on 21.05.2022.
//

import UIKit

extension PomidorViewController {
    enum Metric {
        static let timerStackViewSpacing: CGFloat = 10
        static let timerLabelTextFont: CGFloat = 45

        static let parentViewWidthMultiplier: CGFloat = 2 / 3
        static let parentViewHeightMultiplier: CGFloat = 2 / 3

        static let timerStackViewHeightMultiplier: CGFloat = 2 / 3
    }
}

extension Int {
    func toSeconds() -> Int {
        self * 60
    }
}
