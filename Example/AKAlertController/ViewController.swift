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
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showAlert(_ sender: Any) {
        let alertController = AKAlertController(title: "title", message: "message", preferredStyle: .alert)
        alertController.addAction(AKAlertAction(title: "TEST1", style: .default, handler: { _ in }))
        alertController.addAction(AKAlertAction(title: "TEST2", style: .destructive, handler: { _ in }))
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func showActionSheet(_ sender: Any) {
        let actionSheet = AKAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(AKAlertAction(title: "Constants.contactPhoneNumber", style: .default, handler: { _ in  }))
        actionSheet.addAction(AKAlertAction(title: "Constants.contactEmail", style: .default, handler: { _ in  }))
        actionSheet.addAction(AKAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(actionSheet, animated: true, completion: nil)
    }
    
    
    @IBAction func showAlertFullText(_ sender: Any) {
            let alertController = AKAlertController(title: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.", message: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.", preferredStyle: .alert)
            alertController.addAction(AKAlertAction(title: "TEST1", style: .default, handler: { _ in }))
            alertController.addAction(AKAlertAction(title: "TEST2", style: .destructive, handler: { _ in }))
            present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func showAlertWithCustomAppearance(_ sender: Any) {
        let appearance = AKAlertControllerAppearance.defaultAppearance()
        let alertController = AKAlertController(title: "title", message: "message", preferredStyle: .alert, appearance: appearance)
        let customAction = AKAlertAction(title: "Custom action", style: .default, handler: { _ in })
        customAction.textColor = .orange
        customAction.bgColor = .blue
        alertController.addAction(customAction)
        alertController.addAction(AKAlertAction(title: "TEST2", style: .destructive, handler: { _ in }))
        present(alertController, animated: true, completion: nil)
    }

}

