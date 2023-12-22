//
//  WuZiLeiBie+CoreDataProperties.swift
//  HFGL2022
//
//  Created by nwy on 2022/12/3.
//
//

import Foundation
import CoreData


extension WuZiLeiBie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WuZiLeiBie> {
        return NSFetchRequest<WuZiLeiBie>(entityName: "WuZiLeiBie")
    }

    @NSManaged public var beiZhu: String?
    @NSManaged public var id: UUID?
    @NSManaged public var mingCheng: String?
    @NSManaged public var suLiang: Int32
    @NSManaged public var wuZi: NSSet?

}

// MARK: Generated accessors for wuZi
extension WuZiLeiBie {

    @objc(addWuZiObject:)
    @NSManaged public func addToWuZi(_ value: WuZi)

    @objc(removeWuZiObject:)
    @NSManaged public func removeFromWuZi(_ value: WuZi)

    @objc(addWuZi:)
    @NSManaged public func addToWuZi(_ values: NSSet)

    @objc(removeWuZi:)
    @NSManaged public func removeFromWuZi(_ values: NSSet)

}

extension WuZiLeiBie : Identifiable {

}
