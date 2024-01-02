//
//  WuZiView.swift
//  HFGL2022
//
//  Created by nwy on 2022/12/3.
//

import SwiftUI
import CoreData

struct WuZiView: View {
    @State private var showAddWuZiView1 = false
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \WuZi.mingCheng, ascending: true)], animation: .default)
    var wuZis: FetchedResults<WuZi>
    
    
    @State private var showingDeleteAlert = false
    @State private var toBeDeleted: [WuZi] = []
    
    
    var body: some View {
        
        
        
        NavigationStack {
            Button {
                print("\(creatDict())")
            } label: {
                Text("3333333")
            }

            List {
                let aaa = creatDict().map {return $0.0}
                let sortaaa = aaa.sorted()
                ForEach(sortaaa.indices, id: \.self) { index in
                    NavigationLink {
                        if creatDict()[sortaaa[index]]! > 1 {
                            WuZiViewErJi(sortaaa: sortaaa, index: index)
                            
                            
                            
                            
                        } else {
                            ForEach(wuZis, id: \.self) { wuZi in
                                if wuZi.mingCheng == sortaaa[index] {
                                    WuZiSuJuView(wuZi: wuZi, isSheetMolde: false, danWei: wuZi.danWei ?? "", suLiang: wuZi.suLiang , xiangMu: wuZi.xiangMu?.mingCheng ?? "", bianHao: wuZi.bianHao, leiBie: wuZi.leiBie?.mingCheng ?? "", mingCheng: wuZi.mingCheng ?? "", tuPian: wuZi.tuPian ?? "",nengYuanLeiBie: wuZi.nengYuanLeiBie ?? "", pinPai: wuZi.pinPai ?? "", guiGe: wuZi.guiGe ?? "", ruKuShiJian: wuZi.ruKuShiJian ?? Date(), cunFangWeiZhi: wuZi.cunFangWeiZhi ?? "", baoxiu: wuZi.baoXiu, baoXiuQi: wuZi.baoXiuQi ?? Date(), baoZhi: wuZi.baoZhi, baoZhiQi: wuZi.baoZhiQi ?? Date(), caiGouDi: wuZi.caiGouDi ?? "", caiGouRen: wuZi.caiGouRen?.xingMing ?? "", renYuan: wuZi.renYuan?.xingMing ?? "")
                                }
                            }

                            
//                            WuZiSuJuView(wuZi: wuZi!, isSheetMolde: false, danWei: wuZi?.danWei ?? "", suLiang: wuZi?.suLiang ?? 1, xiangMu: wuZi?.xiangMu?.mingCheng ?? "", bianHao: wuZi?.bianHao ?? "", leiBie: wuZi?.leiBie?.mingCheng ?? "", mingCheng: wuZi?.mingCheng ?? "", tuPian: wuZi?.tuPian ?? "", nengYuanLeiBie: wuZi?.nengYuanLeiBie ?? "", pinPai: wuZi?.pinPai ?? "", guiGe: wuZi?.guiGe ?? "", ruKuShiJian: wuZi?.ruKuShiJian ?? Date(), cunFangWeiZhi: wuZi?.cunFangWeiZhi ?? "", baoxiu: wuZi?.baoXiu ?? false, baoXiuQi: wuZi?.baoXiuQi ?? Date(), baoZhi: wuZi?.baoZhi ?? false, baoZhiQi: wuZi?.baoZhiQi ?? Date(), caiGouDi: wuZi?.caiGouDi ?? "", caiGouRen: wuZi?.caiGouRen?.xingMing ?? "", renYuan: wuZi?.renYuan?.xingMing ?? "")
                        }
                    } label: {
                        HStack {
                            Text("\(sortaaa[index])")
                            Spacer()
                            Text("\(creatDict()[sortaaa[index]]!)")
                        }
                        .deleteDisabled(creatDict()[sortaaa[index]]! > 1 ? true : false)
                    }

                    
                    
                }.onDelete { indexSet in
                    for index in indexSet {
                        let mingChengToDelete = sortaaa[index]
                        let fetchRequest: NSFetchRequest<WuZi> = WuZi.fetchRequest()
                        fetchRequest.predicate = NSPredicate(format: "mingCheng == %@", mingChengToDelete)
                        do {
                            toBeDeleted = try viewContext.fetch(fetchRequest)
                            if toBeDeleted.isEmpty == false {
                                if toBeDeleted.count > 1 {
                                    showingDeleteAlert = true
                                } else {
                                    viewContext.delete(toBeDeleted.first!)
                                    do {
                                            try viewContext.save()
                                        } catch {
                                            print("Error saving: \(error)")
                                        }
                                }
                            }
                        } catch {
                            print("Error fetching: \(error)")
                        }
                    }
                }
                
                
                
                
                
                
//                ForEach(wuZis) { wuZi in
//                    NavigationLink {
//                        WuZiSuJuView(wuZi: wuZi, isSheetMolde: false, danWei: wuZi.danWei ?? "", suLiang: wuZi.suLiang , xiangMu: wuZi.xiangMu?.mingCheng ?? "", bianHao: wuZi.bianHao ?? "", leiBie: wuZi.leiBie?.mingCheng ?? "", mingCheng: wuZi.mingCheng ?? "", tuPian: wuZi.tuPian ?? "",nengYuanLeiBie: wuZi.nengYuanLeiBie ?? "", pinPai: wuZi.pinPai ?? "", guiGe: wuZi.guiGe ?? "", ruKuShiJian: wuZi.ruKuShiJian ?? Date(), cunFangWeiZhi: wuZi.cunFangWeiZhi ?? "", baoxiu: wuZi.baoXiu, baoXiuQi: wuZi.baoXiuQi ?? Date(), baoZhi: wuZi.baoZhi, baoZhiQi: wuZi.baoZhiQi ?? Date(), caiGouDi: wuZi.caiGouDi ?? "", caiGouRen: wuZi.caiGouRen?.xingMing ?? "", renYuan: wuZi.renYuan?.xingMing ?? "")
////                        Text("\(wuZi.id!)")
//                    } label: {
//                        HStack{
//                            Text(wuZi.mingCheng!)
//                            Spacer()
//                            Text("\(wuZi.suLiang)")
//                                .foregroundColor(.white)
//                                .font(.system(.headline))
//                                .frame(width: 40 , height: 18, alignment: .center)
//                                .minimumScaleFactor(0.5)
//                                .fixedSize(horizontal: true, vertical: true)
//                                .background(Color("wwysW"))
//                                .cornerRadius(9)
//                        }
//                        .padding(.trailing, 10)
//                    }
//                }
//                .onDelete(perform: deleteItems)
            }
            .alert(isPresented: $showingDeleteAlert, content: {
                Alert(title: Text("确认删除"), message: Text("您确定要删除所选的项目吗？"), primaryButton: .cancel(), secondaryButton: .destructive(Text("删除")) {
                    withAnimation {
                        for i in 0 ..< toBeDeleted.count {
                            viewContext.delete(toBeDeleted[i])
                        }
                        do {
                                try viewContext.save()
                            } catch {
                                print("Error saving: \(error)")
                            }
                    }
                })
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: {
                        self.showAddWuZiView1 = true
                    }, label: {
                        Image(systemName: "plus")
                    })
                    .fullScreenCover(isPresented: $showAddWuZiView1, content: {
                        AddWuZiView(leixing: WuZiLeiXing.默认, mingChengBool: true, bianHao: bianHaoJiSuan(wuZis: wuZis, mingCheng: ""))
                    })
                }
            }
            .listStyle(.grouped)
            .navigationTitle("物资总表")
            .navigationBarTitleDisplayMode(.inline)
            Text("Select an item")
        }
    }
    

