//
//  RenYuanView.swift
//  HFGL2022
//
//  Created by nwy on 2022/12/3.
//

import SwiftUI
import CoreData

struct RenYuanView: View {
    @State private var showAddRenYuanView = false
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \RenYuan.xingMing, ascending: true)], animation: .default)
    var renYuans: FetchedResults<RenYuan>
    var body: some View {
        NavigationStack {
            List {
                ForEach(renYuans) { renYuan in
                    NavigationLink {
                        RenYuanInfo(isShowDismissButton: false, viewSheetMolde: false, renYuanId: renYuan.id!)
                    } label: {
                        HStack{
                            Image("touxiang111")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 40, height: 40)
                                .cornerRadius(20)
//                                .padding()
                            VStack{
                                
                                VStack(alignment: .leading){
                                    HStack{
                                        Text(renYuan.xingMing ?? "")
                                        if renYuan.xingBie {
                                            Image(systemName: "star")
                                                .foregroundColor(.blue)
                                        }else{Image(systemName: "star").foregroundColor(.red)}
                                    }
                                    .padding(.bottom, 1)
                                    HStack(alignment: .top){
                                        ForEach(renYuan.xiangMuArray, id: \.self, content: {
                                            xiangmu in
                                            if xiangmu.wName != "" {
                                                LabelView(title: xiangmu.wName, color: Color("wwysW"))
                                            }
                                        })
//                                        if renYuan.zhiWu?.mingCheng != "" {
//                                            LabelView(title: renYuan.zhiWu?.mingCheng ?? "", color: Color("wwysW"))
//                                        }
                                        if !renYuan.zaiZhi {
                                            LabelView(title: "离职", color: Color.red)
                                        }
                                        if renYuan.jiaZhao != "无驾照" && renYuan.jiaZhao == "B照" {
                                            LabelView(title: "\(renYuan.jiaZhao ?? "")", color: Color.orange)
                                        }else if renYuan.jiaZhao != "无驾照" && renYuan.jiaZhao == "C照" {
                                            LabelView(title: "\(renYuan.jiaZhao ?? "")", color: Color.blue)
                                        }
                                        if !renYuan.baoXian {LabelView(title: "无保险", color: Color.red)}
                    //                    计算保险过期
                                        let calendar = Calendar.current
                                        let startDate = renYuan.baoXianRiQi
                                        let endDate = Date()
                                        let components = calendar.dateComponents([.day], from: startDate ?? Date(), to: endDate)
                                        let shiJianCha = components.day ?? 360
                                        if renYuan.baoXian && shiJianCha >= renYuan.baoXianShiChang * 30 {
                                            LabelView(title: "保险过期", color: Color.red)
                                        }else if renYuan.baoXian && shiJianCha < (renYuan.baoXianShiChang * 30) && shiJianCha >= (renYuan.baoXianShiChang * 30) - 7 {
                                            LabelView(title: "保险即将过期", color: .orange)
                                        }
                                    }
                                }
                                .padding(.leading, 4)
                            }
                        }
                        
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .listStyle(.grouped)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: {
//                        self.showModalRenYuanView = false
                        self.showAddRenYuanView = true
                    }) {
                        Image(systemName: "plus")
                    }.fullScreenCover(isPresented: self.$showAddRenYuanView, content: {AddRenYuanView()})
                }
            }
            .navigationTitle("人员总表")
            .navigationBarTitleDisplayMode(.inline)
            Text("Select an item")
            
        }
    }
//    private func addItem() {
//        withAnimation {
//            let newRenYuan = RenYuan(context: viewContext)
//            newRenYuan.xingMing = "adddjjwl"
//            newRenYuan.id = UUID()
////            newRenYuan.xiangMuArray = [XiangMu(context: viewContext)]
//            let newXiangMu = XiangMu(context: viewContext)
//            newXiangMu.mingCheng = "项目33"
//            newXiangMu.id = UUID()
//            newXiangMu.addToRenYuan(newRenYuan)
//            let newLiuShui = LiuShui(context: viewContext)
//            newLiuShui.id = UUID()
//            newLiuShui.guiHuan = false
//            newLiuShui.leiBie = "入职配发"
//            newLiuShui.suLiang = 2
//            newLiuShui.riQiShiJian = Date()
//            newLiuShui.renYuan = newRenYuan
//            let newLiuShui2 = LiuShui(context: viewContext)
//            newLiuShui2.id = UUID()
//            newLiuShui2.guiHuan = false
//            newLiuShui2.leiBie = "入职配发"
//            newLiuShui2.suLiang = 1
//            newLiuShui2.riQiShiJian = Date()
//            newLiuShui2.renYuan = newRenYuan
//            let newLiuShui3 = LiuShui(context: viewContext)
//            newLiuShui3.id = UUID()
//            newLiuShui3.guiHuan = false
//            newLiuShui3.leiBie = "入职配发"
//            newLiuShui3.suLiang = 21
//            newLiuShui3.riQiShiJian = Date.parse("2022年6月23日")
//            newLiuShui3.renYuan = newRenYuan
//            let newWuZi = WuZi(context: viewContext)
//            newWuZi.id = UUID()
//            newWuZi.mingCheng = "新物资12332"
//            newWuZi.suLiang = 12
//            newWuZi.danWei = "个"
//            newLiuShui.wuZi = newWuZi
//            newLiuShui3.wuZi = newWuZi
//            let newWuZi2 = WuZi(context: viewContext)
//            newWuZi2.id = UUID()
//            newWuZi2.mingCheng = "物资2"
//            newWuZi2.suLiang = 1
//            newWuZi2.danWei = "套"
//            newLiuShui2.wuZi = newWuZi2
//            let newTel1 = Tel(context: viewContext)
//            newTel1.id = UUID()
//            newTel1.haoMa = "13328366275"
//            newTel1.leiXing = "手机1"
//            newTel1.renYuan = newRenYuan
//            let newTel2 = Tel(context: viewContext)
//            newTel2.id = UUID()
//            newTel2.haoMa = "33777165565"
//            newTel2.leiXing = "住宅"
//            newTel2.renYuan = newRenYuan
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { renYuans[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct RenYuanView_Previews: PreviewProvider {
    static var previews: some View {
        RenYuanView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
