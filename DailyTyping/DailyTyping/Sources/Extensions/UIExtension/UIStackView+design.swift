//
//  UIStackView+design.swift
//  DailyTyping
//
//  Created by 조유진 on 2/14/25.
//

import UIKit

extension UIStackView {
    func design(axis: NSLayoutConstraint.Axis = .vertical,
                alignment: UIStackView.Alignment = .fill,
                distribution: UIStackView.Distribution = .fill,
                spacing: CGFloat = 16
    ) {
        self.axis = axis
        self.alignment = alignment
        self.distribution = distribution
        self.spacing = spacing
    }
}
