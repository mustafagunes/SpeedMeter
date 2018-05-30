//
//  ViewController.swift
//  SpeedMeter
//
//  Created by Mustafa GUNES on 29.05.2018.
//  Copyright © 2018 Mustafa GUNES. All rights reserved.
//

import UIKit
import RevealingSplashView
import CNPPopupController

class ViewController: UIViewController {
    
    var popupController:CNPPopupController?
    
    let splashView = RevealingSplashView(iconImage: UIImage (named: "Icon-3x")!, iconInitialSize: CGSize (width: 70, height: 70), backgroundColor: UIColor.white)

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.addSubview(splashView)
        splashView.animationType = .heartBeat
        splashView.startAnimation()
        
        Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { (timer) in
            self.splashView.finishHeartBeatAnimation()
        }
    }
    
    func showPopupWithStyle(_ popupStyle: CNPPopupStyle) {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = NSLineBreakMode.byWordWrapping
        paragraphStyle.alignment = NSTextAlignment.center
        
        let title = NSAttributedString(string: "It's A Popup!", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 24), NSParagraphStyleAttributeName: paragraphStyle])
        let lineOne = NSAttributedString(string: "You can add text and images", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 18), NSParagraphStyleAttributeName: paragraphStyle])
        let lineTwo = NSAttributedString(string: "With style, using NSAttributedString", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 18), NSForegroundColorAttributeName: UIColor.init(colorLiteralRed: 0.46, green: 0.8, blue: 1.0, alpha: 1.0), NSParagraphStyleAttributeName: paragraphStyle])
        
        let button = CNPPopupButton.init(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
        button.setTitleColor(UIColor.white, for: UIControlState())
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitle("Close Me", for: UIControlState())
        
        button.backgroundColor = UIColor.init(colorLiteralRed: 0.46, green: 0.8, blue: 1.0, alpha: 1.0)
        
        button.layer.cornerRadius = 4;
        button.selectionHandler = { (button) -> Void in
            self.popupController?.dismiss(animated: true)
            print("Block for button: \(String(describing: button.titleLabel?.text))")
        }
        
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0;
        titleLabel.attributedText = title
        
        let lineOneLabel = UILabel()
        lineOneLabel.numberOfLines = 0;
        lineOneLabel.attributedText = lineOne;
        
        let imageView = UIImageView.init(image: UIImage.init(named: "icon"))
        
        let lineTwoLabel = UILabel()
        lineTwoLabel.numberOfLines = 0;
        lineTwoLabel.attributedText = lineTwo;
        
        let customView = UIView.init(frame: CGRect(x: 0, y: 0, width: 250, height: 55))
        customView.backgroundColor = UIColor.lightGray
        
        let textField = UITextField.init(frame: CGRect(x: 10, y: 10, width: 230, height: 35))
        textField.borderStyle = UITextBorderStyle.roundedRect
        textField.placeholder = "Custom view!"
        customView.addSubview(textField)
        
        let popupController = CNPPopupController(contents:[titleLabel, lineOneLabel, imageView, lineTwoLabel, customView, button])
        popupController.theme = CNPPopupTheme.default()
        popupController.theme.popupStyle = popupStyle
        // LFL added settings for custom color and blur
        popupController.theme.maskType = CNPPopupMaskType.custom
        popupController.theme.customMaskColor = UIColor.red
        popupController.theme.blurEffectAlpha = 1.0
        popupController.delegate = self
        self.popupController = popupController
        popupController.present(animated: true)
    }
}

extension ViewController : CNPPopupControllerDelegate {
    
    func popupControllerWillDismiss(_ controller: CNPPopupController) {
        print("Popup controller will be dismissed")
    }
    
    func popupControllerDidPresent(_ controller: CNPPopupController) {
        print("Popup controller presented")
    }
}