//
//  FrasesTableViewController.swift
//  StickersWhatsapp
//
//  Created by Lailan Rogerio Rodrigues Matos on 14/02/19.
//  Copyright © 2019 Lailan Rogerio Rodrigues Matos. All rights reserved.
//

import UIKit

class FrasesTableViewController: UITableViewController {
    
    let frases = Frases()
    var listaFrases:[String] = []
    let imagemEnviar = UIImage(named: "paper_plane")
    let image = #imageLiteral(resourceName: "bubble_received")
    

    override func viewDidLoad() {
        super.viewDidLoad()
        listaFrases = frases.listaFrases.first!.mensagem
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaFrases.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = tableView.dequeueReusableCell(withIdentifier: "celula_frases", for: indexPath) as! FrasesTableViewCell
        celula.texto.text = listaFrases[indexPath.row]
        celula.botaoEnviar.tag = indexPath.row
        celula.botaoEnviar.addTarget(self, action: #selector(enviarMensagem(sender:)), for: .touchUpInside)
        celula.bubble.image = image.resizableImage(withCapInsets: UIEdgeInsets(top: 17, left: 21, bottom: 17, right: 21), resizingMode: .stretch) .withRenderingMode(.alwaysTemplate)
        celula.bubble.tintColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1)
        celula.imagemBotao.colorirImagem(cor: UIColor.red)
        celula.imagemBotao.tintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        return celula
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    @objc func enviarMensagem(sender: UIButton){
        let index = IndexPath(row: sender.tag, section: 0)
        let celula = tableView.cellForRow(at: index) as! FrasesTableViewCell
        let texto:String = (celula.texto.text?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
        let url = URL(string: "whatsapp://send?text=\(texto)")
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url!)
        }
    }
    
    
}






