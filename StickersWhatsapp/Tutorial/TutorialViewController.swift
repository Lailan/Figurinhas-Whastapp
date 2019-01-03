//
//  TutorialViewController.swift
//  StickersWhatsapp
//
//  Created by Lailan Rogerio Rodrigues Matos on 02/01/19.
//  Copyright © 2019 Lailan Rogerio Rodrigues Matos. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var tutorial:Array<Tutorial> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        tutorial = [Tutorial(titulo: "Bem vindo ao Figurinhas para WhatsApp", subtitulo: "Turbine suas conversas com centenas de figurinhas", background: nil, botao: ""),
                    Tutorial(titulo: "Baixe as figurinhas do momento", subtitulo: "Figurinhas de férias, fast-food, memes, orgulho, avatares, dogs e outros..", background: #imageLiteral(resourceName: "Tutorial_Fundo"), botao: ""),
                    Tutorial(titulo: "Ou crie as suas próprias!", subtitulo: "Você pode recortar, editar e compartilhar com seus amigos", background: nil, botao: ""),
                    Tutorial(titulo: "Chega de papo! Vamos nessa!", subtitulo: "", background: nil, botao: "INICIAR")]
    }
    
}

extension TutorialViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tutorial.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let celula = collectionView.dequeueReusableCell(withReuseIdentifier: "celula_tutorial", for: indexPath) as! TutorialCollectionViewCell
        celula.titulo.text = tutorial[indexPath.row].titulo
        celula.subtitulo.text = tutorial[indexPath.row].subtitulo
        celula.imagem.image = tutorial[indexPath.row].background
        if indexPath.row == 3 {
            celula.viewBotao.isHidden = false
            celula.textoBotao.setTitle(tutorial[indexPath.row].botao, for: .normal)
            celula.textoBotao.addTarget(self, action: #selector(abrirAplicativo), for: .allEvents)
        } else {
            celula.viewBotao.isHidden = true
        }
        return celula
        
    }
    
    @objc func abrirAplicativo(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "idSb_tela_principal")
        UIApplication.shared.keyWindow?.rootViewController = viewController
        UserDefaults.standard.set(true, forKey: "usuarioFinalizouTutorial")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width-10, height: UIScreen.main.bounds.height-100)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSet = scrollView.contentOffset.x
        let width = scrollView.frame.width
        let horizontalCenter = width / 2
        let numeroPagina = Int(offSet + horizontalCenter) / Int(width)
        pageControl.currentPage = numeroPagina
        if numeroPagina == 3 {
            pageControl.isHidden = true
        } else {
            pageControl.isHidden = false
        }
    }
    
}

struct Tutorial {
    
    var titulo = ""
    var subtitulo = ""
    var background:UIImage?
    var botao = ""
    
    init(titulo:String, subtitulo:String, background:UIImage?, botao:String) {
        self.titulo = titulo
        self.subtitulo = subtitulo
        self.background = background
        self.botao = botao
    }
}

