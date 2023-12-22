//
//  RenYuanInfoImageName View.swift
//  HFGL2022
//
//  Created by nwy on 2022/12/3.
//

import SwiftUI

struct RenYuanInfoImageName_View: View {
    
    let image: String
    let name: String
    let xingBie: Bool
    let jiaZhao: String
    let xiangMuArray: [XiangMu]
    let zhiWu: String
    let zaiZhi: Bool
    let baoXian: Bool
    let baoXianRiQi: Date
    let baoXianShiChang: Int16
    
    var body: some View {
        HStack(alignment: .top){
            Image("\(image)")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60)
                .cornerRadius(30)
                .padding(.leading)
//                .shadow(radius: 8)
            VStack(alignment: .leading){
                HStack{
                    Text(" \(name) ")
                        .font(.system(size: 22))
                    if xingBie {
                        Image(systemName: "star")
                            .foregroundColor(.blue)
                    }else{Image(systemName: "star").foregroundColor(.red)}
                    if jiaZhao != "无驾照" && jiaZhao == "B照" {
                        LabelView(title: "\(jiaZhao)", color: Color.orange)
                    }else if jiaZhao != "无驾照" && jiaZhao == "C照" {
                        LabelView(title: "\(jiaZhao)", color: Color.blue)
                    }
                    if !baoXian {LabelView(title: "无保险", color: Color.red)}
//                    计算保险过期
                    let calendar = Calendar.current
                    let startDate = baoXianRiQi
                    let endDate = Date()
                    let components = calendar.dateComponents([.day], from: startDate, to: endDate)
                    let shiJianCha = components.day ?? 360
                    if baoXian && shiJianCha >= baoXianShiChang * 30 {
                        LabelView(title: "保险过期", color: Color.red)
                    }else if baoXian && shiJianCha < (baoXianShiChang * 30) && shiJianCha >= (baoXianShiChang * 30) - 7 {
                        LabelView(title: "保险即将过期", color: .orange)
                    }
                }
                .padding(.bottom, 1)
                HStack(alignment: .top){
                    ForEach(xiangMuArray, id: \.self, content: {
                        xiangmu in
                        if xiangmu.wName != "" {
                            LabelView(title: xiangmu.wName, color: Color("wwysW"))
                        }
                    })
                    if zhiWu != "" {
                        LabelView(title: zhiWu, color: Color("wwysW"))
                    }
                    if !zaiZhi {
                        LabelView(title: "离职", color: Color.red)
                    }
                }
            }
            .padding(.leading, 4)
            Spacer()
        }
        .padding(.bottom, 10)
        .offset(y: 10)
//        .shadow(radius: 6)
    }
}

struct LabelView: View {
    let title: String
    let color: Color
    var body: some View{
        Button {
            
        } label: {
            Text(title)
                .font(.system(size: 16))
                .foregroundColor(.white)
                .background(color)
                .cornerRadius(6)
        }
        .buttonStyle(.borderless)
    }
}


//struct RenYuanInfoImageName_View_Previews: PreviewProvider {
//    static var previews: some View {
//        RenYuanInfoImageName_View(image: "touxiang111", name: "人员姓名1", xingBie: true, jiaZhao: "B", xiangMuArray: [XiangMu.wName], zhiWu: "职务1", baoXian: false)
//    }
//}
