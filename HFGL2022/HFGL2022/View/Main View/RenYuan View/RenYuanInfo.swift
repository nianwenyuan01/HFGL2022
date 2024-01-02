//
//  RenYuanInfo.swift
//  HFGL2022
//
//  Created by nwy on 2022/12/3.
//

import SwiftUI
import CoreData

struct RenYuanInfo: View {
    
//    @State var currentType: String = "Popular"
//    @Namespace var animation
//    @State var headerOffsets: (CGFloat,CGFloat) = (0,0)
    
    
    let isShowDismissButton: Bool
    let viewSheetMolde: Bool
    @Environment(\.dismiss) private var dismiss1
    @State var edit: Bool = false
    let renYuanId: UUID
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \RenYuan.xingMing, ascending: true)], animation: .default)
    var renYuans: FetchedResults<RenYuan>
    var body: some View {
        
        NavigationStack{
            
            if !edit {
                ForEach(renYuans, id: \.self, content: {
                    renYuan in
                    if renYuan.id == renYuanId {
                        VStack {
                            NewRenYuanSuJuView(renYuan: renYuan, isSheetMolde: true, xingMing: renYuan.xingMing ?? "", xingBie: renYuan.xingBie, zaiZhi: renYuan.zaiZhi, zhuZhi: renYuan.zhuZhi ?? "", wenHua: renYuan.wenHua ?? "", shenFenZheng: renYuan.shenFenZheng ?? "", ruZhiShiJian: renYuan.ruZhiShiJian ?? Date(), nianLing: renYuan.nianLing, liZhiYuanYin: renYuan.liZhiYuanYin ?? "", jiaZhao: renYuan.jiaZhao  ?? "", hunYin: renYuan.hunYin, chuShengRiQi: renYuan.chuShengRiQi ?? Date(), beiZhu: renYuan.beiZhu  ?? "", baoXianShiChang: renYuan.baoXianShiChang, baoXianRiQi: renYuan.baoXianRiQi ?? Date(), baoXian: renYuan.baoXian,zhiWu: renYuan.zhiWu?.mingCheng ?? "", tel: renYuan.telArray, telArray: telArrayArray(array: renYuan.telArray), tel1: telSuLiang(array: renYuan.telArray)[0], tel2: telSuLiang(array: renYuan.telArray)[1], tel3: telSuLiang(array: renYuan.telArray)[2], tel4: telSuLiang(array: renYuan.telArray)[3], tel5: telSuLiang(array: renYuan.telArray)[4], xiangMuArray: xiangMuArrayArray(array: renYuan.xiangMuArray), xiangMu1: xiangMuSuLiang(array: renYuan.xiangMuArray)[0], xiangMu2: xiangMuSuLiang(array: renYuan.xiangMuArray)[1], xiangMu3: xiangMuSuLiang(array: renYuan.xiangMuArray)[2])
                        }
                    }
                })
            }
        }
    }
//    人员电话数量生成的Int数组，生成后才不会越界
    func telArrayArray(array: [Tel]) -> [Int] {
        var intArray: [Int] = []
        for i in 1...array.count {
            intArray.append(i)
        }
        return intArray
    }
//    人员电话数组，生成后才不会越界
    func telSuLiang(array: [Tel]) -> [String] {
        var telHaoMaArray: [String] = []
        for i in array {
            telHaoMaArray.append(i.haoMa ?? "")
        }
        while telHaoMaArray.count < 5 {
            telHaoMaArray.append("")
        }
        return telHaoMaArray
    }
//    人员项目数量生成的Int数组，生成后才不会越界
    func xiangMuArrayArray(array: [XiangMu]) -> [Int] {
        var intArray: [Int] = []
        for i in 1...array.count {
            intArray.append(i)
        }
        return intArray
    }
//    人员项目数组，生成后才不会越界
    func xiangMuSuLiang(array: [XiangMu]) -> [String] {
        var xiangMuMingChengArray: [String] = []
        for i in array {
            xiangMuMingChengArray.append(i.mingCheng ?? "")
        }
        while xiangMuMingChengArray.count < 3 {
            xiangMuMingChengArray.append("")
        }
        return xiangMuMingChengArray
    }
    
    
    
    
    
}

struct RenYuanInfo_Previews: PreviewProvider {
    static var previews: some View {
        RenYuanInfo(isShowDismissButton: false, viewSheetMolde: false, renYuanId: UUID()).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
