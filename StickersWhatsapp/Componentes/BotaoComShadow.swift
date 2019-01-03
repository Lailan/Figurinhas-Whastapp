//
//  BotaoComShadow.swift
//  StickersWhatsapp
//
//  Created by Lailan Rogerio Rodrigues Matos on 27/12/18.
//  Copyright © 2018 Lailan Rogerio Rodrigues Matos. All rights reserved.
//

import Foundation
import UIKit

class BotaoComShadow: UIButton {
    
    override func draw(_ rect: CGRect) {
        updateLayerProperties()
    }
    
    func updateLayerProperties() {
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 10.0
        self.layer.masksToBounds = false
    }
    
}
