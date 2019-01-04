//
//  CriarOSeuViewController.swift
//  StickersWhatsapp
//
//  Created by Lailan Rogerio Rodrigues Matos on 27/12/18.
//  Copyright © 2018 Lailan Rogerio Rodrigues Matos. All rights reserved.
//

import UIKit
import CoreData
import SwiftEventBus
import GoogleMobileAds

class CriarOSeuViewController: UIViewController {
    
    
    @IBOutlet weak var viewBotaoIniciar: UIView!
    @IBOutlet weak var imagemGif: UIImageView!
    @IBOutlet weak var viewTexto: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var cameraController = CameraCropController()
    var listaFigurinhasCriadasPeloUsuario:[FigurinhasCriadasUsuario] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.bool(forKey: "Usuario_visualizou_tutorial") {
            self.viewBotaoIniciar.alpha = 1
            self.viewTexto.alpha = 1
            imagemGif.isHidden = true
            tableView.delegate = self
            tableView.dataSource = self
            listaFigurinhasCriadasPeloUsuario = prepararLista(consultarPacotesCriadosPeloUsuario())
            if listaFigurinhasCriadasPeloUsuario.isEmpty {
                tableView.isHidden = true
            } else {
                tableView.isHidden = false
            }
        } else {
            UserDefaults.standard.set(true, forKey: "Usuario_visualizou_tutorial")
            imagemGif.loadGif(name: "crie_o_seu_")
            self.viewBotaoIniciar.alpha = 0
            self.viewTexto.alpha = 0
            self.tableView.isHidden = true
            Timer.scheduledTimer(timeInterval: 3.5, target: self, selector: #selector(animarTexto), userInfo: nil, repeats: false)
            Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(animarBotaoIniciar), userInfo: nil, repeats: false)
        }
        SwiftEventBus.onMainThread(self, name:"Recarregar_tabela") { result in
            self.listaFigurinhasCriadasPeloUsuario = self.prepararLista(self.consultarPacotesCriadosPeloUsuario())
            if self.listaFigurinhasCriadasPeloUsuario.isEmpty {
                self.viewBotaoIniciar.alpha = 1
                self.viewTexto.alpha = 1
                self.tableView.isHidden = true
            } else {
                self.viewTexto.alpha = 0
                self.tableView.isHidden = false
            }
            self.tableView.reloadData()
        }
    }
    
    func prepararLista(_ pacotesUsuarios:[PacotesUsuario]) -> [FigurinhasCriadasUsuario]{
        var listaDeFigurinhasUsuario:[FigurinhasCriadasUsuario] = []
        for i in 0..<pacotesUsuarios.count {
            var listaImagens:[UIImage] = []
            let arry = pacotesUsuarios[i].imagem?.allObjects as! [ImagensUsuario]
            for a in 0..<arry.count {
                listaImagens.append(UIImage(data: arry[a].imagem!)!)
            }
            listaDeFigurinhasUsuario.append(FigurinhasCriadasUsuario(nome: (pacotesUsuarios[i].identificador)!, imagens: listaImagens, corPrimaria: UIColor(hexString: pacotesUsuarios[i].corPrimaria!), corSecundaria: UIColor(hexString: pacotesUsuarios[i].corSecundaria!)))
        }
        return listaDeFigurinhasUsuario
    }
    
    
    func noPhotos() {
        
    }
    
    @objc func animarTexto() {
        self.imagemGif.image = nil
        UIView.animate(withDuration: 0.8) {
            self.viewTexto.alpha = 1
        }
    }
    
    @objc func animarBotaoIniciar() {
        self.imagemGif.image = nil
        UIView.animate(withDuration: 0.8) {
            self.viewBotaoIniciar.alpha = 1
        }
    }
    
    @IBAction func botaoIniciar(_ sender: Any) {
        let criarViewController = storyboard?.instantiateViewController(withIdentifier: "idSb_criando_meu_pacote") as! UsuarioCriandoViewController
        self.present(criarViewController, animated: true, completion: nil)
        
    }
    
    func consultarPacotesCriadosPeloUsuario() -> [PacotesUsuario] {
        let listaUsuario:Array<PacotesUsuario> = []
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            let fetchRequest : NSFetchRequest<PacotesUsuario> = PacotesUsuario.fetchRequest()
            let fetchedResults = try context.fetch(fetchRequest)
            return fetchedResults
        }
        catch {
            print ("fetch task failed", error)
        }
        return listaUsuario
    }
    
   
}

extension CriarOSeuViewController : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaFigurinhasCriadasPeloUsuario.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = tableView.dequeueReusableCell(withIdentifier: "celula_lista_criada_usuario", for: indexPath) as! ListaCriadaPeloUsuarioTableViewCell
        celula.nome.text = listaFigurinhasCriadasPeloUsuario[indexPath.row].nome
        celula.processarLista(listaFigurinhasCriadasPeloUsuario[indexPath.row].imagens)
//        celula.viewGradiente.topColor = listaFigurinhasCriadasPeloUsuario[indexPath.row].corPrimaria
//        celula.viewGradiente.bottomColor = listaFigurinhasCriadasPeloUsuario[indexPath.row].corSecundaria
        celula.collectionView.reloadData()
        return celula
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let criarViewController = storyboard?.instantiateViewController(withIdentifier: "idSb_criando_meu_pacote") as! UsuarioCriandoViewController
        criarViewController.listaImagensUsuario = listaFigurinhasCriadasPeloUsuario[indexPath.row].imagens
        criarViewController.nome = listaFigurinhasCriadasPeloUsuario[indexPath.row].nome
        DispatchQueue.main.async {
            self.present(criarViewController, animated: true, completion: nil)
        }
        
    }
    
}

