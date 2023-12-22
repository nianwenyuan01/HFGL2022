//
//  WuZiView.swift
//  HFGL2022
//
//  Created by nwy on 2022/12/3.
//

import SwiftUI
import CoreData

struct WuZiView: View {
    @State private var showAddWuZiView = false
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \WuZi.mingCheng, ascending: true)], animation: .default)
    var wuZis: FetchedResults<WuZi>
    var body: some View {
        NavigationStack {
            List {
                ForEach(wuZis) { wuZi in
                    NavigationLink {
                        WuZiInfoView(wuZiID: wuZi.id!)
//                        Text("\(wuZi.id!)")
                    } label: {
                        HStack{
                            Text(wuZi.mingCheng!)
                            Spacer()
                            Text("\(wuZi.suLiang)")
                                .foregroundColor(.white)
                                .font(.system(.headline))
                                .frame(width: 40 , height: 18, alignment: .center)
                                .minimumScaleFactor(0.5)
                                .fixedSize(horizontal: true, vertical: true)
                                .background(Color("wwysW"))
                                .cornerRadius(9)
                        }
                        .padding(.trailing, 10)
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
                        self.showAddWuZiView = true
                    }, label: {
                        Image(systemName: "plus")
                    })
                    .fullScreenCover(isPresented: $showAddWuZiView, content: {
                        AddWuZiView(bianHao: String("#A0000\(bianHaoJiSuan())"))
                    })
                }
            }
            .listStyle(.grouped)
            .navigationTitle("物资总表")
            .navigationBarTitleDisplayMode(.inline)
            Text("Select an item")
        }
    }
    //根据数据库内物质的总数量（每个物质个数也算在内）计算编号，使它根据数量变化
    func bianHaoJiSuan() -> Int32 {
        var jiSuan: Int32 = 1
        for i in wuZis {
            jiSuan += i.suLiang
        }
        return jiSuan
    }
//    private func addItem() {
//        withAnimation {
//            let newWuZi = WuZi(context: viewContext)
//            newWuZi.mingCheng = "adddjjwl"
//            newWuZi.id = UUID()
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
            offsets.map { wuZis[$0] }.forEach(viewContext.delete)

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

struct WuZiView_Previews: PreviewProvider {
    static var previews: some View {
        WuZiView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)

    }
}