//    func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { [$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
    private func creatDict() -> [String: Int] {
        var elementCountDict: [String: Int] = [:]
        for wuzi in wuZis {
            elementCountDict[wuzi.mingCheng!, default: 0] += 1
        }
        let sortedArray = elementCountDict.sorted {$0.0 < $1.0}
//        print(sortedArray)

        let keys = sortedArray.map {return $0.0 }
//        print(keys)

        let values = sortedArray.map {return $0.1 }
//        print(values)
        
        let dict = Dictionary(uniqueKeysWithValues: zip(keys, values))
        return dict
    }
    
    struct WuZiViewErJi: View {
        
        @Environment(\.managedObjectContext) private var viewContext
        @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \WuZi.mingCheng, ascending: true)], animation: .default)
        var wuZis: FetchedResults<WuZi>
        @State private var showAddWuZiView2 = false
        
        let sortaaa: [String]
        let index: Int
        
        var body: some View {
            NavigationStack {
                List {
                    ForEach(wuZis, id: \.self) { wuZi in
                        if wuZi.mingCheng == sortaaa[index] {
                            NavigationLink {
                                WuZiSuJuView(wuZi: wuZi, isSheetMolde: false, danWei: wuZi.danWei ?? "", suLiang: wuZi.suLiang , xiangMu: wuZi.xiangMu?.mingCheng ?? "", bianHao: wuZi.bianHao, leiBie: wuZi.leiBie?.mingCheng ?? "", mingCheng: wuZi.mingCheng ?? "", tuPian: wuZi.tuPian ?? "",nengYuanLeiBie: wuZi.nengYuanLeiBie ?? "", pinPai: wuZi.pinPai ?? "", guiGe: wuZi.guiGe ?? "", ruKuShiJian: wuZi.ruKuShiJian ?? Date(), cunFangWeiZhi: wuZi.cunFangWeiZhi ?? "", baoxiu: wuZi.baoXiu, baoXiuQi: wuZi.baoXiuQi ?? Date(), baoZhi: wuZi.baoZhi, baoZhiQi: wuZi.baoZhiQi ?? Date(), caiGouDi: wuZi.caiGouDi ?? "", caiGouRen: wuZi.caiGouRen?.xingMing ?? "", renYuan: wuZi.renYuan?.xingMing ?? "")
                            } label: {
                                HStack {
                                    Text(wuZi.mingCheng!)
                                    Text("# \(wuZi.bianHao)")
                                }
                            }
                        }
                    }.onDelete { indexSet in
                        indexSet.map{ wuZis[$0] }.forEach(viewContext.delete)
                        do {
                            try viewContext.save()
                        } catch {
                            let nsError = error as NSError
                            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                        }
                    }
                }
                .navigationTitle(sortaaa[index])
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                    ToolbarItem {
                        Button(action: {
                            showAddWuZiView2 = true
                        }, label: {
                            Image(systemName: "plus")
                        })
                        .fullScreenCover(isPresented: $showAddWuZiView2, content: {
                            AddWuZiView(leixing: WuZiLeiXing.默认, mingChengBool: false, bianHao: bianHaoJiSuan(wuZis: wuZis, mingCheng: sortaaa[index]), mingCheng: sortaaa[index])
                        })
                    }
                }
            }
        }
        
        
    }
    

}
//根据数据库内每种名称相同的物品都应该有不同的编号
func bianHaoJiSuan(wuZis: FetchedResults<WuZi>, mingCheng: String) -> Int32 {
    if mingCheng != "" {
        var bianHaoArray: [Int32] = []
        for i in wuZis {
            if i.mingCheng == mingCheng {
                bianHaoArray.append(i.bianHao)
            }
        }
        let sortedBianHaoArray = bianHaoArray.sorted()
        var int: Int32 = 1
        for i in sortedBianHaoArray {
            if int != i {
                break
            } else {
                int += 1
            }
        }
        return int
    }
    else {
        return 1
    }
}
//struct WuZiView_Previews: PreviewProvider {
//    static var previews: some View {
//        WuZiView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//
//    }
//}
