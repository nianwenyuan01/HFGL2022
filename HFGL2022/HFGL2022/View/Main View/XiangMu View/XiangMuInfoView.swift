//
//  XiangMuInfoView.swift
//  HFGL2022
//
//  Created by nwy on 2022/12/16.
//

import SwiftUI

struct XiangMuInfoView: View {
    let isSheetView: Bool
    let xiangMu: FetchedResults<XiangMu>.Element
    @State private var isShowAlert1: Bool = false
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss1
    @State var mingCheng: String
    @State var beiZhu: String
    @State var renyuanArray: [RenYuan]
    var body: some View {
        NavigationStack {
            List {
                Section(content: {
                    HStack{
                        Text("项目名称：")
                            .foregroundColor(Color("wwysBlack"))
                        if isSheetView {
                            Text(mingCheng)
                                .foregroundColor(Color.gray)
                        }else{
                            TextField("请输入项目名称", text: $mingCheng)
                                .foregroundColor(Color.gray)
                        }
                    }
                })
                Section(content: {
                    VStack(alignment: .leading){
                        Text("备注：")
                            .foregroundColor(Color("wwysBlack"))
                        if isSheetView {
                            Text(beiZhu)
                                .frame(height: 140)
                        }else{
                            TextEditor(text: $beiZhu)
                                .frame(height: 140)
                        }
                    }
                })
                Section("该部门人员（\(xiangMu.renYuan?.count ?? 0)人）：", content: {
                    ForEach(xiangMu.renYuanArray, id: \.self, content: {
                        i in
                        renYuanCellView(renyuan: i)
                        
                        
                        
                    })
                })
            }
//            滑动隐藏键盘
            .gesture(
            DragGesture()
                .onChanged{
                    _ in
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                                    to: nil,
                                                    from: nil,
                                                    for: nil)
                }
            )
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing:
                HStack {
                    //Spacer()
                    //EditButton()
                    Spacer()
                if isSheetView {
                    Button(action: {
                        dismiss1()
                    }, label: {
                        Image(systemName: "star")
                    })
                }else{
                    Button(action: {
                        if xinXiPanDuan() {
                            editZhiWuAction()
                        }else{
                            self.isShowAlert1.toggle()
                        }
//                        self.editMode?.wrappedValue = .active == self.editMode?.wrappedValue ? .inactive : .active
                    }) {
                        Text("保存")
//                        Text(.active == self.editMode?.wrappedValue ? "Done" : "Edit")
                    }
                }
                    Spacer()
            })
            .listStyle(.grouped)
            .alert(isPresented: self.$isShowAlert1, content: {
                Alert(title: Text("请完善信息"), message: Text("提示：红色的项目为必填项。"))
            })
        }
    }
    private struct renYuanCellView: View {
        @State var showRenYuanView: Bool = false
        let renyuan: RenYuan
        var body: some View {
            Button(action: {
                self.showRenYuanView = true
            }, label: {
                Text(renyuan.wName)
            })
            .sheet(isPresented: $showRenYuanView, content: {
                RenYuanInfo(isShowDismissButton: true, viewSheetMolde: false, renYuanId: renyuan.id!)
            })
        }
    }
    
    private func xinXiPanDuan() -> Bool {
        if mingCheng == "" {
            return false
        }else{return true}
    }
    private func editZhiWuAction() {
        if xiangMu.mingCheng != mingCheng {
            LiuShuiJiLu_RenYuan(newLiuShui: LiuShui(context: viewContext), renyuan: nil, zhiwu: nil, xiangmu: xiangMu, lieBie: "项目_更名", beizhu: nil, houbeizhu: nil, sanRenYuan: nil, sanWuZi: nil, sanXiangMu: mingCheng, sanZhiWu: nil, qianZhiWu: nil, qianXiangMu: xiangMu.mingCheng ?? "")
            xiangMu.mingCheng = mingCheng
        }
        if xiangMu.beiZhu != beiZhu {
            xiangMu.beiZhu = beiZhu
        }
        do{
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        dismiss1()
    }
}

