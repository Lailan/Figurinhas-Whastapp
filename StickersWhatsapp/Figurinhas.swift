//
//  Figurinhas.swift
//  StickersWhatsapp
//
//  Created by Lailan Rogerio Rodrigues Matos on 21/12/18.
//  Copyright © 2018 Lailan Rogerio Rodrigues Matos. All rights reserved.
//

import Foundation
import UIKit

struct FigurinhasCriadasUsuario {
    
    var nome = ""
    var imagens:[UIImage] = []
    var corPrimaria:UIColor!
    var corSecundaria:UIColor!
    
    init(nome:String, imagens:[UIImage], corPrimaria:UIColor, corSecundaria:UIColor) {
        self.nome = nome
        self.imagens = imagens
        self.corPrimaria = corPrimaria
        self.corSecundaria = corSecundaria
    }
}

class DadosStickers {
    
    var imagemFeed:UIImage!
    var identificador = ""
    var subtitulo = ""
    var criador = ""
    var iconeBarra:UIImage!
    var site = ""
    var politicaPrivacidade = ""
    var licensa = ""
    var lista:Array<ListaSticker> = []
    var listaImagensPreview:[UIImage] = []
    
    init(imagemFeed:UIImage, identificador:String, subtitulo:String, criador:String, iconeBarra:UIImage, site:String, politicaPrivacidade:String, licensa:String, lista:[ListaSticker]) {
        self.imagemFeed = imagemFeed
        self.identificador = identificador
        self.subtitulo = subtitulo
        self.criador = criador
        self.iconeBarra = iconeBarra
        self.site = site
        self.politicaPrivacidade = politicaPrivacidade
        self.licensa = licensa
        self.lista = lista
    }
    
}

class ListaSticker {
    
    var imagemDiretorio = ""
    var imagem:UIImage!
    var emoji = ""
    
    init(imagem:UIImage, emoji:String) {
        self.imagem = imagem
        self.emoji = emoji
    }
}


