//
//  PacotesFavoritos+CoreDataProperties.swift
//  StickersWhatsapp
//
//  Created by Lailan Rogerio Rodrigues Matos on 02/01/19.
//  Copyright © 2019 Lailan Rogerio Rodrigues Matos. All rights reserved.
//
//

import Foundation
import CoreData


extension PacotesFavoritos {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PacotesFavoritos> {
        return NSFetchRequest<PacotesFavoritos>(entityName: "PacotesFavoritos")
    }

    @NSManaged public var favorito: Bool
    @NSManaged public var identificador: String?

}
