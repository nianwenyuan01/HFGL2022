//
//  WuZi+CoreDataProperties.swift
//  HFGL2022
//
//  Created by nwy on 2022/12/17.
//
//

import Foundation
import CoreData


extension WuZi {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WuZi> {
        return NSFetchRequest<WuZi>(entityName: "WuZi")
    }

    @NSManaged public var baoXiuQi: Date?
    @NSManaged public var baoZhiQi: Date?
    @NSManaged public var bianHao: String?
    @NSManaged public var cheJiaHao: String?
    @NSManaged public var paiHaoMa: String?
    @NSManaged public var paiGuiShuDi: String?
    @NSManaged public var nengYuanLeiBie: String?
    @NSManaged public var caiGouDi: String?
    @NSManaged public var cunFangWeiZhi: String?
    @NSManaged public var danJia: Int32
    @NSManaged public var danWei: String?
    @NSManaged public var guiGe: String?
    @NSManaged public var id: UUID?
    @NSManaged public var mingCheng: String?
    @NSManaged public var pinPai: String?
    @NSManaged public var quanXin: Bool
    @NSManaged public var shiFouYouKu: Bool
    @NSManaged public var ruKuShiJian: Date?
    @NSManaged public var suLiang: Int32
    @NSManaged public var tuPian: String?
    @NSManaged public var baoXiu: Bool
    @NSManaged public var baoZhi: Bool
    @NSManaged public var caiGouRen: RenYuan?
    @NSManaged public var leiBie: WuZiLeiBie?
    @NSManaged public var liuShui: NSSet?
    @NSManaged public var renYuan: RenYuan?
    @NSManaged public var xiangMu: XiangMu?
//    包装器
    public var wName: String{
        mingCheng ?? "Unknown Name"
    }


}

// MARK: Generated accessors for liuShui
extension WuZi {

    @objc(addLiuShuiObject:)
    @NSManaged public func addToLiuShui(_ value: LiuShui)

    @objc(removeLiuShuiObject:)
    @NSManaged public func removeFromLiuShui(_ value: LiuShui)

    @objc(addLiuShui:)
    @NSManaged public func addToLiuShui(_ values: NSSet)

    @objc(removeLiuShui:)
    @NSManaged public func removeFromLiuShui(_ values: NSSet)

}

extension WuZi : Identifiable {

}
