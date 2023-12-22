//
//  HomeView.swift
//  HFGL2022
//
//  Created by nwy on 2022/12/3.
//

import SwiftUI
import CoreData

struct HomeView: View {
    
    
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \RenYuan.xingMing, ascending: true)], animation: .default)
    var renYuans: FetchedResults<RenYuan>
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \WuZi.mingCheng, ascending: true)], animation: .default)
    var wuZis: FetchedResults<WuZi>
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \LiuShui.riQiShiJian, ascending: false)], animation: .default)
    var liuShui: FetchedResults<LiuShui>
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack{
//                    正文
                    HStack{
                        Spacer()
                        NaviHomeButton(dizhi: "人员列表页面", title: "人员总表", image: "star", imageColor: Color.blue, count: Int16(renYuans.count),countColor: Color.orange, info: "", infoColor: Color.blue)
                        Spacer()
                        NaviHomeButton(dizhi: "物资列表页面", title: "物资总表", image: "star",imageColor: Color.green, count: Int16(wuZis.count),countColor: Color.orange, info: "", infoColor: Color.blue)
                        Spacer()
                    }
                    HStack{
                        Spacer()
                        NaviHomeButton(dizhi: "流水统计页面", title: "流水", image: "star", imageColor: Color.purple, count: Int16(liuShui.count),countColor: Color.blue, info: "今天", infoColor: Color.blue)
                        Spacer()
                        NaviHomeButton(dizhi: "异常列表页面", title: "异常", image: "star", imageColor: Color.red, count: 7, countColor: Color.red, info: "今天", infoColor: Color.blue)
                        Spacer()
                    }
                    HStack{
                        Spacer()
                        NaviHomeButton(dizhi: "业务功能页面", title: "业务功能、考核、调任等", image: "star", imageColor: Color.brown, count: 0, countColor: Color.green, info: "", infoColor: Color.blue)
                        Spacer()
                    }
//                    Form {
                        VStack{
                            NavigationLink(destination: ZhiWuView(), label: {
                                Text("职务列表")
                            })
                            NavigationLink(destination: XiangMuView(), label: {
                                Text("项目列表")
                            })
                            NavigationLink(destination: {WuZiLeiBieView()}, label: {
                                Text("物资类别列表")
                            })
                            NavigationLink(destination: {YouListView()}, label: {
                                Text("加油列表")
                            })
                            
                            ForEach(renYuans, id: \.self) { renYuan in
                                if renYuan.xingMing == "333" {
                                    NavigationLink(destination: {NewRenYuanSuJuView(renYuan: renYuan, xingMing: renYuan.xingMing ?? "", xingBie: renYuan.xingBie, zaiZhi: renYuan.zaiZhi, zhuZhi: renYuan.zhuZhi ?? "", wenHua: renYuan.wenHua ?? "", shenFenZheng: renYuan.shenFenZheng ?? "", ruZhiShiJian: renYuan.ruZhiShiJian ?? Date(), nianLing: renYuan.nianLing, liZhiYuanYin: renYuan.liZhiYuanYin ?? "", jiaZhao: renYuan.jiaZhao  ?? "", hunYin: renYuan.hunYin, chuShengRiQi: renYuan.chuShengRiQi ?? Date(), beiZhu: renYuan.beiZhu  ?? "", baoXianShiChang: renYuan.baoXianShiChang, baoXianRiQi: renYuan.baoXianRiQi ?? Date(), baoXian: renYuan.baoXian,zhiWu: renYuan.zhiWu?.mingCheng ?? "", tel: renYuan.telArray, telArray: telArrayArray(array: renYuan.telArray), tel1: telSuLiang(array: renYuan.telArray)[0], tel2: telSuLiang(array: renYuan.telArray)[1], tel3: telSuLiang(array: renYuan.telArray)[2], tel4: telSuLiang(array: renYuan.telArray)[3], tel5: telSuLiang(array: renYuan.telArray)[4], xiangMuArray: xiangMuArrayArray(array: renYuan.xiangMuArray), xiangMu1: xiangMuSuLiang(array: renYuan.xiangMuArray)[0], xiangMu2: xiangMuSuLiang(array: renYuan.xiangMuArray)[1], xiangMu3: xiangMuSuLiang(array: renYuan.xiangMuArray)[2])}, label: {
                                        Text("11111")
                                    })
                                }
                            }
                            
                            
                            
                        }
//                    }
                }
            }
            .navigationTitle("HFGL")
            Text("Select an item")
        }
        
    }
    
    func telArrayArray(array: [Tel]) -> [Int] {
        var intArray: [Int] = []
        for i in 1...array.count {
            intArray.append(i)
        }
        return intArray
    }
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
    func xiangMuArrayArray(array: [XiangMu]) -> [Int] {
        var intArray: [Int] = []
        for i in 1...array.count {
            intArray.append(i)
        }
        return intArray
    }
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
