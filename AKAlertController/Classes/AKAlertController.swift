//
//  AKAlertController.swift
//  piranha
//
//  Created by imac4 on 14/05/2020.
//  Copyright © 2020 AiweApps. All rights reserved.
//

import Foundation
import TinyConstraints

public enum AKAlertControllerStyle: Int {
    case alert
    case actionSheet
}

public struct AKAlertControllerAppearance {
    let overlayColor = UIColor.black.withAlphaComponent(0.5)
    let alertBgColor = UIColor.white
    let alertCornerRadius: CGFloat = 10
    let textMargins: UIEdgeInsets = .uniform(15)
    let titleBottomOffset: CGFloat = 5
    
    let titleFont = UIFont.systemFont(ofSize: 17, weight: .semibold)
    let titleTextColor = UIColor.black
    let messageFont = UIFont.systemFont(ofSize: 13)
    let messageTextColor = UIColor.black
    let textContainerBgColor = UIColor.white
    
    let alertButtonsHeight: CGFloat = 44
    let actionSheetButtonsHeight: CGFloat = 56
    let buttonsBordersWidth: CGFloat = 1
    let buttonsBordersColor: UIColor = UIColor.lightGray.withAlphaComponent(0.5)
    
    let buttonFont: [AKAlertActionStyle: UIFont] = [
        .default: UIFont.systemFont(ofSize: 17),
        .cancel: UIFont.systemFont(ofSize: 17, weight: .semibold),
        .destructive: UIFont.systemFont(ofSize: 17)
    ]
    let buttonTextColor: [AKAlertActionStyle: UIColor] = [
        .default: UIColor.systemBlue,
        .cancel: UIColor.systemBlue,
        .destructive: UIColor.systemRed
    ]
    let buttonBgColor: [AKAlertActionStyle : UIColor] = [
        .default: UIColor.white,
        .cancel: UIColor.white,
        .destructive: UIColor.white
    ]
    
    public static func defaultAppearance() -> AKAlertControllerAppearance {
        return AKAlertControllerAppearance()
    }
}

open class AKAlertController: UIViewController {
    
    fileprivate var alertViewWidth: CGFloat = 270.0
    
    let overlayView = UIView()
    let containerView = UIView()
    private let containerStackView = UIStackView()
    
    private let textScrollableContainer = UIScrollView()
    private let textStackView = UIStackView()
    private let titleLabel = UILabel()
    private let messageLabel = UILabel()
    
    private let buttonsContainerView = UIView()
    private let buttonsStackView = UIStackView()
    
    open fileprivate(set) var actions = [AKAlertAction]()
    fileprivate var appearance: AKAlertControllerAppearance!
    fileprivate var hasText = true
    
    var isAlert = true
    
    public convenience init(title: String?, message: String?,
                            preferredStyle: AKAlertControllerStyle,
                            appearance: AKAlertControllerAppearance = AKAlertControllerAppearance.defaultAppearance()) {
        self.init()
        
        self.appearance = appearance
        self.titleLabel.text = title
        self.messageLabel.text = message
        self.hasText = title != nil || message != nil
        self.isAlert = preferredStyle == .alert
        
        self.modalPresentationStyle = .custom
        self.transitioningDelegate = self
    }
    
