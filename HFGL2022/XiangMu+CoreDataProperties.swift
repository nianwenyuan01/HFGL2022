//
//  XiangMu+CoreDataProperties.swift
//  HFGL2022
//
//  Created by nwy on 2022/12/15.
//
//

import Foundation
import CoreData


extension XiangMu {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<XiangMu> {
        return NSFetchRequest<XiangMu>(entityName: "XiangMu")
    }

    @NSManaged public var beiZhu: String?
    @NSManaged public var id: UUID?
    @NSManaged public var mingCheng: String?
    @NSManaged public var renSu: Int32
    @NSManaged public var renYuan: NSSet?
    @NSManaged public var wuZi: NSSet?
    @NSManaged public var liuShui: NSSet?

//    Array包装器
    public var renYuanArray: [RenYuan] {
        let set = renYuan as? Set<RenYuan> ?? []
        return set.sorted(by: {$0.wName < $1.wName})
    }
}

// MARK: Generated accessors for renYuan
extension XiangMu {

    @objc(addRenYuanObject:)
    @NSManaged public func addToRenYuan(_ value: RenYuan)

    @objc(removeRenYuanObject:)
    @NSManaged public func removeFromRenYuan(_ value: RenYuan)

    @objc(addRenYuan:)
    @NSManaged public func addToRenYuan(_ values: NSSet)

    @objc(removeRenYuan:)
    @NSManaged public func removeFromRenYuan(_ values: NSSet)
//    包装器
    public var wName: String{
        mingCheng ?? "Unknown Name"
    }

}

// MARK: Generated accessors for wuZi
extension XiangMu {

    @objc(addWuZiObject:)
    @NSManaged public func addToWuZi(_ value: WuZi)

    @objc(removeWuZiObject:)
    @NSManaged public func removeFromWuZi(_ value: WuZi)

    @objc(addWuZi:)
    @NSManaged public func addToWuZi(_ values: NSSet)

    @objc(removeWuZi:)
    @NSManaged public func removeFromWuZi(_ values: NSSet)

}

// MARK: Generated accessors for liuShui
extension XiangMu {

    @objc(addLiuShuiObject:)
    @NSManaged public func addToLiuShui(_ value: LiuShui)

    @objc(removeLiuShuiObject:)
    @NSManaged public func removeFromLiuShui(_ value: LiuShui)

    @objc(addLiuShui:)
    @NSManaged public func addToLiuShui(_ values: NSSet)

    @objc(removeLiuShui:)
    @NSManaged public func removeFromLiuShui(_ values: NSSet)

}

extension XiangMu : Identifiable {

}
