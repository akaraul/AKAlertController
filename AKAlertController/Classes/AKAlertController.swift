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

open class AKAlertController: UIViewController {
    
    let overlayView = UIView()
    let containerView = StackWithBackgroundView()
    private let mainContentContainer = StackWithBackgroundView()
    
    private let titleLabel = UILabel()
    private let messageLabel = UILabel()
    private let textScrollableContainer = HorizontalScrollableStackWithBackgroundView()
    private let textFieldsContainer = StackWithBackgroundView()
    private let buttonsContainerView = StackWithBackgroundView()
    
    open fileprivate(set) var actions = [AKAlertAction]()
    open fileprivate(set) var textFields = [UITextField]()
    open fileprivate(set) var isAlert = true
    fileprivate var appearance: AKAlertControllerAppearance!
    fileprivate var hasText = true
    fileprivate var image: UIImage?
    
    public convenience init(title: String?, message: String?, headerImage: UIImage? = nil,
                            preferredStyle: AKAlertControllerStyle,
                            appearance: AKAlertControllerAppearance = AKAlertControllerAppearance.defaultAppearance()) {
        self.init()
        
        self.appearance = appearance
        self.titleLabel.text = title
        self.messageLabel.text = message
        self.hasText = title != nil || message != nil
        self.isAlert = preferredStyle == .alert
        self.image = headerImage
        
        self.modalPresentationStyle = .custom
        self.transitioningDelegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Lifecycle
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        layout()
        setupApperance()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textFields.first?.becomeFirstResponder()
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard isAlert == false, actions.contains(where: { $0.style == .cancel }) else { return }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleOverlayViewTapGesture))
        overlayView.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Private helpers
    
    private func setupApperance() {
        buttonsContainerView.stackView.axis = (!isAlert || actions.count > 2) ? .vertical : .horizontal
        buttonsContainerView.stackView.distribution = .fillEqually
        
        [titleLabel, messageLabel].forEach { (label) in
            label.numberOfLines = 0
            label.textAlignment = .center
        }
        titleLabel.font = appearance.titleFont
        titleLabel.textColor = appearance.titleTextColor
        messageLabel.font = appearance.messageFont
        messageLabel.textColor = appearance.messageTextColor
        
        overlayView.backgroundColor = appearance.overlayColor
        containerView.backgroundColor = isAlert ? appearance.alertContainerBgColor : .clear
        mainContentContainer.backgroundColor = appearance.mainContentContainerBgColor
        [containerView.layer, mainContentContainer.layer].forEach({ $0.cornerRadius = appearance.alertCornerRadius })
        
        textScrollableContainer.backgroundColor = appearance.textContainerBgColor
        textScrollableContainer.stackView.isLayoutMarginsRelativeArrangement = hasText
        textScrollableContainer.stackView.layoutMargins = appearance.textMargins
        textScrollableContainer.stackView.spacing = hasText ? appearance.titleBottomOffset : 0
        
        mainContentContainer.stackView.isLayoutMarginsRelativeArrangement = image != nil
        mainContentContainer.stackView.layoutMargins = .top(appearance.headerImageTopOffset)
        
        textFieldsContainer.backgroundColor = appearance.textFieldsContainerBgColor
        textFieldsContainer.stackView.isLayoutMarginsRelativeArrangement = hasText
        textFieldsContainer.stackView.layoutMargins = appearance.textFieldsMargins
        textFieldsContainer.stackView.spacing = appearance.textFieldsSpacing
        
        buttonsContainerView.backgroundColor = appearance.buttonsBordersColor
        buttonsContainerView.stackView.isLayoutMarginsRelativeArrangement = hasText
        buttonsContainerView.stackView.layoutMargins = .top(appearance.buttonsBordersWidth)
        buttonsContainerView.stackView.spacing = appearance.buttonsBordersWidth
    }
    
    private func layout() {
        [overlayView, containerView].forEach({ view.addSubview($0) })
        overlayView.edgesToSuperview()
        containerView.heightToSuperview(multiplier: 0.95, relation: .equalOrLess, usingSafeArea: true)
        containerView.stackView.addArrangedSubview(mainContentContainer)
        if let headerImage = image {
            let imgView = UIImageView(image: headerImage)
            imgView.contentMode = .scaleAspectFit
            imgView.height(max: appearance.headerMaxHeight)
            mainContentContainer.stackView.addArrangedSubview(imgView)
        }
        if isAlert {
            containerView.width(appearance.alertViewWidth)
            containerView.centerInSuperview()
        } else {
            containerView.centerXToSuperview()
            containerView.widthToSuperview(multiplier: appearance.actionSheetWidthMultiplier, usingSafeArea: true)
            containerView.bottomToSuperview(offset: UIDevice.current.hasNotch ? 0 : -10, usingSafeArea: true)
        }
        if hasText {
            mainContentContainer.stackView.addArrangedSubview(textScrollableContainer)
            let textLabels = [titleLabel, messageLabel].filter({ $0.text != nil })
            textLabels.forEach({ textScrollableContainer.stackView.addArrangedSubview($0) })
        }
        if isAlert && textFields.isEmpty == false {
            mainContentContainer.stackView.addArrangedSubview(textFieldsContainer)
        }
        if actions.isEmpty == false {
            mainContentContainer.stackView.addArrangedSubview(buttonsContainerView)
            layouActionsButtons()
        }
    }
    
    private func layouActionsButtons() {
        actions.sort {$0.style.rawValue < $1.style.rawValue}
        for (index, action) in actions.enumerated() {
            let button = UIButton()
            button.tag = index
            button.titleLabel?.adjustsFontSizeToFitWidth = true
            button.titleLabel?.minimumScaleFactor = 0.5
            button.contentEdgeInsets = appearance.buttonsContentEdgeInsets
            button.imageEdgeInsets = appearance.buttonsImageEdgeInsets
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            button.setTitle(action.title, for: .normal)
            button.setImage(action.icon, for: .normal)
            button.titleLabel?.font = action.font ?? appearance.buttonFont[action.style]
            button.setTitleColor(action.textColor ?? appearance.buttonTextColor[action.style], for: .normal)
            button.backgroundColor = action.bgColor ?? appearance.buttonBgColor[action.style]
            button.height(isAlert ? appearance.alertButtonsHeight : appearance.actionSheetButtonsHeight)
            if !isAlert && action.style == .cancel {
                button.layer.cornerRadius = appearance.alertCornerRadius
                containerView.stackView.addArrangedSubview(button, withMargin: .top(10))
            } else {
                buttonsContainerView.stackView.addArrangedSubview(button)
            }
        }
    }
    
    // MARK: - Handlers
    
    @objc private func handleOverlayViewTapGesture() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        let action = actions[sender.tag]
        action.handler?(action)
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func handleKeyboardNotification(_ notification: Notification) {
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else{
            return
        }
        //TODO: improve this (need correct offset)
        if notification.name == UIResponder.keyboardWillShowNotification  {
            view.frame.origin.y = -keyboardRect.height / 2
        } else{
            view.frame.origin.y = 0
        }
    }
    
    // MARK: - Public Methods
    
    open func addAction(_ action: AKAlertAction) {
        if action.style == .cancel && actions.contains(where: { $0.style == .cancel }) {
            fatalError("AKAlertController can only have one action with a style of AKAlertActionStyleCancel")
        }
        actions.append(action)
    }
    
    open func addTextFieldWithConfigurationHandler(_ configurationHandler: ((UITextField?) -> Void)?) {
        guard isAlert else { fatalError("Text fields can only be added to an alert controller of style AKAlertControllerStyle") }
        
        let textField = UITextField()
        textField.tag = textFields.count
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.height(appearance.textFieldsHeight)
        textField.delegate = self
        textFields.append(textField)
        textFieldsContainer.stackView.addArrangedSubview(textField)
        configurationHandler?(textField)
    }
    
}

extension AKAlertController: UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextTextField = textFields.first(where: { $0.tag == textField.tag + 1 }) {
            nextTextField.becomeFirstResponder()
        } else {
             textField.resignFirstResponder()
        }
        return false
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
