//
//  XiangMuXuanZheView.swift
//  HFGL2022
//
//  Created by nwy on 2022/12/9.
//

import SwiftUI

struct XiangMuXuanZheView: View {
    @Environment(\.dismiss) var dismiss2
    var body: some View {
        Button(action: {
            dismiss2()
        }, label: {
            Text("abc")
        })
        Text("项目选择view")
    }
}

struct XiangMuXuanZheView_Previews: PreviewProvider {
    static var previews: some View {
        XiangMuXuanZheView()
    }
}
