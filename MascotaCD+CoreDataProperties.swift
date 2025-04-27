//
//  MascotaCD+CoreDataProperties.swift
//  CiberVet
//
//  Created by Cristina Belen Molle Rodriguez on 27/04/25.
//
//

import Foundation
import CoreData


extension MascotaCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MascotaCD> {
        return NSFetchRequest<MascotaCD>(entityName: "MascotaCD")
    }

    @NSManaged public var nombre: String?
    @NSManaged public var urlFoto: String?
    @NSManaged public var peso: Double
    @NSManaged public var edad: Int16

}

extension MascotaCD : Identifiable {

}
