//
//  PacotesUsuario+CoreDataProperties.swift
//  StickersWhatsapp
//
//  Created by Lailan Rogerio Rodrigues Matos on 03/01/19.
//  Copyright © 2019 Lailan Rogerio Rodrigues Matos. All rights reserved.
//
//

import Foundation
import CoreData


extension PacotesUsuario {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PacotesUsuario> {
        return NSFetchRequest<PacotesUsuario>(entityName: "PacotesUsuario")
    }

    @NSManaged public var identificador: String?
    @NSManaged public var corPrimaria: String?
    @NSManaged public var corSecundaria: String?
    @NSManaged public var imagem: NSSet?

}

// MARK: Generated accessors for imagem
extension PacotesUsuario {

    @objc(addImagemObject:)
    @NSManaged public func addToImagem(_ value: ImagensUsuario)

    @objc(removeImagemObject:)
    @NSManaged public func removeFromImagem(_ value: ImagensUsuario)

    @objc(addImagem:)
    @NSManaged public func addToImagem(_ values: NSSet)

    @objc(removeImagem:)
    @NSManaged public func removeFromImagem(_ values: NSSet)

}
