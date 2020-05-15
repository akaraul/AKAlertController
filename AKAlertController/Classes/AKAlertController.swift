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
    case actionSheet
    case alert
}

public struct AKAlertControllerAppearance {
    let overlayColor = UIColor.black.withAlphaComponent(0.5)
    let alertBgColor = UIColor.white
    let alertCornerRadius: CGFloat = 10
    let textMargins: CGFloat = 15
    let titleBottomOffset: CGFloat = 8
    
    let titleFont = UIFont.systemFont(ofSize: 18, weight: .bold)
    let titleTextColor = UIColor.black
    let messageFont = UIFont.systemFont(ofSize: 14)
    let messageTextColor = UIColor.black
    
    let buttonsHeight: CGFloat = 44
    let buttonsTopMargin: CGFloat = 10
    
    let buttonFont: [AKAlertActionStyle: UIFont] = [
        .default: UIFont.systemFont(ofSize: 16),
        .cancel: UIFont.systemFont(ofSize: 16),
        .destructive: UIFont.systemFont(ofSize: 16)
    ]
    let buttonTextColor: [AKAlertActionStyle: UIColor] = [
        .default: UIColor.blue,
        .cancel: UIColor.blue,
        .destructive: UIColor.red
    ]
    let buttonBgColor: [AKAlertActionStyle : UIColor] = [
        .default: UIColor.clear,
        .cancel: UIColor.clear,
        .destructive: UIColor.clear
    ]
}

final class AKAlertController: UIViewController {
    
    fileprivate var alertViewWidth: CGFloat = 270.0
    
    let overlayView = UIView()
    let containerView = UIView()
    private let titleLabel = UILabel()
    private let messageLabel = UILabel()
    
    private let textStackView = UIStackView()
    private let buttonsStackView = UIStackView()
    
    open fileprivate(set) var actions = [AKAlertAction]()
    
    var isAlert: Bool {
        return preferredStyle == .alert
    }
    
    fileprivate var appearance: AKAlertControllerAppearance!
    fileprivate var preferredStyle: AKAlertControllerStyle!
    
    public convenience init(title: String?, message: String?,
                            preferredStyle: AKAlertControllerStyle,
                            appearance: AKAlertControllerAppearance = AKAlertControllerAppearance()) {
        self.init()
        
        self.preferredStyle = preferredStyle
        self.appearance = appearance
        self.titleLabel.text = title
        self.messageLabel.text = message
        
        self.modalPresentationStyle = .custom
        self.transitioningDelegate = self
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        setupApperance()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !isAlert {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleContainerViewTapGesture))
            overlayView.addGestureRecognizer(tapGesture)
        }
    }
    
    // MARK: - Private helpers
    
    private func setupApperance() {
        buttonsStackView.axis = (!isAlert || actions.count > 2) ? .vertical : .horizontal
        buttonsStackView.distribution = .fillEqually
        textStackView.axis = .vertical
        textStackView.spacing = appearance.titleBottomOffset
        
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
        containerView.backgroundColor = appearance.alertBgColor
        containerView.clipsToBounds = true
    }
    
    private func layout() {
        [overlayView, containerView].forEach({ view.addSubview($0) })
        [textStackView, buttonsStackView].forEach({ containerView.addSubview($0) })
        
        textStackView.edgesToSuperview(excluding: .bottom, insets: .uniform(appearance.textMargins))
        buttonsStackView.edgesToSuperview(excluding: .top)
        buttonsStackView.topToBottom(of: textStackView, offset: appearance.buttonsTopMargin)
        
        overlayView.edgesToSuperview()
        containerView.heightToSuperview(relation: .equalOrLess, usingSafeArea: true)
        if isAlert {
            containerView.width(alertViewWidth)
            containerView.centerInSuperview()
        } else {
            containerView.centerXToSuperview()
            containerView.widthToSuperview()
            containerView.bottomToSuperview(usingSafeArea: true)
        }
        textStackView.addArrangedSubview(titleLabel)
        textStackView.addArrangedSubview(messageLabel)
        
        for (index, action) in actions.enumerated() {
            let button = UIButton()
            button.tag = index
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            button.setTitle(action.title, for: .normal)
            button.titleLabel?.font = action.font ?? appearance.buttonFont[action.style]
            button.setTitleColor(action.textColor ?? appearance.buttonTextColor[action.style], for: .normal)
            button.backgroundColor = action.bgColor ?? appearance.buttonBgColor[action.style]
            buttonsStackView.addArrangedSubview(button)
            button.height(appearance.buttonsHeight)
        }
    }
    
    // MARK: - Handlers
    
    @objc func handleContainerViewTapGesture() {
//        let action = actions[cancelButtonTag - 1]
//        action.handler?(action)
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
            fatalError("Needed only one cancel button")
        }
        actions.append(action)
    }
    
}

extension AKAlertController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AKAlertAnimator(isPresenting: true)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AKAlertAnimator(isPresenting: false)
    }
    
}
