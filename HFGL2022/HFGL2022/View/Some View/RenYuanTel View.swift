//
//  RenYuanTel View.swift
//  HFGL2022
//
//  Created by nwy on 2022/12/4.
//

import SwiftUI

struct RenYuanTel_View: View {
    let telArray: [Tel]
    let telLeiXing: String
    var body: some View {
        List{
            ForEach(telArray, id: \.self, content: {
                tel in
                if tel.wHaoMa != "无电话号码的" {
                    VStack(alignment: .leading){
                        Text("\(tel.leiXing ?? "手机")")
                            .font(.system(size: 16))
                        Button(action: {
    //                        拨打电话
                        }, label: {
                            Text("\(tel.wHaoMa)")
                                .font(.system(size: 20))
                        })
                    }
                }
            })
        }
    }
}

//struct RenYuanTel_View_Previews: PreviewProvider {
//    static var previews: some View {
//        RenYuanTel_View()
//        RenYuanTel_View(telArray: [Tel], telLeiXing: "手机")
//    }
//}
