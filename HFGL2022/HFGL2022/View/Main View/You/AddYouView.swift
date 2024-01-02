//
//  AddYouView.swift
//  HFGL2022
//
//  Created by nwy on 2023/12/8.
//

import SwiftUI
import CoreData

struct AddYouView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \LiuShui.riQiShiJian, ascending: true)], animation: .default)
    var liuShuis: FetchedResults<LiuShui>
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \WuZi.mingCheng, ascending: true)], animation: .default)
    var wuZis: FetchedResults<WuZi>
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \RenYuan.xingMing, ascending: true)], animation: .default)
    var renYuans: FetchedResults<RenYuan>
    @Environment(\.dismiss) var dismissAddYouView
    
    
    
//    @State var riQiShiJian: Date = Date()
    @State var shiJi: String = ""
    @State var cheLiang: String = ""
    @State var xianLiCheng: Int32 = 0
//    @State var qianLiCheng: Int32 = 0
    @State var chuRu: String = "出库"
    @State var youPin: String = ""
    @State var youKuJiaYouZhan: String = ""
    @State var diDian: UUID? = nil
    @State var suLiang: Int32 = 0
    
    
    var body: some View {
        NavigationStack {
            List {
                //出入库
                Section {
                    HStack {
                        Text("出入库？：")
                        Spacer()
                        Picker("选择出入库类型", selection: $chuRu.animation()) {
                            Text("出库").tag("出库")
                            Text("入库").tag("入库")
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .frame(width: 160)
                        .onChange(of: chuRu) {newValue in
                            youKuJiaYouZhan = "油库"
                            youPin = ""
                        }
                    }
                    //加油站？
                    if chuRu == "出库" {
                        HStack {
                            youKuJiaYouZhan == "" ? Text("油品来源：").foregroundColor(.red) : Text("油品来源：")
                            Spacer()
                            Picker("选择油品来源", selection: $youKuJiaYouZhan) {
                                Text("油库").tag("油库")
                                Text("加油站").tag("加油站")
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .frame(width: 160)
                        }
                    }
                }
                //车辆选择
                if chuRu == "出库" {
                    Section {
                        CheLiangXuanZheView(cheLiang: $cheLiang)
                            .onChange(of: cheLiang) { newValue in
                                diDian = nil
                                shiJi = ""
                            }
                        if cheLiang != "" {
                            //油品类型
                            XuanZheYouPin(cheLiang: cheLiang)
                            
                            //上次加油里程
                            HStack {
                                Text("上次加油里程：")
                                Text("\(ShangCiLiCheng(cheLiangMingCheng: cheLiang)) km")
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    Section {
                        //司机
                        if cheLiang != "" {
                            HStack {
                                XuanZheShiJi(siJiXingMing: ShangCiShiJi(cheLiangMingCheng: cheLiang), xuanZhongShiJi: $shiJi)
                            }
                        }
                    }
                    Section {
                        //地点
                        if youKuJiaYouZhan == "加油站" {
                            HStack {
                                Text("加油地点：")
                                Text("加油站")
                                    .foregroundColor(.purple)
                            }
                        } else {
                            XuanZheYouKuDiDian(diDian: ShangCiDiDian(cheLiangMingCheng: cheLiang), xuanZhongDiDian: $diDian)
                        }
                    }
                    Section {
                        //现里程
                        HStack {
                            xianLiCheng == 0 ? Text("现里程：").foregroundColor(.red) : Text("现里程：")
                            TextField("当前里程表读数", value: $xianLiCheng, formatter: NumberFormatter())
                            Text("km")
                        }
                    }
                }
                
                //入库油品类型
                if chuRu == "入库" {
                    Section {
                        HStack {
                            youPin == "" ? Text("油品类型：").foregroundColor(.red) : Text("油品类型：")
                            Spacer()
                            Picker("选择油品类型", selection: $youPin) {
                                Text("柴油").tag("柴油")
                                Text("汽油").tag("汽油")
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .frame(width: 160)
                        }
                    }
                    Section {
                        //地点
                        if youKuJiaYouZhan == "加油站" {
                            HStack {
                                Text("加油地点：")
                                Text("加油站")
                                    .foregroundColor(.purple)
                            }
                        } else {
                            XuanZheYouKuDiDian(diDian: ShangCiDiDian(cheLiangMingCheng: cheLiang), xuanZhongDiDian: $diDian)
                        }
                    }
                }
                Section {
                    //加油量
                    HStack {
                        suLiang == 0 ? Text("加油量：").foregroundColor(.red) : Text("加油量：")
                        TextField("", value: $suLiang, formatter: NumberFormatter())
                        Text("L(升)")
                    }
                }
            }
//            .listStyle(.grouped)
            .navigationBarTitle(chuRu == "出库" ? "加油中..." : "入库中...")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button(action: {
                dismissAddYouView()
            }, label: {
                Text("取消")
            }).controlSize(.small).buttonStyle(.bordered).buttonBorderShape(.capsule), trailing: Button(action: {
                addNewYouDoneAndSave(chuRu: chuRu, youKuJiaYouZhan: youKuJiaYouZhan)
                dismissAddYouView()
            }, label: {
                Text("完成")
            }).controlSize(.small).buttonStyle(.bordered).buttonBorderShape(.capsule).disabled(donePanDuan()))
        }
    }
    
    //判断
    func donePanDuan() -> Bool {
        if chuRu == "出库" && youKuJiaYouZhan == "油库" {
            if cheLiang != "" && xianLiCheng > 0 && suLiang > 0 {
                if diDian != nil || ShangCiDiDian(cheLiangMingCheng: cheLiang) != nil {
                    return false
                }
            }
        }
        if chuRu == "出库" && youKuJiaYouZhan == "加油站" {
            if cheLiang != "" && xianLiCheng > 0 && suLiang > 0 {
                return false
            }
        }
        if chuRu == "入库" {
            if suLiang > 0 && youPin != "" {
                if diDian != nil || ShangCiDiDian(cheLiangMingCheng: cheLiang) != nil {
                    return false
                }
            }
        }
        return true
    }
    //保存
    func addNewYouDoneAndSave(chuRu: String, youKuJiaYouZhan: String) {
        let newYou = LiuShui(context: viewContext)
        
        if chuRu == "出库" {
            //流水id
            newYou.id = UUID()
            //流水类别
            newYou.leiBie = "youChuKu"
            //日期时间
            newYou.riQiShiJian = Date()
            //出入库
            newYou.youChuRu = chuRu
            //油库加油站？
            newYou.youYouKuJiaYouZhan = youKuJiaYouZhan
            //车辆
            for i in wuZis {
                if i.mingCheng == cheLiang {
                    i.addToLiuShui(newYou)
            //油品类型
                    newYou.youLeiXing = i.nengYuanLeiBie
                }
            }
            //司机
            if shiJi == "" {
                for i in renYuans {
                    if i.xingMing == ShangCiShiJi(cheLiangMingCheng: cheLiang) {
                        i.addToLiuShui(newYou)
                    }
                }
            } else {
                for i in renYuans {
                    if i.xingMing == shiJi {
                        i.addToLiuShui(newYou)
                    }
                }
            }
            //现里程
            newYou.youLiCheng = xianLiCheng
            //加油量
            newYou.youSuLiang = suLiang * -1
            //油库地点
            if youKuJiaYouZhan == "油库" {
                if diDian == nil {
                    newYou.youDiDian = ShangCiDiDian(cheLiangMingCheng: cheLiang)
                } else {
                    newYou.youDiDian = diDian
                }
            } else {
                newYou.youDiDian = nil
            }
            //尝试保存
            do{
                try viewContext.save()
                print("保存成功")
            } catch {
                print("保存错误")
            }
        }
        if chuRu == "入库" {
            //流水id
            newYou.id = UUID()
            //流水类型
            newYou.leiBie = "youRuKu"
            //日期时间
            newYou.riQiShiJian = Date()
            //出入库
            newYou.youChuRu = chuRu
            //油品类型
            newYou.youLeiXing = youPin
            //加油量
            newYou.youSuLiang = suLiang
            //油库地点
            
            newYou.youDiDian = diDian
            //尝试保存
            do{
                try viewContext.save()
                print("保存成功")
            } catch {
                print("保存错误")
            }
        }
    }
    
    struct CheLiangXuanZheView: View {
        @State var showCheLiangXuanZheView: Bool = false
        @Binding var cheLiang: String
        var body: some View {
            Button(action: {self.showCheLiangXuanZheView = true}, label: {
                HStack {
                    cheLiang == "" ? Text("车辆：").foregroundColor(.red) : Text("车辆：").foregroundColor(Color("wwysBlack"))
                    cheLiang == "" ? Text("请选择车辆").foregroundColor(.gray) : Text(cheLiang)
                    Spacer()
                    Text(cheLiang == "" ? "选择车辆" : "更改")
                }
            })
            .sheet(isPresented: $showCheLiangXuanZheView, content: {
                cheLiangListView(wuZiMingChengGet: $cheLiang)
            })
        }
        
        struct cheLiangListView: View {
            @State var showAddWuZiView: Bool = false
            @Environment(\.dismiss) var dismissXuanZheWuZiView
            @Binding var wuZiMingChengGet: String
            @Environment(\.managedObjectContext) private var viewContext
            @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \WuZi.mingCheng, ascending: true)], animation: .default)
            var wuZis: FetchedResults<WuZi>
            
            var body: some View {
                NavigationStack {
                    List {
                        ForEach(wuZis, id: \.self) { wuZi in
                            if wuZi.leiBie?.mingCheng == "车" || wuZi.leiBie?.mingCheng == "车辆" {
                                Button {
                                    withAnimation {
                                        wuZiMingChengGet = wuZi.mingCheng ?? ""
                                    }
                                    dismissXuanZheWuZiView()
                                } label: {
                                    Text(wuZi.mingCheng ?? "")
                                        .foregroundColor(Color("wwysBlack"))
                                }

                            }
                        }
                        Section {
                            Button(action: {self.showAddWuZiView = true}, label: {
                                HStack {
                                    Spacer()
                                    Text("添加车辆")
                                    Spacer()
                                }
                            }).sheet(isPresented: $showAddWuZiView, content: {
                                AddWuZiView(leixing: WuZiLeiXing.车辆, mingChengBool: true, bianHao: 0)
                            })
                        }
                    }
                    .listStyle(.automatic)
                    .navigationBarTitle("选择车辆")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarItems(leading: Button(action: {
                        dismissXuanZheWuZiView()
                    }, label: {
                        Text("取消")
                    }))
                }
            }
        }
    }
    
    //上次加油里程
    func ShangCiLiCheng(cheLiangMingCheng: String) -> Int32 {
        var liChengArray: Array = [Int32]()
        for liuSui in liuShuis {
            if liuSui.wuZi?.mingCheng == cheLiangMingCheng {
                liChengArray.append(liuSui.youLiCheng)
            }
        }
        return liChengArray.max() ?? 0
    }
    //上次加油司机
    func ShangCiShiJi(cheLiangMingCheng: String) -> String {
        var myDic = [String: Date]()
        for liuSui in liuShuis {
            if liuSui.wuZi?.mingCheng == cheLiangMingCheng {
                myDic[liuSui.renYuan?.xingMing ?? ""] = liuSui.riQiShiJian
            }
        }
        if myDic.count == 1 {
            let onlyDic = myDic.first
            let siJiXingMing = onlyDic?.key
            return siJiXingMing!
        }
        if myDic.count == 0 {
            return ""
        }
        if myDic.count > 1 {
            let maxElement = myDic.max(by: { $0.value < $1.value })
            let siJiXingMing = maxElement?.key
            return siJiXingMing!
        } else {
            return "未知"
        }
    }
    //选择司机
    struct XuanZheShiJi: View {
        @State var showShiJiXuanZheView: Bool = false
        let siJiXingMing: String
        @Binding var xuanZhongShiJi: String
        var body: some View {
            Button {
                showShiJiXuanZheView = true
            } label: {
                HStack {
                    if xuanZhongShiJi == "" {
                        if siJiXingMing == "" {
                            Text("司机：").foregroundColor(.red)
                            Text("请选择司机").foregroundColor(.gray)
                            Spacer()
                            Text("选择")
                        } else {
                            Text("司机：").foregroundColor(Color("wwysBlack"))
                            Text(siJiXingMing).foregroundColor(.gray)
                            Spacer()
                            Text("更改")
                        }
                    } else {
                        Text("司机：").foregroundColor(Color("wwysBlack"))
                        Text(xuanZhongShiJi)
                        Spacer()
                        Text("更改")
                    }

                }
            }.sheet(isPresented: $showShiJiXuanZheView, content: {
                ShiJiListView(siJiXingMingGet: $xuanZhongShiJi)
            })

        }
        struct ShiJiListView: View {
            @State var siJiBool: Bool = true
            
            @State var showAddRenYuanView: Bool = false
            @Environment(\.dismiss) var dismissXuanZheRenYuanView
            @Binding var siJiXingMingGet: String
            @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \RenYuan.xingMing, ascending: true)], animation: .default)
            var renYuans: FetchedResults<RenYuan>
            
            var body: some View {
                NavigationStack {
                    Picker("选择人员类型", selection: $siJiBool) {
                        Text("司机").tag(true)
                        Text("所有人").tag(false)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal, 50)
                    List {
                        if siJiBool {
                            ForEach(renYuans, id: \.self) { renYuan in
                                if renYuan.zhiWu?.mingCheng == "司机" || renYuan.zhiWu?.mingCheng == "驾驶员" {
                                    Button {
                                        siJiXingMingGet = renYuan.xingMing ?? ""
                                        dismissXuanZheRenYuanView()
                                    } label: {
                                        Text(renYuan.xingMing ?? "")
                                            .foregroundColor(Color("wwysBlack"))
                                    }
                                }
                            }
                        } else {
                            ForEach(renYuans, id: \.self) { renYuan in
                                Button {
                                    siJiXingMingGet = renYuan.xingMing ?? ""
                                    dismissXuanZheRenYuanView()
                                } label: {
                                    Text(renYuan.xingMing ?? "")
                                        .foregroundColor(Color("wwysBlack"))
                                }
                            }
                        }
                        Section {
                            Button(action: {self.showAddRenYuanView = true}, label: {
                                HStack {
                                    Spacer()
                                    Text("添加司机")
                                    Spacer()
                                }
                            }).sheet(isPresented: $showAddRenYuanView, content: {
                                AddRenYuanView(leixing: ZhiWuLeiXing.司机)
                            })
                        }
                    }
                    .listStyle(.automatic)
                    .navigationBarTitle("选择司机")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarItems(leading: Button(action: {
                        dismissXuanZheRenYuanView()
                    }, label: {
                        Text("取消")
                    }))
                }
            }
        }
    }
    
    //选择油品
    struct XuanZheYouPin: View {
        let cheLiang: String
        @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \WuZi.mingCheng, ascending: true)], animation: .default)
        var wuZis: FetchedResults<WuZi>
        
        var body: some View {
            ForEach(wuZis, id: \.self) { wuZi in
                if wuZi.mingCheng == cheLiang {
                    HStack {
                        Text("能源类型：")
                        Text(wuZi.nengYuanLeiBie ?? "")
                            .fontWeight(.bold)
                            .padding(4)
                            .foregroundColor(.white)
                            .background(wuZi.nengYuanLeiBie == "柴油" ? .orange : .blue)
                            .cornerRadius(6)
                    }
                }
            }
        }
    }
    
    //上次加油地点
    func ShangCiDiDian(cheLiangMingCheng: String) -> UUID? {
        var myDic = [UUID?: Date]()
        for liuSui in liuShuis {
            if liuSui.wuZi?.mingCheng == cheLiangMingCheng {
                myDic[liuSui.youDiDian ?? nil] = liuSui.riQiShiJian
            }
        }
        if myDic.count == 1 {
            let onlyDic = myDic.first
            let diDian = onlyDic?.key
            return diDian ?? nil
        }
        if myDic.count == 0 {
            return nil
        }
        if myDic.count > 1 {
            let maxElement = myDic.max(by: { $0.value < $1.value })
            let diDian = maxElement?.key
            return diDian
        } else {
            return nil
        }
    }
    
    //选择油库地点
    struct XuanZheYouKuDiDian: View {
        @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \WuZi.mingCheng, ascending: true)], animation: .default)
        var wuZis: FetchedResults<WuZi>
        @State var showYouKuDiDianXuanZheView: Bool = false
        let diDian: UUID?
        @Binding var xuanZhongDiDian: UUID?
        var body: some View {
            Button(action: {self.showYouKuDiDianXuanZheView = true}, label: {
                HStack {
                    if xuanZhongDiDian == nil {
                        if diDian == nil {
                            HStack {
                                Text("油库地点：").foregroundColor(.red)
                                Text("请选择油库").foregroundColor(.gray)
                                Spacer()
                                Text("更改")
                            }
                        } else {
                            HStack {
                                Text("油库地点：").foregroundColor(Color("wwysBlack"))
                                ForEach(wuZis, id: \.self) { wuZi in
                                    if wuZi.id == diDian {
                                        Text(wuZi.mingCheng!).foregroundColor(.gray)
                                    }
                                }
                                Spacer()
                                Text("更改")
                            }
                        }
                    } else {
                        HStack {
                            Text("油库地点：").foregroundColor(Color("wwysBlack"))
                            ForEach(wuZis, id: \.self) { i in
                                if i.id == xuanZhongDiDian {
                                    Text(i.mingCheng!)
                                }
                            }
                            Spacer()
                            Text("更改")
                        }
                    }
                }
            }).sheet(isPresented: $showYouKuDiDianXuanZheView, content: {
                YouKuDiDianListView(diDianMingChengGet: $xuanZhongDiDian)
            })
        }
        struct YouKuDiDianListView: View {
            @State var showAddWuZiView: Bool = false
            @Environment(\.dismiss) var dismissXuanZheYouKuView
            @Binding var diDianMingChengGet: UUID?
            @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \WuZi.mingCheng, ascending: true)], animation: .default)
            var wuZis: FetchedResults<WuZi>
            var body: some View {
                NavigationStack {
                    List {
                        ForEach(wuZis, id: \.self) { wuZi in
                            if wuZi.leiBie?.mingCheng == "油库" {
                                Button(action: {
                                    diDianMingChengGet = wuZi.id
                                    dismissXuanZheYouKuView()
                                }, label: {
                                    Text(wuZi.mingCheng ?? "").foregroundColor(Color("wwysBlack"))
                                })
                            }
                        }
                        Section {
                            Button(action: {self.showAddWuZiView = true}, label: {
                                HStack {
                                    Spacer()
                                    Text("添加油库")
                                    Spacer()
                                }
                            }).sheet(isPresented: $showAddWuZiView, content: {
                                AddWuZiView(leixing: WuZiLeiXing.油库, mingChengBool: true, bianHao: 0)
                            })
                        }
                    }
                    .listStyle(.automatic)
                    .navigationBarTitle("选择油库")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarItems(leading: Button(action: {
                        dismissXuanZheYouKuView()
                    }, label: {
                        Text("取消")
                    }))
                }
            }
        }
    }
}







#Preview {
    AddYouView()
}
