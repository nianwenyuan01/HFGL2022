//
//  WuZiInfoView.swift
//  HFGL2022
//
//  Created by nwy on 2022/12/17.
//

import SwiftUI
import CoreData

struct WuZiInfoView: View {
    
    
    @State var edit: Bool = false
    let wuZiID: UUID
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [], animation: .default)
    var wuZis: FetchedResults<WuZi>
    
    
    var body: some View {
        if !edit {
            ForEach(wuZis, id: \.self, content: {
                wuZi in
                if wuZi.id == wuZiID {
                    VStack{
                        WuZiSuJuView(wuZi: wuZi, danWei: wuZi.danWei ?? "", suLiang: wuZi.suLiang , xiangMu: wuZi.xiangMu?.mingCheng ?? "", bianHao: wuZi.bianHao ?? "", leiBie: wuZi.leiBie?.mingCheng ?? "", mingCheng: wuZi.mingCheng ?? "", tuPian: wuZi.tuPian ?? "",nengYuanLeiBie: wuZi.nengYuanLeiBie ?? "", pinPai: wuZi.pinPai ?? "", guiGe: wuZi.guiGe ?? "", ruKuShiJian: wuZi.ruKuShiJian ?? Date(), cunFangWeiZhi: wuZi.cunFangWeiZhi ?? "", baoxiu: wuZi.baoXiu, baoXiuQi: wuZi.baoXiuQi ?? Date(), baoZhi: wuZi.baoZhi, baoZhiQi: wuZi.baoZhiQi ?? Date(), caiGouDi: wuZi.caiGouDi ?? "", caiGouRen: wuZi.caiGouRen?.xingMing ?? "", renYuan: wuZi.renYuan?.xingMing ?? "")
                    }
                }
            })
        }
    }
}

struct WuZiInfoView_Previews: PreviewProvider {
    static var previews: some View {
        WuZiInfoView(wuZiID: UUID())
    }
}
