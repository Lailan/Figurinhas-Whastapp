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
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nomePacote {
            if (textField.text?.isEmpty)! {
                self.abrirModal()
            } else {
                textField.resignFirstResponder()
            }
            return false
        } else {
            if (textField.text?.isEmpty)! {
                self.abrirModal()
            } else {
                UserDefaults.standard.set(self.criador, forKey: "Nome_Usuario")
                self.dismiss(animated: true) {
                    if self.usuarioCilcouVoltar {
                         SwiftEventBus.post("Usuario_preencheu_nome_e_clicou_voltar", sender: [self.nome,self.criador])
                    } else {
                         SwiftEventBus.post("Usuario_preencheu_nome", sender: [self.nome,self.criador])
                    }
                }
            }
           return false
        }
    }
    
    @IBAction func nomePacoteDidEnd(_ sender: Any) {
        if !((self.nomePacote.text?.isEmpty)!) {
            self.nome = self.nomePacote.text!
        } else {
           self.abrirModal()
        }
    }
    
    @IBAction func criadoPorDidEnd(_ sender: Any) {
        if !((self.criadoPor.text?.isEmpty)!) {
            self.criador = self.criadoPor.text!
        } else {
            self.abrirModal()
        }
    }
    
    @IBAction func nomePacoteValueChanged(_ sender: Any) {
        if !((self.nomePacote.text?.isEmpty)!) {
            self.nome = self.nomePacote.text!
        }
    }
    
    @IBAction func nomePactoeEditingChanged(_ sender: Any) {
        if !((self.nomePacote.text?.isEmpty)!) {
            self.nome = self.nomePacote.text!
        } else {
            self.abrirModal()
        }
    }
    
    @IBAction func criadoPorEditingChanged(_ sender: Any) {
        if !((self.criadoPor.text?.isEmpty)!) {
            self.criador = self.criadoPor.text!
        } else {
            self.abrirModal()
        }
    }
    
    @IBAction func criadoPorValueChanged(_ sender: Any) {
        if !((self.criadoPor.text?.isEmpty)!) {
            self.criador = self.criadoPor.text!
        }
    }
    
    
    func abrirModal(){
        let modalAlerta = UIAlertController(title: "Ops!", message: "Você precisa informar um nome para continuar", preferredStyle: .alert)
        let entendido = UIAlertAction(title: "Entendido", style: .default, handler: nil)
        modalAlerta.addAction(entendido)
        self.show(modalAlerta, sender: nil)
    }
    

}
