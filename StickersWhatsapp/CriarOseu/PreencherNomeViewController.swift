//
//  PreencherNomeViewController.swift
//  StickersWhatsapp
//
//  Created by Lailan Rogerio Rodrigues Matos on 30/12/18.
//  Copyright © 2018 Lailan Rogerio Rodrigues Matos. All rights reserved.
//

import UIKit
import SwiftEventBus

class PreencherNomeViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nomePacote: UITextField!
    @IBOutlet weak var criadoPor: UITextField!
    
    var nome = ""
    var criador = ""
    var usuarioCilcouVoltar = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nomePacote.delegate = self
        criadoPor.delegate = self
        criadoPor.text = UserDefaults.standard.string(forKey: "Nome_Usuario")
        nomePacote.text = nome
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    func abrirModal(){
        let modalAlerta = UIAlertController(title: "Ops!", message: "Você precisa informar um nome para continuar", preferredStyle: .alert)
        let entendido = UIAlertAction(title: "Entendido", style: .default, handler: nil)
        modalAlerta.addAction(entendido)
        self.show(modalAlerta, sender: nil)
    }
    
    @IBAction func botaoGravar(_ sender: Any) {
        if (nomePacote.text?.isEmpty)! {
            self.abrirModal()
        } else {
            if !(criadoPor.text?.isEmpty)! {
                self.criador = criadoPor.text!
            } else {
                self.criador = "Figurinhas Whatsapp"
            }
            self.nome = nomePacote.text!
            UserDefaults.standard.set(self.criador, forKey: "Nome_Usuario")
            self.dismiss(animated: true) {
                if self.usuarioCilcouVoltar {
                    SwiftEventBus.post("Usuario_preencheu_nome_e_clicou_voltar", sender: [self.nome,self.criador])
                } else {
                    SwiftEventBus.post("Usuario_preencheu_nome", sender: [self.nome,self.criador])
                }
            }
        }
        
    }
    
    

}
