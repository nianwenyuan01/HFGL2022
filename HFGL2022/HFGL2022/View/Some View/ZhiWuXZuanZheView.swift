//
//  ZhiWuXZuanZheView.swift
//  HFGL2022
//
//  Created by nwy on 2022/12/10.
//

import SwiftUI

//struct ZhiWuXZuanZheView: View {
//    
//    @Environment(\.dismiss) var dismiss2
//    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \ZhiWu.mingCheng, ascending: true)], animation: .default)
//    var zhiWus: FetchedResults<ZhiWu>
//    var body: some View {
//        NavigationStack{
//            List{
//                ForEach(zhiWus, id: \.self, content: {
//                    zhiwu in
//                    Text("\(zhiwu.mingCheng ?? "")")
//                })
//            }
//            .navigationTitle("选择职务")
//            .navigationBarTitleDisplayMode(.inline)
//            .toolbar(content: {
//                ToolbarItem(placement: .navigationBarLeading, content: {
//                    Button(action: {
//                        dismiss2()
//                    }, label: {
//                        Text("取消")
//                    })
//                })
//            })
//        }
//    }
//}

//struct ZhiWuXZuanZheView_Previews: PreviewProvider {
//    static var previews: some View {
//        ZhiWuXZuanZheView()
//    }
//}