class Figurinhas {
    let todasFigurinhas:Array<DadosStickers> =
                                                [DadosStickers(imagemFeed: #imageLiteral(resourceName: "Viagem_background"), identificador: "Férias", subtitulo: "Para quem está de malas prontas!", criador: "Figurinhas para WhatsApp", iconeBarra: #imageLiteral(resourceName: "Viagem_tray.png"), site: "", politicaPrivacidade: "", licensa: "",
                                                              lista: [ListaSticker(imagem: #imageLiteral(resourceName: "Viagem_aviao.png"), emoji: ""),
                                                                      ListaSticker(imagem: #imageLiteral(resourceName: "Viagem_bussola.png"), emoji: ""),
                                                                      ListaSticker(imagem: #imageLiteral(resourceName: "Viagem_camera.png"), emoji: ""),
                                                                      ListaSticker(imagem: #imageLiteral(resourceName: "Viagem_carro.png"), emoji: ""),
                                                                      ListaSticker(imagem: #imageLiteral(resourceName: "Viagem_globo.png"), emoji: ""),
                                                                      ListaSticker(imagem: #imageLiteral(resourceName: "Viagem_localizacao.png"), emoji: ""),
                                                                      ListaSticker(imagem: #imageLiteral(resourceName: "Viagem_mala.png"), emoji: ""),
                                                                      ListaSticker(imagem: #imageLiteral(resourceName: "Viagem_passaporte.png"), emoji: ""),
                                                                      ListaSticker(imagem: #imageLiteral(resourceName: "Viagem_montanhas.png"), emoji: "")]),
                                                DadosStickers(imagemFeed: #imageLiteral(resourceName: "Food_background"), identificador: "Fastfood", subtitulo: "Amo muito tudo isso", criador: "Figurinhas para WhatsApp", iconeBarra: #imageLiteral(resourceName: "Food_tray.png"), site: "", politicaPrivacidade: "", licensa: "",
                                                              lista: [ListaSticker(imagem:  #imageLiteral(resourceName: "Food_cachorroQuente.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Food_cupcake.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Food_fritas.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Food_ketchup.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Food_pizza.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Food_refrigerante.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Food_rosquinha.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Food_rosquinha2.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Food_sanduiche.png"), emoji: "")]),
                                                DadosStickers(imagemFeed: #imageLiteral(resourceName: "Frutas_background"), identificador: "Frutas", subtitulo: "#VidaSaudável", criador: "Figurinhas para WhatsApp", iconeBarra: #imageLiteral(resourceName: "Frutas_tray.png"), site: "", politicaPrivacidade: "", licensa: "",
                                                              lista: [ListaSticker(imagem:  #imageLiteral(resourceName: "Frutas_bananas.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Frutas_berinjela.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Frutas_cereja.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Frutas_laranja.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Frutas_maça.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Frutas_morango.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Frutas_pera.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Frutas_tomate.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Frutas_uva.png"), emoji: "")]),
                                                DadosStickers(imagemFeed: #imageLiteral(resourceName: "Memes_background"), identificador: "Memes", subtitulo: "Memes da velha guarda", criador: "Figurinhas para WhatsApp", iconeBarra: #imageLiteral(resourceName: "Memes_tray.png"), site: "", politicaPrivacidade: "", licensa: "",
                                                              lista: [ListaSticker(imagem:  #imageLiteral(resourceName: "Memes_1.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Memes_2.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Memes_3.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Memes_4.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Memes_5.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Memes_6.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Memes_7.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Memes_8.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Memes_9.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Memes_10.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Memes_11.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Memes_12.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Memes_13.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Memes_14.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Memes_15.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Memes_16.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Memes_17.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Memes_18.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Memes_19.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Memes_20.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Memes_21.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Memes_22.png"), emoji: "")]),
                                                DadosStickers(imagemFeed: #imageLiteral(resourceName: "Pride_background"), identificador: "Orgulhe-se", subtitulo: "Viva a diversidade!", criador: "Figurinhas para WhatsApp", iconeBarra: #imageLiteral(resourceName: "Pride_tray.png"), site: "", politicaPrivacidade: "", licensa: "",
                                                              lista: [ListaSticker(imagem:  #imageLiteral(resourceName: "Pride_1.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Pride_2.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Pride_3.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Pride_4.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Pride_5.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Pride_6.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Pride_7.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Pride_8.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Pride_9.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Pride_10.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Pride_11.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Pride_12.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Pride_13.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Pride_14.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Pride_15.png"), emoji: "")]),
                                                DadosStickers(imagemFeed: #imageLiteral(resourceName: "Pessoas_background"), identificador: "Avatares", subtitulo: "17 figurinhas para todos os estilos", criador: "Figurinhas para WhatsApp", iconeBarra: #imageLiteral(resourceName: "Pessoas_tray.png"), site: "", politicaPrivacidade: "", licensa: "",
                                                              lista: [ListaSticker(imagem:  #imageLiteral(resourceName: "Pessoa_1.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Pessoa_2.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Pessoa_3.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Pessoa_4.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Pessoa_5.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Pessoa_6.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Pessoa_7.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Pessoa_8.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Pessoa_9.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Pessoa_10.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Pessoa_11.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Pessoa_13.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Pessoa_14.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Pessoa_15.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Pessoa_16.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Pessoa_17.png"), emoji: "")]),
                                                DadosStickers(imagemFeed: #imageLiteral(resourceName: "Dog_background"), identificador: "Dogs", subtitulo: "Such Dogs!", criador: "Figurinhas para WhatsApp", iconeBarra: #imageLiteral(resourceName: "Dog_tray.png"), site: "", politicaPrivacidade: "", licensa: "",
                                                              lista: [ListaSticker(imagem:  #imageLiteral(resourceName: "Dog_1.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Dog_2.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Dog_3.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Dog_4.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Dog_5.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Dog_6.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Dog_7.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Dog_8.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Dog_9.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Dog_10.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Dog_11.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Dog_12.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Dog_13.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Dog_14.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Dog_15.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Dog_16.png"), emoji: "")]),
                                                DadosStickers(imagemFeed: #imageLiteral(resourceName: "Poop_background"), identificador: "Poop", subtitulo: "Cocô com emoções! XD", criador: "Figurinhas para WhatsApp", iconeBarra: #imageLiteral(resourceName: "Poop_tray.png"), site: "", politicaPrivacidade: "", licensa: "",
                                                              lista: [ListaSticker(imagem:  #imageLiteral(resourceName: "Poop_1.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Poop_2.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Poop_3.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Poop_4.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Poop_5.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Poop_6.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Poop_7.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Poop_8.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Poop_9.png"), emoji: "")]),
                                                DadosStickers(imagemFeed: #imageLiteral(resourceName: "Battle_background"), identificador: "Battle Royale", subtitulo: "Lhamas, dacinhas e ônibus voadores", criador: "Figurinhas para WhatsApp", iconeBarra: #imageLiteral(resourceName: "Battle_tray.png"), site: "", politicaPrivacidade: "", licensa: "",
                                                              lista: [ListaSticker(imagem:  #imageLiteral(resourceName: "Battle_10.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Battle_1.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Battle_2.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Battle_3.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Battle_4.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Battle_5.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Battle_6.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Battle_7.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Battle_8.png"), emoji: ""),
                                                                      ListaSticker(imagem:  #imageLiteral(resourceName: "Battle_9.png"), emoji: "")])
    
    ]
}