    // MARK: - Lifecycle
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        layout()
        setupApperance()
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard isAlert == false, actions.contains(where: { $0.style == .cancel }) else { return }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleOverlayViewTapGesture))
        overlayView.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Private helpers
    
    private func setupApperance() {
        buttonsStackView.axis = (!isAlert || actions.count > 2) ? .vertical : .horizontal
        buttonsStackView.distribution = .fillEqually
        textStackView.axis = .vertical
        containerStackView.axis = .vertical
        textStackView.spacing = hasText ? appearance.titleBottomOffset : 0
        
        [titleLabel, messageLabel].forEach { (label) in
            label.numberOfLines = 0
            label.textAlignment = .center
        }
        titleLabel.font = appearance.titleFont
        titleLabel.textColor = appearance.titleTextColor
        messageLabel.font = appearance.messageFont
        messageLabel.textColor = appearance.messageTextColor
        
        overlayView.backgroundColor = appearance.overlayColor
        containerView.layer.cornerRadius = appearance.alertCornerRadius
        containerView.backgroundColor = .clear
        containerView.clipsToBounds = true
        
        textStackView.isLayoutMarginsRelativeArrangement = hasText
        textStackView.layoutMargins = appearance.textMargins
        
        buttonsContainerView.backgroundColor = appearance.buttonsBordersColor
        buttonsStackView.isLayoutMarginsRelativeArrangement = hasText
        buttonsStackView.layoutMargins = .top(appearance.buttonsBordersWidth)
        buttonsStackView.spacing = appearance.buttonsBordersWidth
        
        textScrollableContainer.backgroundColor = appearance.textContainerBgColor
    }
    
    private func layout() {
        [overlayView, containerView].forEach({ view.addSubview($0) })
        overlayView.edgesToSuperview()
        containerView.heightToSuperview(multiplier: 0.95, relation: .equalOrLess, usingSafeArea: true)
        containerView.addSubview(containerStackView)
        containerStackView.edgesToSuperview()
        
        if isAlert {
            containerView.width(alertViewWidth)
            containerView.centerInSuperview()
        } else {
            containerView.centerXToSuperview()
            containerView.widthToSuperview(multiplier: 0.95, usingSafeArea: true)
            containerView.bottomToSuperview(usingSafeArea: true)
        }
        
        containerStackView.addArrangedSubview(textScrollableContainer)
        textScrollableContainer.addSubview(textStackView)
        textStackView.widthToSuperview()
        textStackView.heightToSuperview(priority: .defaultLow)
        textStackView.widthToSuperview()
        
        containerStackView.addArrangedSubview(buttonsContainerView)
        buttonsContainerView.addSubview(buttonsStackView)
        
        [textStackView, buttonsStackView].forEach({ $0.edgesToSuperview() })
        [titleLabel, messageLabel].forEach({ textStackView.addArrangedSubview($0) })
        
        layouActionsButtons()
    }
    
    private func layouActionsButtons() {
        actions.sort {$0.style.rawValue < $1.style.rawValue}
        for (index, action) in actions.enumerated() {
            let button = UIButton()
            button.tag = index
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            button.setTitle(action.title, for: .normal)
            button.setImage(action.icon, for: .normal)
            button.titleLabel?.font = action.font ?? appearance.buttonFont[action.style]
            button.setTitleColor(action.textColor ?? appearance.buttonTextColor[action.style], for: .normal)
            button.backgroundColor = action.bgColor ?? appearance.buttonBgColor[action.style]
            button.height(isAlert ? appearance.alertButtonsHeight : appearance.actionSheetButtonsHeight)
            if !isAlert && action.style == .cancel {
                button.backgroundColor = .red
                button.layer.cornerRadius = appearance.alertCornerRadius
                containerStackView.addArrangedSubview(button, withMargin: .top(10))
            } else {
                buttonsStackView.addArrangedSubview(button)
            }
        }
    }
    
    // MARK: - Handlers
    
    @objc func handleOverlayViewTapGesture() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        let action = actions[sender.tag]
        action.handler?(action)
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Public Methods
    
    open func addAction(_ action: AKAlertAction) {
        if action.style == .cancel && actions.contains(where: { $0.style == .cancel }) {
            fatalError("AKAlertController can only have one action with a style of AKAlertActionStyleCancel")
        }
        actions.append(action)
    }
    
}

extension AKAlertController: UIViewControllerTransitioningDelegate {
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AKAlertAnimator(isPresenting: true)
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AKAlertAnimator(isPresenting: false)
    }
    
}
