//
//  CameraCropController.swift
//  StickersWhatsapp
//
//  Created by Lailan Rogerio Rodrigues Matos on 28/12/18.
//  Copyright © 2018 Lailan Rogerio Rodrigues Matos. All rights reserved.
//

import Foundation
import YPImagePicker

class CameraCropController {
    
    
    func obterConfiguracoesCamera() -> YPImagePickerConfiguration {
        var configuracaoCamera = YPImagePickerConfiguration()
        configuracaoCamera.isScrollToChangeModesEnabled = true
        configuracaoCamera.onlySquareImagesFromCamera = false
        configuracaoCamera.usesFrontCamera = true
        configuracaoCamera.showsFilters = false
        configuracaoCamera.shouldSaveNewPicturesToAlbum = false
        configuracaoCamera.albumName = "DefaultYPImagePickerAlbumName"
        configuracaoCamera.screens = [.library, .photo]
        configuracaoCamera.showsCrop = .none
        configuracaoCamera.startOnScreen = .library
        configuracaoCamera.targetImageSize = YPImageSize.original
        configuracaoCamera.overlayView = UIView()
        configuracaoCamera.hidesStatusBar = true
        configuracaoCamera.hidesBottomBar = false
        configuracaoCamera.preferredStatusBarStyle = UIStatusBarStyle.default
        configuracaoCamera.bottomMenuItemSelectedColour = UIColor.darkGray
        configuracaoCamera.bottomMenuItemUnSelectedColour = UIColor.lightGray
        configuracaoCamera.library.onlySquare = true
        //config.wordings.libraryTitle = NSLocalizedString("galeria".internacionalizar(), comment: "")
        //config.wordings.cameraTitle = NSLocalizedString("camera".internacionalizar(), comment: "")
        return configuracaoCamera
    }

    
    
    func redimensionarImagem(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    
}
