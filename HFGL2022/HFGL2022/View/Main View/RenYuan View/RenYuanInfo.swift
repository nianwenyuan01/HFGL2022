//
//  RenYuanInfo.swift
//  HFGL2022
//
//  Created by nwy on 2022/12/3.
//

import SwiftUI
import CoreData

struct RenYuanInfo: View {
    
    @State var currentType: String = "Popular"
    @Namespace var animation
    @State var headerOffsets: (CGFloat,CGFloat) = (0,0)
    
    
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
                    renyuan in
                    if renyuan.id == renYuanId {
                        
                        VStack{
                            RenYuanInfoImageName_View(image: renyuan.zaoPian ?? "touxiang111", name: renyuan.wName, xingBie: renyuan.xingBie, jiaZhao: renyuan.jiaZhao ?? "C", xiangMuArray: renyuan.xiangMuArray, zhiWu: renyuan.zhiWu?.mingCheng ?? "职务1",zaiZhi: renyuan.zaiZhi,  baoXian: renyuan.baoXian, baoXianRiQi: renyuan.baoXianRiQi ?? Date.parse("2022-01-01"), baoXianShiChang: renyuan.baoXianShiChang)
                            RenYuanSuJuInfo_View(liZhiYuanYin: renyuan.liZhiYuanYin ?? "", chuShengRiQi: renyuan.chuShengRiQi!, hunYin: renyuan.hunYin, wenHua: renyuan.wenHua ?? "", ruZhiShiJian: renyuan.ruZhiShiJian!, baoXian: renyuan.baoXian, baoXianRiQi: renyuan.baoXianRiQi ?? Date(), baoXianShiChang: renyuan.baoXianShiChang, shenFenZheng: renyuan.shenFenZheng!, zhuZhi: renyuan.zhuZhi!, beiZhu: renyuan.beiZhu ?? "", telArray: renyuan.telArray, wuZiArray: renyuan.wuZiArray, liuShuiArray: renyuan.liuShuiArray)
                        }
                    }
                })
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarLeading, content: {
                        if isShowDismissButton {
                            Button(action: {
                                dismiss1()
                            }, label: {
                                Image(systemName: "star")
                            })
                        }
                    })
                    ToolbarItem(placement: .navigationBarTrailing, content: {
                        if viewSheetMolde {
                            Button(action: {
                                dismiss1()
                            }, label: {
//                                Text("关闭")
                                Image(systemName: "star")
                            })
                        }else{
                            Button(action: {
                                if !edit {
                                    withAnimation{
                                        edit.toggle()
                                    }
                                }
                            }, label: {
                                Text("编辑")
                            })
                        }
                    })
                })
            }else{
                ForEach(renYuans, id: \.self, content: {
                    renyuan in
                    if renyuan.id == renYuanId {
                        EditRenYuanView(edit: $edit, renYuan: renyuan, xingMing: renyuan.xingMing ?? "", telArray: telArrayArray(array: renyuan.telArray), telHaoMa1: telSuLiang(array: renyuan.telArray)[0], telHaoMa2: telSuLiang(array: renyuan.telArray)[1], telHaoMa3: telSuLiang(array: renyuan.telArray)[2], telHaoMa4: telSuLiang(array: renyuan.telArray)[3], telHaoMa5: telSuLiang(array: renyuan.telArray)[4], xingBie: renyuan.xingBie, chuShengRiQi: renyuan.chuShengRiQi ?? Date(), zhiWu: renyuan.zhiWu?.mingCheng ?? "", xiangMuArray: xiangMuArrayArray(array: renyuan.xiangMuArray), xiangMu1: xiangMuSuLiang(array: renyuan.xiangMuArray)[0], xiangMu2: xiangMuSuLiang(array: renyuan.xiangMuArray)[1], xiangMu3: xiangMuSuLiang(array: renyuan.xiangMuArray)[2], shenFenZheng: renyuan.shenFenZheng ?? "", jiaZhao: renyuan.jiaZhao ?? "", zhuZhi: renyuan.zhuZhi ?? "", baoXian: renyuan.baoXian, baoXianRiQi: renyuan.baoXianRiQi ?? Date(), baoXianShiChang: renyuan.baoXianShiChang, zaiZhi: renyuan.zaiZhi, liZhiYuanYin: renyuan.liZhiYuanYin ?? "", ruZhiRiQi: renyuan.ruZhiShiJian ?? Date(), hunYin: renyuan.hunYin, wenHua: renyuan.wenHua ?? "", beiZhu: renyuan.beiZhu ?? "")
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
