//
//  CommonHelpers.swift
//  StudentsDetails
//
//  Created by admin on 21/05/21.
//

import Foundation
import UIKit

class CommonHelper {
    
    // MARK: - Common Functions
    static let shared = CommonHelper()
    private init() {}
    
    func showToast(message : String, font: UIFont, position: CGFloat = 150) {
        let yPos = UIScreen.main.bounds.size.height - position
        
        // create a label
        DispatchQueue.main.async {
            let toastLabel = UILabel(frame: CGRect(x: 50, y: yPos, width: UIScreen.main.bounds.size.width - 100, height: 50))
            toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            toastLabel.numberOfLines = 0
            toastLabel.textColor = UIColor.white
            toastLabel.font = font
            toastLabel.textAlignment = .center
            toastLabel.text = message
            toastLabel.alpha = 1.0
            toastLabel.layer.cornerRadius = 17
            toastLabel.clipsToBounds  =  true
            if var top = UIApplication.shared.keyWindow?.rootViewController {
                while let vc = top.presentedViewController {
                    top = vc
                }
                top.view.addSubview(toastLabel)
            }
            
            // animations to hide label after 7 seconds.
            UIView.animate(withDuration: 7.0, delay: 0.1, options: .curveEaseOut, animations: {
                toastLabel.alpha = 0.0
            }, completion: {(isCompleted) in
                toastLabel.removeFromSuperview()
            })
        }
    }
}
