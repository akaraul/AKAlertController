//
//  AKAlertExtensions.swift
//  AKAlertController
//
//  Created by imac4 on 15/05/2020.
//

import Foundation

class HorizontalScrollableStackWithBackgroundView: UIScrollView {
    
    let stackView = UIStackView()
    
    init(axis: NSLayoutConstraint.Axis = .vertical) {
        super.init(frame: .zero)
        clipsToBounds = true
        addSubview(stackView)
        stackView.axis = axis
        stackView.widthToSuperview()
        stackView.heightToSuperview(priority: .defaultLow)
        stackView.edgesToSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class StackWithBackgroundView: UIView {
    
    let stackView = UIStackView()
    
    init(axis: NSLayoutConstraint.Axis = .vertical) {
        super.init(frame: .zero)
        clipsToBounds = true
        addSubview(stackView)
        stackView.axis = axis
        stackView.edgesToSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

extension UIDevice {
    
    var hasNotch: Bool {
        if #available(iOS 11.0, *) {
            let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
            return bottom > 0
        } else {
            return false
        }
    }
    
}

extension UIColor {
    
    static var systemWhiteColor: UIColor {
        if #available(iOS 13.0, *) {
            return .systemBackground
        } else {
            return .white
        }
    }
    
    static var systemBlackColor: UIColor {
        if #available(iOS 13.0, *) {
            return .label
        } else {
            return .black
        }
    }
    
}
