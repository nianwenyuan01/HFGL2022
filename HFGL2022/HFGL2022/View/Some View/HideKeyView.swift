//
//  HideKeyView.swift
//  HFGL2022
//
//  Created by nwy on 2022/12/11.
//

import Foundation
import SwiftUI

extension TextField {
    
    /// 添加关闭键盘工具栏
    /// - Returns: 返回
    func wzz_makeToolBar() -> some View {
        return self.toolbar( content: {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button {
                    wzz_hideKeyboard()
                } label: {
                    Text("完成")
                }
            }
        })
    }
}

extension TextEditor {
    
    /// 添加关闭键盘工具栏
    /// - Returns: 返回
    func wzz_makeToolBar() -> some View {
        return self.toolbar(content: {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button {
                    wzz_hideKeyboard()
                } label: {
                    Text("完成")
                }
            }
        })
    }
}


extension View {
    /// 关闭键盘事件
    func wzz_hideKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}



