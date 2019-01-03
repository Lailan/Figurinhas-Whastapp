//
//  ImagensUsuario+CoreDataProperties.swift
//  StickersWhatsapp
//
//  Created by Lailan Rogerio Rodrigues Matos on 03/01/19.
//  Copyright © 2019 Lailan Rogerio Rodrigues Matos. All rights reserved.
//
//

import Foundation
import CoreData


extension ImagensUsuario {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ImagensUsuario> {
        return NSFetchRequest<ImagensUsuario>(entityName: "ImagensUsuario")
    }

    @NSManaged public var imagem: NSData?
    @NSManaged public var pacotes: PacotesUsuario?

}
