//
//  LiushuiView.swift
//  HFGL2022
//
//  Created by nwy on 2022/12/3.
//

import SwiftUI
import CoreData

struct LiushuiView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \LiuShui.riQiShiJian, ascending: false)], animation: .default)
    var liuShuis: FetchedResults<LiuShui>
    
    var body: some View {
        NavigationStack{
            List(content: {
                Section("今日流水", content: {
                    ForEach(liuShuis, id: \.self, content: {
                        liuShui in
    //                    时间计算
                        let calendar = Calendar.current
                        let starDate = liuShui.riQiShiJian!
                        let now = Date()
                        let shijiancha = calendar.dateComponents([.day], from: starDate, to: now)
                        let day1 = shijiancha.day
//                        小于30天
                        if day1 ?? 0 < 360 {
                            LiuShuiCellView(liushui: liuShui, renyuanID: (liuShui.renYuan?.id), day1: day1 ?? 0)
                        }
                    })
                    .onDelete(perform: deleteItems)
                })
            })
            .listStyle(.grouped)
        }
    }
    struct LiuShuiCellView: View {
        let liushui: FetchedResults<LiuShui>.Element
        let renyuanID: UUID?
        let day1: Int
        var body: some View {
            VStack(alignment: .leading){
                HStack{
                    Spacer()
                    if day1 < 1 {
                        Text("今天")
                            .foregroundColor(.gray)
                            .font(.system(size: 10))
                    }else{
                        Text(liushui.riQiShiJian?.dateString() ?? "")
                            .foregroundColor(.gray)
                            .font(.system(size: 10))
                    }
                }
//                人员相关流水
                Group(content: {
                    if liushui.leiBie == "职务_入职" {
                        HStack{
                            NameButtonView(renyuanID: renyuanID ?? UUID(), name: liushui.sanChuRenYuan ?? "")
                            Text("入职")
                        }
                    }
                    if liushui.leiBie == "职务_变动" {
                        HStack{
                            NameButtonView(renyuanID: renyuanID ?? UUID(), name: liushui.sanChuRenYuan ?? "")
                            Text("调任：")
                                .frame(maxWidth: 44, alignment: .leading)
                                .lineLimit(1)
                            Text("\(liushui.qianZhiWu ?? "")")
                                .frame(maxWidth: 65, alignment: .leading)
                                .lineLimit(1)
                            Text("➡️")
                            ZhiWuButtonView(zhiWu: liushui.zhiWu, name: liushui.sanChuZhiWu ?? "")
                        }
                    }
                    if liushui.leiBie == "项目_变动_进入" {
                        HStack{
                            NameButtonView(renyuanID: renyuanID ?? UUID(), name: liushui.sanChuRenYuan ?? "")
                            Text("加入：")
                            XiangMuButtonView(xiangMu: liushui.xiangMu, name: liushui.sanChuXiangMu ?? "")
                        }
                    }
                    if liushui.leiBie == "项目_变动_退出" {
                        HStack{
                            NameButtonView(renyuanID: renyuanID ?? UUID(), name: liushui.sanChuRenYuan ?? "")
                            Text("退出：")
                            XiangMuButtonView(xiangMu: liushui.xiangMu, name: liushui.sanChuXiangMu ?? "")
                        }
                    }
                    if liushui.leiBie == "在职_变动" {
                        HStack{
                            NameButtonView(renyuanID: renyuanID ?? UUID(), name: liushui.sanChuRenYuan ?? "")
                            Text(liushui.beiZhu ?? "")
                        }
                    }
                    if liushui.leiBie == "基本信息_变动_姓名" {
                        HStack{
                            Text(liushui.beiZhu ?? "")
                                .frame(maxWidth: 85, alignment: .leading)
                                .lineLimit(1)
                            Text("更名为：")
                            NameButtonView(renyuanID: renyuanID ?? UUID(), name: liushui.sanChuRenYuan ?? "")
                        }
                    }
                    if liushui.leiBie == "基本信息_变动_入职时间" {
                        HStack{
                            NameButtonView(renyuanID: renyuanID ?? UUID(), name: liushui.sanChuRenYuan ?? "")
                            Text("变更入职时间")
                        }
                    }
                    if liushui.leiBie == "备注更新" {
                        HStack{
                            NameButtonView(renyuanID: renyuanID ?? UUID(), name: liushui.sanChuRenYuan ?? "")
                            Text("更新备注")
                        }
                    }
                })
//                部门职务相关流水
                Group(content: {
                    if liushui.leiBie == "项目_创建" {
                        HStack{
                            Text("新部门：")
                                .frame(maxWidth: 85, alignment: .leading)
                                .lineLimit(1)
                            XiangMuButtonView(xiangMu: liushui.xiangMu, name: liushui.xiangMu?.mingCheng ?? "")
                        }
                    }
//                    项目修改
                    if liushui.leiBie == "职务_创建" {
                        HStack{
                            Text("新职务：")
                                .frame(maxWidth: 85, alignment: .leading)
                                .lineLimit(1)
                            ZhiWuButtonView(zhiWu: liushui.zhiWu, name: liushui.zhiWu?.mingCheng ?? "")
                        }
                    }
                    if liushui.leiBie == "职务_更名" {
                        HStack{
                            Text("职务更名：")
                                .frame(maxWidth: 85, alignment: .leading)
                                .lineLimit(1)
                            Text("\(liushui.qianZhiWu ?? "")")
                            Text("➡️")
                            ZhiWuButtonView(zhiWu: liushui.zhiWu, name: liushui.zhiWu?.mingCheng ?? "")
                        }
                    }
                    if liushui.leiBie == "项目_更名" {
                        HStack{
                            Text("部门更名：")
                                .frame(maxWidth: 85, alignment: .leading)
                                .lineLimit(1)
                            Text("\(liushui.qianXiangMu ?? "")")
                            Text("➡️")
                            XiangMuButtonView(xiangMu: liushui.xiangMu, name: liushui.xiangMu?.mingCheng ?? "")
                        }
                    }
                })
                
            }
            .font(.system(size: 14))
        }
    }
    private struct NameButtonView: View {
        let renyuanID: UUID
        @State private var showNameView: Bool = false
        let name: String
        var body: some View {
            Button(action: {
                self.showNameView = true
            }, label: {
                Text(name)
                    .frame(maxWidth: 85, alignment: .leading)
                    .lineLimit(1)
            })
            .sheet(isPresented: $showNameView, content: {
                RenYuanInfo(isShowDismissButton: false, viewSheetMolde: true, renYuanId: renyuanID)
            })
            .buttonStyle(.borderless)
        }
    }
    private struct XiangMuButtonView: View {
        let xiangMu: FetchedResults<XiangMu>.Element!
        @State private var showXiangMuNameView: Bool = false
        let name: String
        var body: some View {
            Button(action: {
                if xiangMu != nil {
                    self.showXiangMuNameView = true
                }
                
            }, label: {
                Text(name)
                    .frame(maxWidth: 65, alignment: .leading)
                    .lineLimit(1)
            })
            .sheet(isPresented: $showXiangMuNameView, content: {
                XiangMuInfoView(isSheetView: true, xiangMu: xiangMu, mingCheng: xiangMu.mingCheng ?? "", beiZhu: xiangMu.beiZhu ?? "", renyuanArray: xiangMu.renYuanArray)
            })
            .buttonStyle(.borderless)
        }
    }
    private struct ZhiWuButtonView: View {
        let zhiWu: FetchedResults<ZhiWu>.Element!
        @State private var showZhiWuNameView: Bool = false
        let name: String
        var body: some View {
            Button(action: {
                self.showZhiWuNameView = true
            }, label: {
                Text(name)
                    .frame(maxWidth: 65, alignment: .leading)
                    .lineLimit(1)
            })
            .sheet(isPresented: $showZhiWuNameView, content: {
                ZhiWuInFoView(isSheetView: true, zhiWu: zhiWu, mingCheng: zhiWu.mingCheng ?? "", beiZhu: zhiWu.beiZhu ?? "", renyuanArray: zhiWu.renYuanArray)
            })
            .buttonStyle(.borderless)
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { liuShuis[$0] }.forEach(viewContext.delete)

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

struct LiushuiView_Previews: PreviewProvider {
    static var previews: some View {
        LiushuiView()
    }
}
