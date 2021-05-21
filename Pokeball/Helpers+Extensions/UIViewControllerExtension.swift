//
//  UIViewControllerExtension.swift
//  Pokeball
//
//  Created by Bryan Workman on 5/20/21.
//

import UIKit

extension UIViewController {
    
    func presentErrorToUser(localizedError: LocalizedError) {
        let alertController = UIAlertController(title: "ERROR", message: localizedError.errorDescription, preferredStyle: .actionSheet)
        let dismissAction = UIAlertAction(title: "Ok", style: .cancel)
        alertController.addAction(dismissAction)
        
        present(alertController, animated: true)
    }
    
} //End of extension
