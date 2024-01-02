//
//  WuZiLeiBieView.swift
//  HFGL2022
//
//  Created by nwy on 2022/12/24.
//

import SwiftUI
import CoreData

struct WuZiLeiBieView: View {
    @Environment(\.dismiss) var dismiss
    @State private var isShowAddNewWuZiLeiBieView: Bool = false
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \WuZiLeiBie.mingCheng, ascending: true)], animation: .default)
    var leiBies: FetchedResults<WuZiLeiBie>
    var body: some View {
        NavigationStack{
            List(content: {
                
                Section ("自定义分类") {
                    ForEach(leiBies, id: \.self, content: {
                        leiBie in
                        if leiBie.mingCheng != "车辆" && leiBie.mingCheng != "油库" {
                            NavigationLink(destination: {WuZiLeiBieInFoView(wuZiLeiBie: leiBie, mingCheng: leiBie.mingCheng!, beiZhu: leiBie.beiZhu ?? "")}, label: {
                                Text(leiBie.mingCheng ?? "")
                            })
                        }
                    }).onDelete(perform: deleteItems)
                }
                Section ("系统默认分类") {
                    ForEach(leiBies, id: \.self) { leiBie in
                        if leiBie.mingCheng == "车辆" || leiBie.mingCheng == "油库" {
                            NavigationLink(destination: {WuZiLeiBieInFoView(wuZiLeiBie: leiBie, mingCheng: leiBie.mingCheng!, beiZhu: leiBie.beiZhu ?? "")}, label: {
                                Text(leiBie.mingCheng ?? "")
                            })
                        }
                    }
                }
            })
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing,  content: {
                    EditButton()
                })
                ToolbarItem(content: {
                    Button(action: {
                        isShowAddNewWuZiLeiBieView = true
                    }, label: {
                        Image(systemName: "plus")
                    })
                    .sheet(isPresented: $isShowAddNewWuZiLeiBieView) {
                        AddWuZhiLeiBieView()
                    }
                })
            })
            .navigationTitle("物资类别列表")
            .navigationBarTitleDisplayMode(.inline)
            Text("Select an item")
        }
    }
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { leiBies[$0] }.forEach(viewContext.delete)

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

struct WuZiLeiBieView_Previews: PreviewProvider {
    static var previews: some View {
        WuZiLeiBieView()
    }
}
