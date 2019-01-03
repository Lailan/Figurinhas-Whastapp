//
//  ListaCriadaPeloUsuarioTableViewCell.swift
//  StickersWhatsapp
//
//  Created by Lailan Rogerio Rodrigues Matos on 02/01/19.
//  Copyright © 2019 Lailan Rogerio Rodrigues Matos. All rights reserved.
//

import UIKit

class ListaCriadaPeloUsuarioTableViewCell: UITableViewCell {

    @IBOutlet weak var nome: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var viewGradiente: GradientView!
    
    override func awakeFromNib() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    var listaImagens:[UIImage]!
    
    func processarLista(_ lista:[UIImage]) {
        self.listaImagens = lista
        self.collectionView.reloadData()
    }
}

extension ListaCriadaPeloUsuarioTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listaImagens.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let celula = collectionView.dequeueReusableCell(withReuseIdentifier: "celula_pacotes_criados_pelo_usuario", for: indexPath) as! ListaCriadaPeloUsuarioCollectionViewCell
        celula.imagem.image = listaImagens[indexPath.row]
        return celula
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
    
    
}
