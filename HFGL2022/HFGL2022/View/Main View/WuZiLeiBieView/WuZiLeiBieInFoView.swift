//
//  WuZiLeiBieInFoView.swift
//  HFGL2022
//
//  Created by nwy on 2023/12/30.
//

import SwiftUI

struct WuZiLeiBieInFoView: View {
    let wuZiLeiBie: FetchedResults<WuZiLeiBie>.Element
    @Environment(\.dismiss) var dismiss
    @State var edit: Bool = false
    
    @State var mingCheng: String
    @State var beiZhu: String
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack {
                        if !edit {
                            Text("名称：")
                            Text(wuZiLeiBie.mingCheng!)
                                .foregroundColor(.gray)
                        }
                        else {
                            Text("名称：")
                            TextField("输入类别名称", text: $mingCheng)
                        }
                    }
                }
                Section {
                    VStack (alignment: .leading) {
                        if !edit {
                            Text("备注：")
                            Text(beiZhu)
                                .foregroundColor(.gray)
                        }
                        else {
                            Text("备注：")
                            TextEditor(text: $beiZhu)
                                .frame(height: 140)
                        }
                    }
                }
                Section ("该类别的物品（\(wuZiLeiBie.wuZi?.count ?? 0)人）：") {
                    ForEach(wuZiLeiBie.wuZiArray, id: \.self) { i in
                        wuZiCellView(wuZi: i)
                    }
                }
            }
        }
    }
    private struct wuZiCellView: View {
        @State var showWuZiView: Bool = false
        let wuZi: WuZi
        var body: some View {
            Button {
                self.showWuZiView = true
            } label: {
                Text(wuZi.wName)
            }
            .sheet(isPresented: $showWuZiView) {
                WuZiInfoView(wuZiID: wuZi.id!)
            }
        }
    }
}

//#Preview {
//    WuZiLeiBieInFoView()
//}
