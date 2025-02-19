//
//  UIView+border.swift
//  DailyTyping
//
//  Created by 조유진 on 2/8/25.
//

import UIKit

extension CALayer {
    @discardableResult
    func addBorder(to edges: [UIRectEdge], color: UIColor = .primaryEmphasis, width: CGFloat) -> [CALayer] {
        let viewFrame = self.frame
        var borderLayers = [CALayer]()

        for edge in edges {
            let borderLayer = CALayer()
            borderLayer.backgroundColor = color.cgColor

            switch edge {
            case .top:
                borderLayer.frame = CGRect(x: 0, y: 0, width: viewFrame.width, height: width)
            case .bottom:
                borderLayer.frame = CGRect(x: 0, y: viewFrame.height - width, width: viewFrame.width, height: width)
            case .left:
                borderLayer.frame = CGRect(x: 0, y: 0, width: width, height: viewFrame.height)
            case .right:
                borderLayer.frame = CGRect(x: viewFrame.width - width, y: 0, width: width, height: viewFrame.height)
            default:
                break
            }
            
            borderLayer.backgroundColor = color.cgColor
            self.addSublayer(borderLayer)
        }

        return borderLayers
    }
}
