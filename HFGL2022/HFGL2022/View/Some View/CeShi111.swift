//
//  CeShi111.swift
//  HFGL2022
//
//  Created by nwy on 2024/1/1.
//

import SwiftUI

struct Item: Identifiable {
    let id = UUID()
    let name: String
}

struct CeShi111: View {
    @State private var items = [
        Item(name: "Apple"),
        Item(name: "Banana"),
        Item(name: "Cherry"),
        Item(name: "Durian")
    ]
    
    @State private var showingDeleteAlert = false
    @State private var toBeDeleted: IndexSet?
    
    var body: some View {
        List {
            ForEach(items) { item in
                Text(item.name)
            }
            .onDelete(perform: deleteRow)
        }
        .alert(isPresented: $showingDeleteAlert) {
            Alert(
                title: Text("确认删除"),
                message: Text("您确定要删除所选的项目吗？"),
                primaryButton: .destructive(Text("删除")) {
                    if let indexSet = toBeDeleted {
                        items.remove(atOffsets: indexSet)
                    }
                },
                secondaryButton: .cancel()
            )
        }
    }
    
    func deleteRow(at indexSet: IndexSet) {
        toBeDeleted = indexSet
        showingDeleteAlert = true
    }
}


#Preview {
    CeShi111()
}
