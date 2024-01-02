//
//  ShengMing.swift
//  HFGL2022
//
//  Created by nwy on 2023/12/27.
//

import SwiftUI



//物资类别
enum WuZiLeiXing {
    case 默认
    case 车辆
    case 油库
    
}
//职务
enum ZhiWuLeiXing {
case 默认
    case 司机
}



func autoWuZiBiaoTi(leixing: WuZiLeiXing, mingChengBool: Bool, mingCheng: String) -> String {
    switch leixing {
    case .默认:
        if !mingChengBool {
            return mingCheng
        } else {
            return "物品"
        }
    case .车辆:
        return "车辆"
    case .油库:
        return "油库"
    }
    
}
func autoRenYuanBiaoTi(leixing: ZhiWuLeiXing) -> String {
    switch leixing {
    case .默认:
        return "人员"
    case .司机:
        return "司机"
    }
}
