//
//  NaviHomeButton.swift
//  HFGL2022
//
//  Created by nwy on 2022/12/3.
//

import SwiftUI

struct NaviHomeButton: View {
    var dizhi: String
    let title: String
    let image: String
    let imageColor: Color
    let imagesize: CGSize = CGSize(width: 34, height: 34)
    let count: Int16
    let countsize: CGSize = CGSize(width: 30, height: 30)
    let countColor: Color
    let info: String
    let infoColor: Color
    var body: some View {
        VStack{
            NavigationLink(destination: {
                if dizhi == "人员列表页面"{RenYuanView()}
                if dizhi == "物资列表页面"{WuZiView()}
                if dizhi == "流水统计页面"{LiushuiView()}
                if dizhi == "异常列表页面"{YichangView()}
                if dizhi == "业务功能页面"{YeWu_PaiFa_View()}
            }, label: {
                VStack{
                    HStack{
                        Image(systemName: "\(image)")
                            .foregroundColor(.white)
                            .frame(width: imagesize.width, height: imagesize.height)
                            .background(imageColor)
                            .cornerRadius(imagesize.width / 5)
                        Spacer()
                        if count > 999 {
                            Text("\(count)")
                                .font(.system(.headline))
                                .foregroundColor(.white)
                                .frame(width: (countsize.width * 1.8), height: countsize.height)
                                .background(countColor)
                                .cornerRadius(countsize.width / 2)
                        }else{
                            if count > 99 {
                                Text("\(count)")
                                    .font(.system(.headline))
                                    .foregroundColor(.white)
                                    .frame(width: (countsize.width * 1.5), height: countsize.height)
                                    .background(countColor)
                                    .cornerRadius(countsize.width / 2)
                            }else{
                                if count == 0 {
//                                    不显示
                                }else{
                                    Text("\(count)")
                                        .font(.system(.headline))
                                        .foregroundColor(.white)
                                        .frame(width: countsize.width, height: countsize.height)
                                        .background(countColor)
                                        .cornerRadius(countsize.width / 2)
                                }
                            }
                        }
                    }
                    HStack{
                        Text(title)
                            .font(.system(.headline))
                            .foregroundColor(Color("wwysBlack"))
                            
//                            .foregroundColor(.black)
                        Spacer()
                        Text("\(info)")
                            .font(.system(.headline))
                            .foregroundColor(infoColor)
                    }
                }
            })
            .buttonStyle(.bordered)
            .controlSize(.large)
        }
    }
}

struct NaviHomeButton_Previews: PreviewProvider {
    static var previews: some View {
        NaviHomeButton(dizhi: "aBc", title: "就结束了", image: "star", imageColor: .orange, count: 13, countColor: .blue, info: "info", infoColor: .green)
    }
}
