//
//  SobreViewController.swift
//  StickersWhatsapp
//
//  Created by Lailan Rogerio Rodrigues Matos on 30/12/18.
//  Copyright © 2018 Lailan Rogerio Rodrigues Matos. All rights reserved.
//

import UIKit
import StoreKit

class SobreViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var listaSobre:[Sobre] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        listaSobre = popularSobre()
    }
    
    func popularSobre() -> [Sobre] {
        var listaSobre:Array<Sobre> = []
        listaSobre = [Sobre(texto: "Obrigado por baixar o Figurinhas para WhatsApp! Esse aplicativo foi feito com o intuito de ter sua usabilidade focada no usuário.  Prezamos a qualidade e sua diversão enquanto utiliza o app!", tipo: .texto, descricaoBotao: ""),
                      Sobre(texto: "Gostou do aplicativo?", tipo: .botao, descricaoBotao: "AVALIAR"),
                      Sobre(texto: "Encontrou algum bug?", tipo: .botao, descricaoBotao: "REPORTAR"),
                      Sobre(texto: "Compartilhar app", tipo: .botao, descricaoBotao: "ENVIAR"),
                      Sobre(texto: "Criador", tipo: .botao, descricaoBotao: "LINKEDIN")]
        return listaSobre
    }
    
}

extension SobreViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaSobre.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch listaSobre[indexPath.row].tipo {
        case .texto?:
            let celula = tableView.dequeueReusableCell(withIdentifier: "celula_sobre_texto", for: indexPath) as! SobreTableViewCell
            celula.texto.text = listaSobre[indexPath.row].texto
            return celula
        default:
            let celula = tableView.dequeueReusableCell(withIdentifier: "celula_sobre_botao", for: indexPath) as! SobreComBotaoTableViewCell
            celula.texto.text = listaSobre[indexPath.row].texto
            //celula.textoBotao.text = listaSobre[indexPath.row].descricaoBotao
            return celula
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch listaSobre[indexPath.row].tipo {
        case .texto?:
            return 200
        default:
            return 80
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 1:
            SKStoreReviewController.requestReview()
        case 2:
            let email = "lailan@me.com"
            if let url = URL(string: "mailto:\(email)") {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        case 3:
            let firstActivityItem = "Baixa na AppStore o aplicativo Figurinhas para Whatsapp!"
            let secondActivityItem : NSURL = NSURL(string: "http//:urlyouwant")!
            let image = #imageLiteral(resourceName: "Viagem_background")
            let activityViewController : UIActivityViewController = UIActivityViewController(
                activityItems: [firstActivityItem, secondActivityItem, image], applicationActivities: nil)
            activityViewController.excludedActivityTypes = [
                UIActivity.ActivityType.postToWeibo,
                UIActivity.ActivityType.print,
                UIActivity.ActivityType.assignToContact,
                UIActivity.ActivityType.saveToCameraRoll,
                UIActivity.ActivityType.addToReadingList,
                UIActivity.ActivityType.postToFlickr,
                UIActivity.ActivityType.postToVimeo,
                UIActivity.ActivityType.postToTencentWeibo
            ]
            
            self.present(activityViewController, animated: true, completion: nil)
        case 4:
            let url = URL(string: "https://www.linkedin.com/in/lailan-matos-776b99168/")
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url!)
            } else {
                UIApplication.shared.openURL(url!)
            }
        default:
            break
        }
    }
    
    
}

class Sobre {
    
    var texto = ""
    var tipo:TipoEnum!
    var descricaoBotao = ""
    
    init(texto:String, tipo:TipoEnum, descricaoBotao:String) {
        self.texto = texto
        self.tipo = tipo
        self.descricaoBotao = descricaoBotao
    }
    
}

enum TipoEnum {
    case texto, botao
}
