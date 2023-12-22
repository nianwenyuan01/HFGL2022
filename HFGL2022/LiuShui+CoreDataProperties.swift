//
//  LiuShui+CoreDataProperties.swift
//  HFGL2022
//
//  Created by nwy on 2022/12/16.
//
//

import Foundation
import CoreData


extension LiuShui {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LiuShui> {
        return NSFetchRequest<LiuShui>(entityName: "LiuShui")
    }

    @NSManaged public var beiZhu: String?
    @NSManaged public var guiHuan: Bool
    @NSManaged public var guiHuanRiQi: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var leiBie: String?
    @NSManaged public var qianXiangMu: String?
    @NSManaged public var qianZhiWu: String?
    @NSManaged public var riQiShiJian: Date?
    @NSManaged public var sanChuRenYuan: String?
    @NSManaged public var sanChuWuZi: String?
    @NSManaged public var sanChuXiangMu: String?
    @NSManaged public var sanChuZhiWu: String?
    @NSManaged public var suLiang: Int16
    @NSManaged public var youLiCheng: Int32
    @NSManaged public var youQianLiCheng: Int32
    @NSManaged public var youSuLiang: Int32
    @NSManaged public var youLeiXing: String?
    @NSManaged public var youChuRu: String?
    @NSManaged public var youQuYu: String?
    @NSManaged public var youQingYunQingShao: String?
    @NSManaged public var youYouKuJiaYouZhan: String?
    @NSManaged public var youDiDian: UUID?
    @NSManaged public var wuXuGuiHuan: Bool
    @NSManaged public var yuJiGuiHuanRiQi: Date?
    @NSManaged public var houBeiZhu: String?
    @NSManaged public var renYuan: RenYuan?
    @NSManaged public var wuZi: WuZi?
    @NSManaged public var xiangMu: XiangMu?
    @NSManaged public var zhiWu: ZhiWu?

}

//// MARK: Generated accessors for wuZi
//extension LiuShui {
//
//    @objc(addWuZiObject:)
//    @NSManaged public func addToWuZi(_ value: WuZi)
//
//    @objc(removeWuZiObject:)
//    @NSManaged public func removeFromWuZi(_ value: WuZi)
//
//    @objc(addWuZi:)
//    @NSManaged public func addToWuZi(_ values: NSSet)
//
//    @objc(removeWuZi:)
//    @NSManaged public func removeFromWuZi(_ values: NSSet)
//
//}

extension LiuShui : Identifiable {

}
