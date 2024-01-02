//
//  XiangMuView.swift
//  HFGL2022
//
//  Created by nwy on 2022/12/12.
//

import SwiftUI

struct XiangMuView: View {
    @State var showXiangMuView1: Bool = false
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \XiangMu.mingCheng, ascending: true)], animation: .default)
    var xiangMus: FetchedResults<XiangMu>
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(xiangMus) {xiangMu in
                    NavigationLink(destination: {
                        XiangMuInfoView(isSheetView: false, xiangMu: xiangMu, mingCheng: xiangMu.mingCheng ?? "", beiZhu: xiangMu.beiZhu ?? "", renyuanArray: xiangMu.renYuanArray)
                    }, label: {
                        Text(xiangMu.mingCheng!)
                    })
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing,  content: {
                    EditButton()
                })
                ToolbarItem(content: {
                    Button(action: {
//                        self.showModalRenYuanView = false
                        self.showXiangMuView1 = true
                    }) {
                        Image(systemName: "plus")
                    }.sheet(isPresented: self.$showXiangMuView1, content: {AddXiangMuView()})
                })
            })
            .navigationTitle("项目列表")
            .navigationBarTitleDisplayMode(.inline)
            Text("Select an item")
        }
    }
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { xiangMus[$0] }.forEach(viewContext.delete)

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
struct AddXiangMuView: View {
    @State private var isShowAlert1: Bool = false
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss1
    @State var mingCheng: String = ""
    @State var beiZhu: String = ""
    var body: some View {
        NavigationStack {
            List {
                Section(content: {
                    HStack{
                        Text("项目名称：")
                            .foregroundColor(Color("wwysBlack"))
                        TextField("请输入项目名称", text: $mingCheng)
                            .foregroundColor(Color.gray)
                    }
                })
                Section(content: {
                    VStack(alignment: .leading){
                        Text("备注：")
                            .foregroundColor(Color("wwysBlack"))
                        TextEditor(text: $beiZhu)
                            .frame(height: 140)
                    }
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
            .navigationBarItems(leading: Button(action: {
                dismiss1()
            }, label: {
                Text("取消")
            }), trailing:
                HStack {
                    //Spacer()
                    //EditButton()
                    Spacer()
                    Button(action: {
                        if xinXiPanDuan() {
                            addZhiWuAction()
                        }else{
                            self.isShowAlert1.toggle()
                        }
//                        self.editMode?.wrappedValue = .active == self.editMode?.wrappedValue ? .inactive : .active
                    }) {
                        Text("完成")
//                        Text(.active == self.editMode?.wrappedValue ? "Done" : "Edit")
                    }
                    Spacer()
            })
            .listStyle(.grouped)
            .alert(isPresented: self.$isShowAlert1, content: {
                Alert(title: Text("提示"), message: Text("请完善信息"))
            })
        }
    }
    private func xinXiPanDuan() -> Bool {
        if mingCheng == "" {
            return false
        }else{return true}
    }
    private func addZhiWuAction() {
        let newXiangMu = XiangMu(context: viewContext)
        newXiangMu.mingCheng = mingCheng
        newXiangMu.beiZhu = beiZhu
        newXiangMu.id = UUID()
        LiuShuiJiLu_RenYuan(newLiuShui: LiuShui(context: viewContext), renyuan: nil, zhiwu: nil, xiangmu: newXiangMu, lieBie: "项目_创建", beizhu: nil, houbeizhu: nil, sanRenYuan: nil, sanWuZi: nil, sanXiangMu: mingCheng, sanZhiWu: nil, qianZhiWu: nil, qianXiangMu: nil)
        do{
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        dismiss1()
    }
}
struct XiangMuView_Previews: PreviewProvider {
    static var previews: some View {
        XiangMuView()
    }
}
