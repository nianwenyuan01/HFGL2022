//
//  RenYuanSuJuInfo View.swift
//  HFGL2022
//
//  Created by nwy on 2022/12/4.
//

import SwiftUI

struct RenYuanSuJuInfo_View: View {

    let liZhiYuanYin: String
    let chuShengRiQi: Date
    let hunYin: Bool
    let wenHua: String
    let ruZhiShiJian: Date
    let baoXian: Bool
    let baoXianRiQi: Date
    let baoXianShiChang: Int16
    let shenFenZheng: String
    let zhuZhi: String
    let beiZhu: String
    let telArray: [Tel]
    let wuZiArray: [WuZi]
    let liuShuiArray: [LiuShui]
    
    var body: some View {
        List{
            Section(content: {
                LiZhiYuanYinView(liZhiYuanYin: liZhiYuanYin)
            })
            Section(content: {
                VStack(alignment: .leading, content: {
                    listHeaderText(title: "联系方式：")
                })
                TelView(telArray: telArray)
            })
            Section(content: {
                VStack(alignment: .leading, content: {
                    listHeaderText(title: "基本信息：")
                    JiBenXinXiView(chuShengRiQi: chuShengRiQi, hunYin: hunYin, wenHua: wenHua, ruZhiShiJian: ruZhiShiJian,baoXian: baoXian,  baoXianRiQi: baoXianRiQi, baoXianShiChang: baoXianShiChang, shenFenZheng: shenFenZheng, zuZhi: zhuZhi)
                })
            })
            Section(content: {
                VStack(alignment: .leading, content: {
                    listHeaderText(title: "入职时配发物资：")
                })
                if !liuShuiArray.isEmpty {
                    ForEach(liuShuiArray, id: \.self, content: {
                        liuShui in
                        if liuShui.leiBie == "入职配发" && !liuShui.guiHuan {
                            ruZhiPeiFaView(riQi: liuShui.riQiShiJian ?? Date(), leiBie: liuShui.leiBie ?? "未分配的", wuZiMingCheng: liuShui.wuZi?.wName ?? "已删除的", suLiang: liuShui.suLiang , danWei: liuShui.wuZi?.danWei ?? "未知")
                        }
                        
                    })
                }else{Text("    暂无记录").foregroundColor(Color.gray)}
            })
            Section(content: {
                VStack(alignment: .leading, content: {
                    listHeaderText(title: "备注：")
                    Text("    \(beiZhu)")
                        .foregroundColor(.gray)
                        .lineLimit(5)
                })
            })
            
//                    Section(content: {
//                        VStack(alignment: .leading, content: {
//                            listHeaderText(title: "疾病或先天缺陷：")
//                            Text("心脏病")
//                                .foregroundColor(.gray)
//                                .lineLimit(5)
//                        })
//                    })
//                    Section(content: {
//                        VStack(alignment: .leading, content: {
//                            listHeaderText(title: "紧急联系信息：")
//                            Text("联系人：吴文员")
//                                .foregroundColor(.gray)
//                                .lineLimit(5)
//                            Button(action: {}, label: {
//                                HStack{
//                                    Text("联系人电话：")
//                                        .foregroundColor(.gray)
//                                    Text("13328333578")
//                                }
//
//                            })
//                            Text("联系人证件号：35058219860427598X")
//                                .foregroundColor(.gray)
//                                .lineLimit(5)
//                        })
//                    })
            
        }
        
        
        .listStyle(.grouped)
//                .listSectionSeparator(.hidden)
    }
}


