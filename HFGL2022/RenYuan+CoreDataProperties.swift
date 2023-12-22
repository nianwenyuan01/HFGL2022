//
//  RenYuan+CoreDataProperties.swift
//  HFGL2022
//
//  Created by nwy on 2022/12/3.
//
//

import Foundation
import CoreData


extension RenYuan {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RenYuan> {
        return NSFetchRequest<RenYuan>(entityName: "RenYuan")
    }

    @NSManaged public var baoXian: Bool
    @NSManaged public var baoXianRiQi: Date?
    @NSManaged public var beiZhu: String?
    @NSManaged public var chuShengRiQi: Date?
    @NSManaged public var gongZi: Int16
    @NSManaged public var hunYin: Bool
    @NSManaged public var id: UUID?
    @NSManaged public var jiaZhao: String?
    @NSManaged public var liZhiYuanYin: String?
    @NSManaged public var nianLing: Int16
    @NSManaged public var ruZhiShiJian: Date?
    @NSManaged public var shenFenZheng: String?
    @NSManaged public var wenHua: String?
    @NSManaged public var xingBie: Bool
    @NSManaged public var xingMing: String?
    @NSManaged public var zaiZhi: Bool
    @NSManaged public var zaoPian: String?
    @NSManaged public var zhuZhi: String?
    @NSManaged public var caiGouWu: NSSet?
    @NSManaged public var tel: NSSet?
    @NSManaged public var wuZi: NSSet?
    @NSManaged public var xiangMU: NSSet?
    @NSManaged public var zhiWu: ZhiWu?
    @NSManaged public var liuShui: NSSet?
    @NSManaged public var baoXianShiChang: Int16
    //    包装器
    public var wName: String{
        xingMing ?? "Unknown Name"
    }
//    Array包装器
    public var wuZiArray: [WuZi] {
        let set = wuZi as? Set<WuZi> ?? []
        return set.sorted(by: {$0.wName < $1.wName})
    }
    public var xiangMuArray: [XiangMu] {
        let set = xiangMU as? Set<XiangMu> ?? []
        return set.sorted(by: {$0.wName < $1.wName})
    }
    public var telArray: [Tel] {
        let set = tel as? Set<Tel> ?? []
        return set.sorted(by: {$0.wHaoMa < $1.wHaoMa})
    }
    public var liuShuiArray: [LiuShui] {
        let set = liuShui as? Set<LiuShui> ?? []
        return set.sorted(by: {$0.riQiShiJian! > $1.riQiShiJian!})
    }
}

// MARK: Generated accessors for caiGouWu
extension RenYuan {

    @objc(addCaiGouWuObject:)
    @NSManaged public func addToCaiGouWu(_ value: WuZi)

    @objc(removeCaiGouWuObject:)
    @NSManaged public func removeFromCaiGouWu(_ value: WuZi)

    @objc(addCaiGouWu:)
    @NSManaged public func addToCaiGouWu(_ values: NSSet)

    @objc(removeCaiGouWu:)
    @NSManaged public func removeFromCaiGouWu(_ values: NSSet)

}

// MARK: Generated accessors for tel
extension RenYuan {

    @objc(addTelObject:)
    @NSManaged public func addToTel(_ value: Tel)

    @objc(removeTelObject:)
    @NSManaged public func removeFromTel(_ value: Tel)

    @objc(addTel:)
    @NSManaged public func addToTel(_ values: NSSet)

    @objc(removeTel:)
    @NSManaged public func removeFromTel(_ values: NSSet)

}

// MARK: Generated accessors for wuZi
extension RenYuan {

    @objc(addWuZiObject:)
    @NSManaged public func addToWuZi(_ value: WuZi)

    @objc(removeWuZiObject:)
    @NSManaged public func removeFromWuZi(_ value: WuZi)

    @objc(addWuZi:)
    @NSManaged public func addToWuZi(_ values: NSSet)

    @objc(removeWuZi:)
    @NSManaged public func removeFromWuZi(_ values: NSSet)

}

// MARK: Generated accessors for xiangMU
extension RenYuan {

    @objc(addXiangMUObject:)
    @NSManaged public func addToXiangMU(_ value: XiangMu)

    @objc(removeXiangMUObject:)
    @NSManaged public func removeFromXiangMU(_ value: XiangMu)

    @objc(addXiangMU:)
    @NSManaged public func addToXiangMU(_ values: NSSet)

    @objc(removeXiangMU:)
    @NSManaged public func removeFromXiangMU(_ values: NSSet)

}

// MARK: Generated accessors for liuShui
extension RenYuan {

    @objc(addLiuShuiObject:)
    @NSManaged public func addToLiuShui(_ value: LiuShui)

    @objc(removeLiuShuiObject:)
    @NSManaged public func removeFromLiuShui(_ value: LiuShui)

    @objc(addLiuShui:)
    @NSManaged public func addToLiuShui(_ values: NSSet)

    @objc(removeLiuShui:)
    @NSManaged public func removeFromLiuShui(_ values: NSSet)

}

extension RenYuan : Identifiable {

}
