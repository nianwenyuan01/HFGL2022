//
//  LiuShuiFunc.swift
//  HFGL2022
//
//  Created by nwy on 2022/12/16.
//

import SwiftUI
import CoreData

public func LiuShuiJiLu_RenYuan(newLiuShui: LiuShui, renyuan: FetchedResults<RenYuan>.Element?, zhiwu: FetchedResults<ZhiWu>.Element?, xiangmu:FetchedResults<XiangMu>.Element?, lieBie: String, beizhu: String? , houbeizhu: String?, sanRenYuan: String?, sanWuZi: String?, sanXiangMu: String?, sanZhiWu: String?, qianZhiWu: String?, qianXiangMu: String?) {
    
    
    if renyuan != nil {renyuan!.addToLiuShui(newLiuShui)}
    if zhiwu != nil {zhiwu!.addToLiuShui(newLiuShui)}
    if xiangmu != nil {xiangmu!.addToLiuShui(newLiuShui)}
    newLiuShui.id = UUID()
    newLiuShui.riQiShiJian = Date()
    newLiuShui.leiBie = lieBie
    
    
    newLiuShui.beiZhu = beizhu
    newLiuShui.houBeiZhu = houbeizhu
    
    
    newLiuShui.sanChuRenYuan = sanRenYuan
    newLiuShui.sanChuWuZi = sanWuZi
    newLiuShui.sanChuXiangMu = sanXiangMu
    newLiuShui.sanChuZhiWu = sanZhiWu
    newLiuShui.qianZhiWu = qianZhiWu
    newLiuShui.qianXiangMu = qianXiangMu
    
}

public func LiuShuiJiLu_WuZi(newLiuShui: LiuShui, wuZi: FetchedResults<WuZi>.Element?, renYuan: FetchedResults<RenYuan>.Element?, xiangMu: FetchedResults<XiangMu>.Element?, leiBie: String, beizhu: String? , houbeizhu: String?, sanRenYuan: String?, sanWuZi: String?, sanXiangMu: String?) {
    
    if wuZi != nil {wuZi!.addToLiuShui(newLiuShui)}
    if renYuan != nil {renYuan!.addToLiuShui(newLiuShui)}
    if xiangMu != nil {xiangMu!.addToLiuShui(newLiuShui)}
    newLiuShui.id = UUID()
    newLiuShui.riQiShiJian = Date()
    newLiuShui.leiBie = leiBie
    newLiuShui.beiZhu = beizhu
    newLiuShui.houBeiZhu = houbeizhu
    newLiuShui.sanChuRenYuan = sanRenYuan
    newLiuShui.sanChuWuZi = sanWuZi
    newLiuShui.sanChuXiangMu = sanXiangMu
}