struct JiBenXinXiView: View {
    let chuShengRiQi: Date
    let hunYin: Bool
    let wenHua: String
    let ruZhiShiJian: Date
    let baoXian: Bool
    let baoXianRiQi: Date
    let baoXianShiChang: Int16
    let shenFenZheng: String
    let zuZhi: String
    //年龄及时间差计算
    var body: some View {
        let calendar = Calendar.current
        let nianLingStartDate = chuShengRiQi
        let now = Date()
        let nianling = calendar.dateComponents([.month], from: nianLingStartDate, to: now)
        let shiJianCha1 = nianling.month ?? 0
        let gongLingStartDate = ruZhiShiJian
        let gongling = calendar.dateComponents([.month], from: gongLingStartDate, to: now)
        let shiJianCha2 = gongling.month ?? 0
        HStack(content: {
            if shiJianCha1 != 0 {
                Text(" \(shiJianCha1 / 12)岁")
            }
            if hunYin {
                Text(" 已婚")
            }else{Text(" 未婚")}
            if wenHua != "" {
                Text(" \(wenHua)文化")
            }
        })
        .foregroundColor(.gray)
        .padding(.top, 8)
        .padding(.bottom, 12)
        
        Text("入职时间： \(ruZhiShiJian.dateString())").foregroundColor(.gray)
            .padding(.bottom, 1)
        Text("工龄： \(shiJianCha2)个月").foregroundColor(.gray)
            .padding(.bottom, 12)
        if baoXian {
            Text("保险生效： \(baoXianRiQi.dateString())").foregroundColor(.gray)
                .padding(.bottom, 1)
            Text("保险时长： \(baoXianShiChang)个月").foregroundColor(.gray)
                .padding(.bottom, 12)
        }
        
        Text("证件号：\(shenFenZheng)").foregroundColor(.gray)
            .padding(.bottom, 1)
        HStack(alignment: .top){
            Text("家庭住址：")
            Text("\(zuZhi)")
                .lineLimit(3)
        }.foregroundColor(.gray)
    }
}
struct LiZhiYuanYinView: View {
    let liZhiYuanYin: String
    var body: some View {
        if liZhiYuanYin != "" {
            VStack(alignment: .leading){
                listHeaderText(title: "离职原因：")
                Text("    \(liZhiYuanYin)")
                    .foregroundColor(.gray)
                    .lineLimit(5)
            }
        }
    }
}
struct ruZhiPeiFaView: View {
    let riQi: Date
    let leiBie: String
    let wuZiMingCheng: String
    let suLiang: Int16
    let danWei: String
    
    var body: some View {
        VStack(alignment: .leading){
            
            HStack{
                Text("\(riQi.dateString())")
                    .foregroundColor(.gray)
                    .font(.system(size: 16))
            }
            HStack{
//                Text("\(leiBie)")
//                Text("\(wuZiMingCheng)").foregroundColor(.blue)
                Button(action: {}, label: {
                    Text("\(wuZiMingCheng)")
                })
                Spacer()
                Text("\(suLiang)").foregroundColor(.gray)
                Text("\(danWei)").foregroundColor(.gray)
            }
        }
    }
}

struct listHeaderText: View {
    let title: String
    var body: some View {
        Text(title)
            .font(.system(size: 16))
            .padding(.bottom, 1)
    }
}

public extension Date {

    static func parse(_ string: String, format: String = "yyyy-MM-dd") -> Date {
        let dateFormatter = DateFormatter()
//        dateFormatter.timeZone = NSTimeZone.default
        dateFormatter.dateFormat = format

        let date = dateFormatter.date(from: string)!
        return date
    }

    func dateString(_ format: String = "yyyy年MM月dd日") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
//时间差，年龄计算（年）
func calculateAge(birthdate: Date, currentdate: Date) -> Int? {
    let calendar = Calendar.current
    let components = calendar.dateComponents([.year], from: birthdate, to: currentdate)
    if components.year ?? 0 >= 0 {
        return components.year
    } else {
        return 0
    }
    
}
//时间差，工龄计算（月）
func calculateWorkAge(ruZhiShiJian: Date, currentdate: Date) -> Int? {
    let calendar = Calendar.current
    let components = calendar.dateComponents([.month], from: ruZhiShiJian, to: currentdate)
    if components.month ?? 0 >= 0 {
        return components.month
    } else {
        return 0
    }
    
}
//struct RenYuanSuJuInfo_View_Previews: PreviewProvider {
//    static var previews: some View {
//        RenYuanSuJuInfo_View(liZhiYuanYin: "口角是非快速卷发哭啥哭文娟，dfanw，待可能我为我服务费半身不遂发布v地方", nianLing: 64, hunYin: true, wenHua: "初中", shenFenZheng: "3383762567894X", zhuZhi: "福建恶霸啊看见你问吧等你文娟恩分214号", beiZhu: "阿奎罗咖啡那看你方便就会被封了全部垃圾不垃圾处理不了钱啊阿里看见你浪费空间啊就看不来坑比起冷清了", telArray: [Tel], wuZiArray: [WuZi])
//    }
//}
