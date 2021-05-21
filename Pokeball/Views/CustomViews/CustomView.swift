//
//  CustomView.swift
//  Pokeball
//
//  Created by Bryan Workman on 5/15/21.
//

import UIKit


class EllaView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.borderColor = #colorLiteral(red: 0.4746502042, green: 0.824804008, blue: 0.7766732574, alpha: 1)
        self.layer.borderWidth = 2
    }
} //End of class

class NathanView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.borderColor = #colorLiteral(red: 0.4740880728, green: 0.7233807445, blue: 0.9992566705, alpha: 1)
        self.layer.borderWidth = 2
    }
} //End of class

class MRBView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.borderColor = #colorLiteral(red: 0.9733943343, green: 0.9809337258, blue: 0.5477988124, alpha: 1)
        self.layer.borderWidth = 2
    }
} //End of class

