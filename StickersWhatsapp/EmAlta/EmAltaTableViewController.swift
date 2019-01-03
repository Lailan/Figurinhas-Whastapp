//
//  EmAltaTableViewController.swift
//  StickersWhatsapp
//
//  Created by Lailan Rogerio Rodrigues Matos on 21/12/18.
//  Copyright © 2018 Lailan Rogerio Rodrigues Matos. All rights reserved.
//

import UIKit

class EmAltaTableViewController: UITableViewController {
    
    let dadosFigurinhas = Figurinhas()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return dadosFigurinhas.todasFigurinhas.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let celula = tableView.dequeueReusableCell(withIdentifier: "celula_em_alta", for: indexPath) as! EmAltaTableViewCell
            celula.titulo.text = dadosFigurinhas.todasFigurinhas[indexPath.row].identificador
            celula.subitulo.text = dadosFigurinhas.todasFigurinhas[indexPath.row].subtitulo
            celula.imagem.image = dadosFigurinhas.todasFigurinhas[indexPath.row].imagemFeed
            return celula
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 270
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let telaDetalhes = storyboard?.instantiateViewController(withIdentifier: "idSB_TelaDetalhes_Stickers") as! DetalhesViewController
        telaDetalhes.indice = indexPath.row
        DispatchQueue.main.asyncAfter(deadline: .now()) {
           self.present(telaDetalhes, animated: true, completion: nil)
        }
    }
}
