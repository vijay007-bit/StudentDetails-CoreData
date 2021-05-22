//
//  UICollectionView.swift
//  StudentsDetails
//
//  Created by admin on 21/05/21.
//

import Foundation
import UIKit

extension UITableView {
    
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "Times New Roman", size: 17)!
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
    }
    
    func restore() {
        self.backgroundView = nil
    }
}
