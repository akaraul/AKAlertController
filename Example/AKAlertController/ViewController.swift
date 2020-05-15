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

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func showAlert(_ sender: Any) {
        let alertController = AKAlertController(title: nil, message: nil, preferredStyle: .alert)
        alertController.addAction(AKAlertAction(title: "Destructive1", style: .destructive, handler: { _ in }))
        alertController.addAction(AKAlertAction(title: "Default", style: .default, handler: { _ in }))
        alertController.addAction(AKAlertAction(title: "Cancel", style: .cancel, handler: { _ in }))
        alertController.addAction(AKAlertAction(title: "Destructive", style: .destructive, handler: { _ in }))
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func showActionSheet(_ sender: Any) {
        let actionSheet = AKAlertController(title: "title", message: "message", preferredStyle: .actionSheet)
        actionSheet.addAction(AKAlertAction(title: "Destructive1", style: .destructive, handler: { _ in }))
        actionSheet.addAction(AKAlertAction(title: "Default", style: .default, handler: { _ in }))
        actionSheet.addAction(AKAlertAction(title: "Cancel", style: .cancel, handler: { _ in }))
        actionSheet.addAction(AKAlertAction(title: "Destructive", style: .destructive, handler: { _ in }))
        present(actionSheet, animated: true, completion: nil)
        
//        let alert = UIAlertController(title: "title", message: "message", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in }))
//        alert.addAction(UIAlertAction(title: "Destructive1", style: .destructive, handler: { _ in }))
//        alert.addAction(UIAlertAction(title: "Destructive", style: .destructive, handler: { _ in }))
//        alert.addAction(UIAlertAction(title: "Default", style: .default, handler: { _ in }))
//        present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func showAlertFullText(_ sender: Any) {
            let alertController = AKAlertController(title: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.", message: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.", preferredStyle: .alert)
            alertController.addAction(AKAlertAction(title: "TEST1", style: .default, handler: { _ in }))
            alertController.addAction(AKAlertAction(title: "TEST2", style: .destructive, handler: { _ in }))
            present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func showAlertWithCustomAppearance(_ sender: Any) {
        let appearance = AKAlertControllerAppearance.defaultAppearance()
        let alertController = AKAlertController(title: "title", message: "message", preferredStyle: .alert, appearance: appearance)
        let customAction = AKAlertAction(title: "Custom action", style: .default, handler: { _ in })
        customAction.textColor = .magenta
        customAction.bgColor = .blue
        if #available(iOS 13.0, *) {
            customAction.icon = UIImage(systemName: "square.and.arrow.down")
        } 
        alertController.addAction(customAction)
        alertController.addAction(AKAlertAction(title: "TEST2", style: .destructive, handler: { _ in }))
        present(alertController, animated: true, completion: nil)
        
//        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
//        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in }))
//        alert.addAction(UIAlertAction(title: "Destructive1", style: .destructive, handler: { _ in }))
//        alert.addAction(UIAlertAction(title: "Destructive", style: .destructive, handler: { _ in }))
//        alert.addAction(UIAlertAction(title: "Default", style: .default, handler: { _ in }))
//        present(alert, animated: true, completion: nil)
    }

}

