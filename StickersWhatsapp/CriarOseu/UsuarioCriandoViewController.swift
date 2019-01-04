//
//  UsuarioCriandoViewController.swift
//  StickersWhatsapp
//
//  Created by Lailan Rogerio Rodrigues Matos on 28/12/18.
//  Copyright © 2018 Lailan Rogerio Rodrigues Matos. All rights reserved.
//

import UIKit
import TCMask
import YPImagePicker
import SwiftEventBus
import CoreData
import GoogleMobileAds

class UsuarioCriandoViewController: UIViewController, TCMaskViewDelegate, YPImagePickerDelegate, GADInterstitialDelegate {
    
    var listaImagensUsuario:Array<UIImage> = []
    var cameraController = CameraCropController()
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var viewContinuar: UIView!
    
    var nome = ""
    var criador = ""
    var interstitial: GADInterstitial!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        viewContinuar.alpha = 0
        aguardandoEventos()
        self.validarSePodeContinuar(quantidadeFotos: self.listaImagensUsuario.count)
        interstitial = createAndLoadInterstitial()
    }
    
    func createAndLoadInterstitial() -> GADInterstitial {
        let interstitial = GADInterstitial(adUnitID: "ca-app-pub-9256224221848252/8152155719")
        interstitial.delegate = self
        interstitial.load(GADRequest())
        return interstitial
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        interstitial = createAndLoadInterstitial()
        abrirTelaPreencherNome(usuarioClicouVoltar:false)
    }
    
    func aguardandoEventos(){
        SwiftEventBus.onMainThread(self, name:"Usuario_aceitou_foto") { result in
            let imagem : UIImage = result!.object as! UIImage
            let imagemRedimensionada = self.resizeImage(image:imagem, size: 512)
            self.listaImagensUsuario.append(imagemRedimensionada)
            self.collectionView.reloadData()
            self.validarSePodeContinuar(quantidadeFotos: self.listaImagensUsuario.count)
        }
        SwiftEventBus.onMainThread(self, name:"Usuario_nao_aceitou_foto") { result in
            let imagem : UIImage = result!.object as! UIImage
            self.abrirRecorte(imagem)
        }
        SwiftEventBus.onMainThread(self, name:"Usuario_preencheu_nome") { result in
            let dados  = result!.object as! [String]
            self.nome = dados[0]
            self.criador = dados[1]
            self.adicionarAoWhatsapp(lista: self.listaImagensUsuario)
        }
        SwiftEventBus.onMainThread(self, name:"Usuario_preencheu_nome_e_clicou_voltar") { result in
            let dados  = result!.object as! [String]
            self.nome = dados[0]
            self.criador = dados[1]
            self.apagarDoBancoDeDados(identificador: self.nome)
            self.gravarNoBancoDeDados(identificador: self.nome, imagensEditadas: self.listaImagensUsuario)
            self.dismiss(animated: true, completion: {
                SwiftEventBus.post("Recarregar_tabela")
            })
            
        }
    }
    
    func gravarNoBancoDeDados(identificador: String, imagensEditadas:[UIImage]) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PacotesUsuario")
        fetchRequest.predicate = NSPredicate(format: "identificador == %@", identificador)
        let pacoteUsuario = PacotesUsuario(context: context)
        pacoteUsuario.identificador = identificador
        pacoteUsuario.corPrimaria = self.processarCores((imagensEditadas.first?.getColors())!, tipo: 0)
        pacoteUsuario.corSecundaria = self.processarCores((imagensEditadas.first?.getColors())!, tipo: 1)
        for i in 0..<imagensEditadas.count{
            let imagemUsuario = ImagensUsuario(context: context)
            imagemUsuario.imagem = imagensEditadas[i].pngData()
            pacoteUsuario.addToImagem(imagemUsuario)
        }
        do {
            try context.save()
        }
        catch {
            print("Saving Core Data Failed: \(error)")
        }
    }
    
    func apagarDoBancoDeDados(identificador:String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PacotesUsuario")
        fetchRequest.predicate = NSPredicate(format: "identificador == %@", identificador)
        if let result = try? context.fetch(fetchRequest) {
            for object in result {
                context.delete(object as! NSManagedObject)
            }
        }
        do {
            try context.save()
        }
        catch {
            print("Saving Core Data Failed: \(error)")
        }
    }
    
    func processarCores(_ cores:UIImageColors, tipo: Int) -> String {
        if tipo == 0 {
            return cores.background.toHexString()
        } else {
            return cores.primary.toHexString()
        }
    }
    
    func resizeImage(image: UIImage, size:CGFloat) -> UIImage {
        if image.size.height >= size && image.size.width >= size {
            UIGraphicsBeginImageContext(CGSize(width:size, height:size))
            image.draw(in: CGRect(x:0, y:0, width:size, height:size))
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return newImage!
        } else if image.size.height >= size && image.size.width < size {
            UIGraphicsBeginImageContext(CGSize(width:image.size.width, height:size))
            image.draw(in: CGRect(x:0, y:0, width:image.size.width, height:size))
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return newImage!
        } else if image.size.width >= size && image.size.height < size {
            UIGraphicsBeginImageContext(CGSize(width:size, height:image.size.height))
            image.draw(in: CGRect(x:0, y:0, width:size, height:image.size.height))
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return newImage!
        } else {
            return image
        }
    }
    
    
    func noPhotos() {
        
    }
    
    @IBAction func botaoVoltar(_ sender: Any) {
        if !self.listaImagensUsuario.isEmpty {
            let modal = UIAlertController(title: "Atenção", message: "Deseja salvar o seu progresso para continuar depois?", preferredStyle: .actionSheet)
            let acaoRemover = UIAlertAction(title: "Salvar as figurinhas", style: .default) { (action) in
                self.abrirTelaPreencherNome(usuarioClicouVoltar:true)
            }
            let acaoApagar = UIAlertAction(title: "Apagar as figurinhas", style: .destructive) { (action) in
                self.dismiss(animated: true, completion: nil)
                self.apagarDoBancoDeDados(identificador: self.nome)
                SwiftEventBus.post("Recarregar_tabela")
            }
            let acaoCancelar = UIAlertAction(title: "Cancelar", style: .cancel) { (action) in
                
            }
            modal.addAction(acaoRemover)
            modal.addAction(acaoApagar)
            modal.addAction(acaoCancelar)
            self.present(modal, animated: true, completion: nil)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    @IBAction func botaoAdicionar(_ sender: Any) {
        guard let url = URL(string: "whatsapp://") else {
            return
        }
        if UIApplication.shared.canOpenURL(url) {
            let picker = YPImagePicker(configuration: cameraController.obterConfiguracoesCamera())
            picker.didFinishPicking { [unowned picker] items, _ in
                picker.dismiss(animated: true, completion: {
                    if let photo = items.singlePhoto {
                        if photo.modifiedImage != nil {
                            self.abrirRecorte(photo.modifiedImage!)
                        } else {                        self.abrirRecorte( photo.originalImage)
                        }
                    }
                })
            }
            present(picker, animated: true, completion: nil)
        } else {
            let modalAlerta = UIAlertController(title: "Ops!", message: "Você precisa ter o WhatsApp instalado para continuar", preferredStyle: .alert)
            let entendido = UIAlertAction(title: "Entendido", style: .default, handler: nil)
            modalAlerta.addAction(entendido)
            self.show(modalAlerta, sender: nil)
        }
    }
    
    
    @IBAction func botaoFinalizar(_ sender: Any) {
        if interstitial.isReady {
            interstitial.present(fromRootViewController: self)
        } else {
            abrirTelaPreencherNome(usuarioClicouVoltar:false)
        }
    }
    
    func abrirTelaPreencherNome(usuarioClicouVoltar:Bool){
        let telaSolicitarNome = self.storyboard?.instantiateViewController(withIdentifier: "idSB_preencher_nome") as! PreencherNomeViewController
        telaSolicitarNome.nome = self.nome
        telaSolicitarNome.usuarioCilcouVoltar = usuarioClicouVoltar
        self.present(telaSolicitarNome, animated: false, completion: nil)
    }
    
    
    func adicionarAoWhatsapp(lista:[UIImage]){
        do {
            let stickerPack = try StickerPack(identifier: self.nome,
                                              name: self.nome,
                                              publisher: self.criador,
                                              trayImagePNGData: self.resizeImage(image: lista[0], size: 96).pngData()!,
                                              publisherWebsite: "",
                                              privacyPolicyWebsite: "",
                                              licenseAgreementWebsite: "")
            for i in 0..<lista.count {
                let imagemWebp = YYCGImageCreateEncodedWebPData(lista[i].cgImage!, false, 0.3, 0, YYImagePreset.default)
                let imagemWebpData:Data = imagemWebp!.takeUnretainedValue() as Data
                try stickerPack.addSticker(imageData: imagemWebpData, type: ImageDataExtension(rawValue: "webp")!, emojis: [""])
            }
            stickerPack.sendToWhatsApp { completed in
                
            }
        } catch {
            let modal = UIAlertController(title: "Ops!", message: "Não foi possível gerar as figurinhas devido ao erro: \n\(error)", preferredStyle: .alert)
            let acaoRemover = UIAlertAction(title: "Entendido", style: .default) { (action) in
            }
            modal.addAction(acaoRemover)
            self.present(modal, animated: true, completion: nil)
        }
    }
    
    func abrirRecorte(_ imagem:UIImage) {
        TCMaskView.localizationDictionary = [
            "en": ["Quick Select" : "Seleção Rápida",
                   "Hair Brush" : "Cabelos",
                   "Brush" : "Pincel",
                   "Add" : "Adicionar",
                   "Subtract" : "Remover",
                   "Setting" : "Config",
                   "Invert" : "Inverter",
                   "Brush size" : "Tamanho do Pincel",
                   "Hardness" : "Dureza",
                   "Opacity" : "Opacidade",
                   "Tips-Draw" : "Desenhe nos lugares para selecionar ou apagar",
                   "Tips-Zoom" : "Pinça para aproximar e refinar os detalhes",
                   "Tips-Move" : "Use os dois dedos para mover a tela"]
        ]
        let maskView = TCMaskView(image: imagem)
        maskView.delegate = self
        let viewMode =  TCMaskViewMode(foregroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.6), backgroundImage: nil, isInverted: true)
        maskView.viewModes = [viewMode]
        maskView.presentFrom(rootViewController: self, animated: true)
    }
    
    
    
    func tcMaskViewDidComplete(mask: TCMask, image: UIImage) {
        let imagem = mask.cutout(image: image, resize: false)
        let revisaoViewController = storyboard?.instantiateViewController(withIdentifier: "idSb_revisao") as! RevisaoViewController
        revisaoViewController.imagemCortada = imagem!
        revisaoViewController.imagemOriginal = image
        self.present(revisaoViewController, animated: true, completion: nil)
    }
    
    func validarSePodeContinuar(quantidadeFotos:Int) {
        if quantidadeFotos >= 3 && quantidadeFotos <= 30 {
            UIView.animate(withDuration: 0.5) {
                self.viewContinuar.alpha = 1
            }
        } else {
            UIView.animate(withDuration: 0.5) {
                self.viewContinuar.alpha = 0
            }
        }
    }
    
    /// Tells the delegate an ad request succeeded.
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        print("interstitialDidReceiveAd")
    }
    
    /// Tells the delegate an ad request failed.
    func interstitial(_ ad: GADInterstitial, didFailToReceiveAdWithError error: GADRequestError) {
        print("interstitial:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    /// Tells the delegate that an interstitial will be presented.
    func interstitialWillPresentScreen(_ ad: GADInterstitial) {
        print("interstitialWillPresentScreen")
    }
    
    /// Tells the delegate the interstitial is to be animated off the screen.
    func interstitialWillDismissScreen(_ ad: GADInterstitial) {
        print("interstitialWillDismissScreen")
    }
    
    
    /// Tells the delegate that a user click will open another app
    /// (such as the App Store), backgrounding the current app.
    func interstitialWillLeaveApplication(_ ad: GADInterstitial) {
        print("interstitialWillLeaveApplication")
    }
    
    
}

extension UsuarioCriandoViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listaImagensUsuario.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let celula = collectionView.dequeueReusableCell(withReuseIdentifier: "celula_figurinhas_usuario", for: indexPath) as! DetalhesListaCollectionViewCell
        celula.imagem.image = listaImagensUsuario[indexPath.row]
        return celula
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let modal = UIAlertController(title: "Atenção", message: "Deseja remover a figurinha?", preferredStyle: .actionSheet)
        let acaoRemover = UIAlertAction(title: "Remover", style: .destructive) { (action) in
            self.listaImagensUsuario.remove(at: indexPath.row)
            self.collectionView.reloadData()
            self.validarSePodeContinuar(quantidadeFotos: self.listaImagensUsuario.count)
        }
        let acaoCancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        modal.addAction(acaoRemover)
        modal.addAction(acaoCancelar)
        self.present(modal, animated: true, completion: nil)
        
    }
}
