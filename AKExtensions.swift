//
//  AKExtensions.swift
//  AKAlertController
//
//  Created by imac4 on 15/05/2020.
//

import Foundation

extension UIView {
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat, frame: CGRect = CGRect.zero) {
        let roundedRect = frame == CGRect.zero ? bounds : frame
        let maskPath = UIBezierPath(roundedRect: roundedRect,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius, height: radius))
        
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
    
}

extension UIStackView {

    func addArrangedSubview(_ view: UIView, withMargin margins: UIEdgeInsets) {
        let container = UIView()
        container.backgroundColor = .clear
        container.addSubview(view)
        view.edgesToSuperview(insets: margins)

        addArrangedSubview(container)
    }
    
}
