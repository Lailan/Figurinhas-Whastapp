//
//  DetalhesViewController.swift
//  StickersWhatsapp
//
//  Created by Lailan Rogerio Rodrigues Matos on 21/12/18.
//  Copyright © 2018 Lailan Rogerio Rodrigues Matos. All rights reserved.
//

import UIKit
import FaveButton
import CoreData
import GoogleMobileAds

func color(_ rgbColor: Int) -> UIColor{
    return UIColor(
        red:   CGFloat((rgbColor & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbColor & 0x00FF00) >> 8 ) / 255.0,
        blue:  CGFloat((rgbColor & 0x0000FF) >> 0 ) / 255.0,
        alpha: CGFloat(1.0)
    )
}

class DetalhesViewController: UIViewController, FaveButtonDelegate, GADInterstitialDelegate{
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var imagemPrincipal: UIImageView!
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var subitulo: UILabel!
    @IBOutlet weak var adicionarAoWhatsapp: UILabel!
    @IBOutlet weak var botaoFavoritar: FaveButton!
    
    var indice = 0
    let dadosFigurinhas = Figurinhas()
    var pacoteFavorito = false
    
    var interstitial: GADInterstitial!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        imagemPrincipal.image = dadosFigurinhas.todasFigurinhas[indice].imagemFeed
        subitulo.text = dadosFigurinhas.todasFigurinhas[indice].subtitulo
        titulo.text = dadosFigurinhas.todasFigurinhas[indice].identificador
        pacoteFavorito = consultarIdentificador(identificador: dadosFigurinhas.todasFigurinhas[indice].identificador)
        self.botaoFavoritar?.setSelected(selected: pacoteFavorito, animated: false)
        interstitial = createAndLoadInterstitial()
    }
    
    func createAndLoadInterstitial() -> GADInterstitial {
        let interstitial = GADInterstitial(adUnitID: "")
        interstitial.delegate = self
        interstitial.load(GADRequest())
        return interstitial
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        interstitial = createAndLoadInterstitial()
        exportarParaWhatsapp()
    }
    
    @IBAction func botaoFavoritar(_ sender: Any) {
        if pacoteFavorito {
            pacoteFavorito = false
        } else {
            pacoteFavorito = true
        }
        self.favoritarT(identificador: self.dadosFigurinhas.todasFigurinhas[indice].identificador, favorito: pacoteFavorito)
    }
    
    
    @IBAction func botaoFechar(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func botaoEnviarWhatsapp(_ sender: Any) {
        if interstitial.isReady {
            interstitial.present(fromRootViewController: self)
        } else {
            exportarParaWhatsapp()
        }
    }
    
    func exportarParaWhatsapp(){
        guard let url = URL(string: "whatsapp://") else {
            return
        }
        if UIApplication.shared.canOpenURL(url) {
            do {
                let stickerPack = try StickerPack(identifier: dadosFigurinhas.todasFigurinhas[indice].identificador,
                                                  name: dadosFigurinhas.todasFigurinhas[indice].identificador,
                                                  publisher: dadosFigurinhas.todasFigurinhas[indice].criador,
                                                  trayImagePNGData: dadosFigurinhas.todasFigurinhas[indice].iconeBarra.pngData()!,
                                                  publisherWebsite: dadosFigurinhas.todasFigurinhas[indice].site,
                                                  privacyPolicyWebsite: dadosFigurinhas.todasFigurinhas[indice].politicaPrivacidade,
                                                  licenseAgreementWebsite: dadosFigurinhas.todasFigurinhas[indice].licensa)
                for i in 0..<dadosFigurinhas.todasFigurinhas[indice].lista.count {
                    let imagemWebp = YYCGImageCreateEncodedWebPData(dadosFigurinhas.todasFigurinhas[indice].lista[i].imagem.cgImage!, false, 0.5, 0, YYImagePreset.default)
                    let imagemWebpData:Data = imagemWebp!.takeUnretainedValue() as Data
                    try stickerPack.addSticker(imageData: imagemWebpData, type: ImageDataExtension(rawValue: "webp")!, emojis: [dadosFigurinhas.todasFigurinhas[indice].lista[i].emoji])
                }
                stickerPack.sendToWhatsApp { completed in
                    
                }
            } catch {
                print(error)
            }
        } else {
            let modalAlerta = UIAlertController(title: "Ops!", message: "Você precisa ter o WhatsApp instalado para continuar", preferredStyle: .alert)
            let entendido = UIAlertAction(title: "Entendido", style: .default, handler: nil)
            modalAlerta.addAction(entendido)
            self.show(modalAlerta, sender: nil)
        }
    }
    
    let colors = [
        DotColors(first: color(0x7DC2F4), second: color(0xE2264D)),
        DotColors(first: color(0xF8CC61), second: color(0x9BDFBA)),
        DotColors(first: color(0xAF90F4), second: color(0x90D1F9)),
        DotColors(first: color(0xE9A966), second: color(0xF8C852)),
        DotColors(first: color(0xF68FA7), second: color(0xF6A2B8))
    ]
    
    func faveButton(_ faveButton: FaveButton, didSelected selected: Bool) {
        
    }
    
    func favoritar(identificador: String, favorito:Bool) {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "PacotesFavoritos", in: managedContext)!
        let objeto = NSManagedObject(entity: entity, insertInto: managedContext)
        objeto.setValue(identificador, forKeyPath: "Identificador")
        objeto.setValue(favorito, forKey: "Favorito")
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func favoritarT(identificador: String, favorito:Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PacotesFavoritos")
        
        fetchRequest.predicate = NSPredicate(format: "identificador == %@", identificador)
        
        do {
            let results = try context.fetch(fetchRequest) as? [NSManagedObject]
            if results?.count != 0 {
                results![0].setValue(identificador, forKeyPath: "Identificador")
                results![0].setValue(favorito, forKey: "Favorito")
            } else {
                let entity = NSEntityDescription.entity(forEntityName: "PacotesFavoritos", in: context)!
                let objeto = NSManagedObject(entity: entity, insertInto: context)
                objeto.setValue(identificador, forKeyPath: "Identificador")
                objeto.setValue(favorito, forKey: "Favorito")
            }
        } catch {
            print("Fetch Failed: \(error)")
        }
        do {
            try context.save()
        }
        catch {
            print("Saving Core Data Failed: \(error)")
        }
    }
    
    
    
    func consultarIdentificador(identificador: String) -> Bool {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            let fetchRequest : NSFetchRequest<PacotesFavoritos> = PacotesFavoritos.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "identificador == %@", identificador)
            let fetchedResults = try context.fetch(fetchRequest)
            if let favorito = fetchedResults.first {
                return favorito.favorito
            }
        }
        catch {
            print ("fetch task failed", error)
        }
        return false
    }
    
    func faveButtonDotColors(_ faveButton: FaveButton) -> [DotColors]?{
        if( faveButton === botaoFavoritar || faveButton === botaoFavoritar){
            return colors
        }
        return nil
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

extension DetalhesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dadosFigurinhas.todasFigurinhas[indice].lista.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let celula = collectionView.dequeueReusableCell(withReuseIdentifier: "celula_stickers_collection", for: indexPath) as! DetalhesListaCollectionViewCell
        celula.imagem.image = dadosFigurinhas.todasFigurinhas[indice].lista[indexPath.row].imagem
        return celula
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}
