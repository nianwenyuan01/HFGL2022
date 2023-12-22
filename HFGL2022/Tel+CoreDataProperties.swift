//
//  Tel+CoreDataProperties.swift
//  HFGL2022
//
//  Created by nwy on 2022/12/3.
//
//

import Foundation
import CoreData


extension Tel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tel> {
        return NSFetchRequest<Tel>(entityName: "Tel")
    }

    @NSManaged public var haoMa: String?
    @NSManaged public var id: UUID?
    @NSManaged public var leiXing: String?
    @NSManaged public var xingMing: String?
    @NSManaged public var renYuan: RenYuan?
    //    包装器
    public var wHaoMa: String{
        haoMa ?? "Unknown Tel"
    }
}

extension Tel : Identifiable {

}
