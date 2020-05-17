//
//  ViewController.swift
//  AKAlertController
//
//  Created by akaraul on 05/15/2020.
//  Copyright (c) 2020 akaraul. All rights reserved.
//

import UIKit
import AKAlertController

class ViewController: UIViewController {
    
    @IBAction func showAlert(_ sender: Any) {
        let alertController = AKAlertController(title: "Title label", message: "Message label", preferredStyle: .alert)
        let handler: (AKAlertAction) -> Void = { action in print("\(action.title) pressed" )}
        alertController.addAction(AKAlertAction(title: "Default action", style: .default, handler: handler))
        alertController.addAction(AKAlertAction(title: "Cancel action", style: .cancel, handler: handler))
        alertController.addAction(AKAlertAction(title: "Destructive action", style: .destructive, handler: handler))
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func showActionSheet(_ sender: Any) {
        let actionSheet = AKAlertController(title: "Title label", message: nil, preferredStyle: .actionSheet)
        let handler: (AKAlertAction) -> Void = { action in print("\(action.title) pressed" )}
        actionSheet.addAction(AKAlertAction(title: "Default action", style: .default, handler: handler))
        actionSheet.addAction(AKAlertAction(title: "Cancel action", style: .cancel, handler: handler))
        actionSheet.addAction(AKAlertAction(title: "Destructive action", style: .destructive, handler: handler))
        present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func showAlertFullText(_ sender: Any) {
        let alertController = AKAlertController(title: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.", message: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.", preferredStyle: .alert)
        let handler: (AKAlertAction) -> Void = { action in print("\(action.title) pressed" )}
        alertController.addAction(AKAlertAction(title: "First action", style: .default, handler: handler))
        alertController.addAction(AKAlertAction(title: "Second action", style: .destructive, handler: handler))
        present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func showAlertWithCustomAppearance(_ sender: Any) {
        var appearance = AKAlertControllerAppearance.defaultAppearance()
        appearance.titleFont = .systemFont(ofSize: 22)
        appearance.titleTextColor = .purple
        appearance.messageTextColor = .red
        appearance.buttonBgColor[.destructive] = .yellow
        appearance.textContainerBgColor = .green
        appearance.overlayColor = UIColor.red.withAlphaComponent(0.5)
        
        let alertController = AKAlertController(title: "Lorem Ipsum is simply dummy text of the printing and typesetting industry", message: "Message title", preferredStyle: .alert, appearance: appearance)
        let handler: (AKAlertAction) -> Void = { action in print("\(action.title) pressed" )}
        alertController.addAction(AKAlertAction(title: "Destructive action", style: .destructive, handler: handler))
        
        let cancelAction = AKAlertAction(title: "Cancel", style: .cancel, handler: handler)
        cancelAction.bgColor = .black
        cancelAction.textColor = .white
        cancelAction.icon = UIImage(named: "close")
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func showActionSheetWithCustomApperance(_ sender: Any) {
        var appearance = AKAlertControllerAppearance.defaultAppearance()
        appearance.titleFont = .systemFont(ofSize: 22)
        appearance.titleTextColor = .red
        appearance.buttonBgColor[.destructive] = .yellow
        appearance.textContainerBgColor = .green
        appearance.buttonsBordersWidth = 4
        appearance.buttonsBordersColor = .blue
        appearance.overlayColor = UIColor.orange.withAlphaComponent(0.5)
        
        let alertController = AKAlertController(title: "Lorem Ipsum is simply dummy text of the printing and typesetting industry", message: "Message title", preferredStyle: .actionSheet, appearance: appearance)
        let handler: (AKAlertAction) -> Void = { action in print("\(action.title) pressed" )}
        alertController.addAction(AKAlertAction(title: "Default action", style: .default, handler: handler))
        alertController.addAction(AKAlertAction(title: "Destructive action", style: .destructive, handler: handler))
        alertController.addAction(AKAlertAction(title: "Default action 2", style: .default, handler: handler))
        present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func showAlertWithTextFields(_ sender: Any) {
        let alertController = AKAlertController(title: "Title label", message: "Message label", preferredStyle: .alert)
        let handler: (AKAlertAction) -> Void = { action in print("\(action.title) pressed" )}
        alertController.addAction(AKAlertAction(title: "Default action", style: .default, handler: handler))
        alertController.addAction(AKAlertAction(title: "Cancel action", style: .cancel, handler: handler))
        alertController.addAction(AKAlertAction(title: "Destructive action", style: .destructive, handler: handler))
        alertController.addTextFieldWithConfigurationHandler { (textField) in
            textField?.placeholder = "First textfield"
        }
        alertController.addTextFieldWithConfigurationHandler { (textField) in
            textField?.placeholder = "Second textfield"
        }
        present(alertController, animated: true, completion: nil)
    }
    
}
