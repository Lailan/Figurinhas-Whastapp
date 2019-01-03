//
//  RevisaoViewController.swift
//  StickersWhatsapp
//
//  Created by Lailan Rogerio Rodrigues Matos on 28/12/18.
//  Copyright © 2018 Lailan Rogerio Rodrigues Matos. All rights reserved.
//

import UIKit
import SwiftEventBus

class RevisaoViewController: UIViewController {
    
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var imagem: UIImageView!
    
    var imagemCortada:UIImage!
    var imagemOriginal:UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagem.image = imagemCortada
    }
    
    @IBAction func botaoVoltar(_ sender: Any) {
        self.dismiss(animated: true) {
            SwiftEventBus.post("Usuario_nao_aceitou_foto", sender: self.imagemOriginal)
        }
    }
    
    @IBAction func botaoProsseguir(_ sender: Any) {
        self.dismiss(animated: true) {
            SwiftEventBus.post("Usuario_aceitou_foto", sender: self.imagemCortada)
        }
    }
}
