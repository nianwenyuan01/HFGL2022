//
//  YouListView.swift
//  HFGL2022
//
//  Created by nwy on 2023/12/8.
//

import SwiftUI
import CoreData

struct YouListView: View {
    @State private var showAddYouView = false
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \LiuShui.riQiShiJian, ascending: false)], animation: .default)
    var yous: FetchedResults<LiuShui>
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \WuZi.mingCheng, ascending: false)], animation: .default)
    var wuZis: FetchedResults<WuZi>
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(yous) { you in
                    if you.youChuRu == "出库" {
                        let cheArray = ["车", "车辆"]
                        let oneTrue = cheArray.contains { $0 == you.wuZi?.leiBie?.mingCheng }
                        if oneTrue {
                            NavigationLink {
                                
                            } label: {
                                VStack {
                                    HStack {
                                        Spacer()
                                        Text(you.riQiShiJian?.dateString() ?? "未知")
                                            .font(.caption2)
                                            .foregroundColor(.gray)
                                    }
                                    HStack {
                                        Text(you.wuZi?.wName == "" ? "未知" : you.wuZi?.wName ?? "")
                                        if you.youYouKuJiaYouZhan == "油库" {
                                            ForEach(wuZis, id: \.self) { i in
                                                if i.id == you.youDiDian {
                                                    Text(i.mingCheng!)
                                                }
                                            }
                                        } else {
                                            Text("加油站")
                                        }
                                        
                                        Spacer()
                                        Text("\(you.youSuLiang)")
                                    }
                                }
                            }
                        }
                    }
                    if you.youChuRu == "入库" {
                        NavigationLink {
                            
                        } label: {
                            VStack {
                                HStack {
                                    Spacer()
                                    Text(you.riQiShiJian?.dateString() ?? "未知")
                                        .font(.callout)
                                        .foregroundColor(.gray)
                                }
                                HStack {
                                    Text("入库")
                                    Text(you.youLeiXing ?? "")
                                    ForEach(wuZis, id: \.self) { wuZi in
                                        if wuZi.id == you.youDiDian {
                                            Text(wuZi.mingCheng!)
                                        }
                                    }
                                    Text(you.wuZi?.wName == "" ? "未知" : you.wuZi?.wName ?? "")
                                    Spacer()
                                    Text("\(you.youSuLiang)")
                                }
                            }
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: {
                        self.showAddYouView = true
                    }, label: {
                        Image(systemName: "plus")
                    })
                    .fullScreenCover(isPresented: $showAddYouView, content: {
                        AddYouView()
                    })
                }
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { yous[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
}

#Preview {
    YouListView()
}
