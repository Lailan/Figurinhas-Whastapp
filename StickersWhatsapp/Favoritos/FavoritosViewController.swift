//
//  FavoritosViewController.swift
//  StickersWhatsapp
//
//  Created by Lailan Rogerio Rodrigues Matos on 30/12/18.
//  Copyright © 2018 Lailan Rogerio Rodrigues Matos. All rights reserved.
//

import UIKit
import CoreData

class FavoritosViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var listaFigurinhasFavoritas:Array<DadosStickers> = []
    var figurinhas = Figurinhas()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let listaFavoritosUsuario = consultarFavoritos()
        listaFigurinhasFavoritas.removeAll()
        for i in 0..<listaFavoritosUsuario.count {
            if listaFavoritosUsuario[i].favorito {
                processarFavoritos(identificador: listaFavoritosUsuario[i].identificador!)
            }
        }
        self.tableView.reloadData()
    }
    
    func processarFavoritos(identificador:String){
        for i in 0..<figurinhas.todasFigurinhas.count {
            if figurinhas.todasFigurinhas[i].identificador == identificador {
                listaFigurinhasFavoritas.append(figurinhas.todasFigurinhas[i])
                break
            }
        }
    }
    
    func consultarFavoritos() -> [PacotesFavoritos] {
        let listaFavoritos:Array<PacotesFavoritos> = []
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            let fetchRequest : NSFetchRequest<PacotesFavoritos> = PacotesFavoritos.fetchRequest()
            let fetchedResults = try context.fetch(fetchRequest)
            return fetchedResults
        }
        catch {
            print ("fetch task failed", error)
        }
        return listaFavoritos
    }
    
    func processarIndice(identificador:String) -> Int {
        for i in 0..<figurinhas.todasFigurinhas.count {
            if figurinhas.todasFigurinhas[i].identificador == identificador {
                return i
            }
        }
        return 0
    }

    @objc func animarBotaoFavorito(){
        let index = IndexPath(row: 0, section: 0)
        let celula = self.tableView.cellForRow(at: index) as? FavoritosVazioTableViewCell
        celula?.botaoFavoritar.setSelected(selected: true, animated: true)
    }
    
}

extension FavoritosViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if listaFigurinhasFavoritas.isEmpty {
            return 1
        } else {
            return listaFigurinhasFavoritas.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if listaFigurinhasFavoritas.isEmpty {
            let celula = tableView.dequeueReusableCell(withIdentifier: "celula_favoritos_vazia", for: indexPath) as! FavoritosVazioTableViewCell
            return celula
        } else {
            let celula = tableView.dequeueReusableCell(withIdentifier: "celula_favoritos", for: indexPath) as! FavoritosCelulaTableViewCell
            celula.imagem.image = listaFigurinhasFavoritas[indexPath.row].imagemFeed
            return celula
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if listaFigurinhasFavoritas.isEmpty {
            if cell is FavoritosVazioTableViewCell {
                Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(animarBotaoFavorito), userInfo: nil, repeats: false)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !listaFigurinhasFavoritas.isEmpty {
            let telaDetalhes = storyboard?.instantiateViewController(withIdentifier: "idSB_TelaDetalhes_Stickers") as! DetalhesViewController
            telaDetalhes.indice = processarIndice(identificador: listaFigurinhasFavoritas[indexPath.row].identificador)
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                self.present(telaDetalhes, animated: true, completion: nil)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if listaFigurinhasFavoritas.isEmpty {
            return 150
        } else {
            return 200
        }
    }
    
    
    
}
