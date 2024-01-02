//
//  AddWuZiView.swift
//  HFGL2022
//
//  Created by nwy on 2022/12/22.
//

import SwiftUI
import CoreData

struct AddWuZiView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \WuZiLeiBie.mingCheng, ascending: true)], animation: .default)
    var leiBies: FetchedResults<WuZiLeiBie>
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \XiangMu.mingCheng, ascending: true)], animation: .default)
    var xiangMus: FetchedResults<XiangMu>
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \RenYuan.xingMing, ascending: true)], animation: .default)
    var renYuans: FetchedResults<RenYuan>
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \WuZi.mingCheng, ascending: true)], animation: .default)
    var wuZis: FetchedResults<WuZi>
    
    @Environment(\.dismiss) var dismissAddWuZiView
    @State private var isShowAlert1: Bool = false
    @State var showCaiGouRenXuanZheView: Bool = false
    @State var showLeiBieXuanZheView: Bool = false
    @State var showXiangMuXuanZheView: Bool = false
    
    let leixing: WuZiLeiXing
    let mingChengBool: Bool
    @State var danWei: String = "个"
    @State var suLiang: Int32 = 1
    @State var xiangMu: String = ""
    @State var bianHao: Int32
    @State var leiBie: String = ""
    @State var mingCheng: String = ""
    @State var nengYuanLeiBie: String = ""
    
    @State var pinPai: String = ""
    @State var guiGe: String = ""
    @State var ruKuShiJian: Date = Date()
    @State var cunFangWeiZhi: String = ""
    @State var baoxiu: Bool = false
    @State var baoXiuQi: Date = Date()
    @State var baoZhi: Bool = false
    @State var baoZhiQi: Date = Date()
    @State var caiGouDi: String = ""
    @State var caiGouRen: String = ""
    @State var inttt: Int = 10
 
    
    var body: some View {
        
        NavigationStack{
            Image("touxiang111")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60)
                .cornerRadius(30)
                .padding(.leading)
            List(content: {
                Group(content: {
//                    TextField("", value: $inttt, formatter: NumberFormatter())
//                    Button {
//                        ceshi(int: inttt)
//                    } label: {
//                        Text("sfsfsfsdfsdfsdfsdf")
//                    }

                    
                    Section(content: {
                        //名称
                        HStack{
                            if leiBie == "车辆" {
                                mingCheng == "" ? Text("名称：").foregroundColor(.red) : Text("名称：")
                                if mingChengBool {
                                    TextField("请输入车辆名称", text: $mingCheng)
                                        .foregroundColor(.gray)
                                } else {
                                    Text(mingCheng)
                                        .foregroundColor(.gray)
                                }
                            }
                            if leiBie == "油库" {
                                mingCheng == "" ? Text("名称：").foregroundColor(.red) : Text("名称：")
                                if mingChengBool {
                                    TextField("请输入油库名称", text: $mingCheng)
                                        .foregroundColor(.gray)
                                } else {
                                    Text(mingCheng)
                                        .foregroundColor(.gray)
                                }
                            }
                            if leiBie != "车辆" && leiBie != "油库" {
                                mingCheng == "" ? Text("名称：").foregroundColor(.red) : Text("名称：")
                                if mingChengBool {
                                    TextField("请输入物资名称", text: $mingCheng)
                                        .foregroundColor(.gray)
                                } else {
                                    Text(mingCheng)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .onChange(of: mingCheng) { newValue in
                            bianHao = bianHaoJiSuan(wuZis: wuZis, mingCheng: newValue)
                            print("\(newValue)")
                        }
                        //编号
                        HStack{
                            bianHao == 0 ? Text("编号：").foregroundColor(.red) : Text("编号：")
                            Text ("#").foregroundColor(.gray)
                            TextField("请输入编号", value: $bianHao, formatter: NumberFormatter())
                                .foregroundColor(.gray)
                        }
                        //数量，单位
                        HStack{
                            if leiBie == "车辆" {
                                suLiang == 0 ? Text("数量：").foregroundColor(.red) : Text("数量：")
                                Text("\(suLiang)")
                                    .frame(width: 80)
                                Text(danWei)
                                    .frame(width: 80)
                                Spacer()
                            }
                            if leiBie == "油库" {
                                suLiang == 0 ? Text("数量：").foregroundColor(.red) : Text("数量：")
                                TextField("请输入数量", value: $suLiang, formatter: NumberFormatter())
                                    .frame(width: 80)
                                Text(danWei)
                                    .frame(width: 80)
                                Spacer()
                            }
                            if leiBie != "车辆" && leiBie != "油库" {
                                suLiang == 0 ? Text("数量：").foregroundColor(.red) : Text("数量：")
                                TextField("请输入数量", value: $suLiang, formatter: NumberFormatter())
                                    .frame(width: 80)
                                TextField("单位", text: $danWei)
                                    .frame(width: 80)
                                Spacer()
                            }
                        }
                        //分类，类别
                        HStack{
                            if leixing != WuZiLeiXing.默认 {
                                if leiBie == "车辆" {
                                    leiBie == "" ? Text("分类：").foregroundColor(.red) : Text("分类：").foregroundColor(Color("wwysBlack"))
                                    Text(leiBie)
                                        .foregroundColor(.gray)
                                    Spacer()
                                }
                                if leiBie == "油库" {
                                    leiBie == "" ? Text("分类：").foregroundColor(.red) : Text("分类：").foregroundColor(Color("wwysBlack"))
                                    Text(leiBie)
                                        .foregroundColor(.gray)
                                    Spacer()
                                }
                            }
                            else {
                                if leiBie == "车辆" {
                                    leiBie == "" ? Text("分类：").foregroundColor(.red) : Text("分类：").foregroundColor(Color("wwysBlack"))
                                    Text(leiBie)
                                        .foregroundColor(.gray)
                                    Spacer()
                                    Button(action: {
                                        self.showLeiBieXuanZheView = true
                                    }, label: {
                                        leiBie == "" ? Text("选择类别") : Text("更改")
                                    }).sheet(isPresented: $showLeiBieXuanZheView, content: {
                                        LeiBieXuanZheView(leiBieGet: $leiBie)
                                    })
                                }
                                if leiBie == "油库" {
                                    leiBie == "" ? Text("分类：").foregroundColor(.red) : Text("分类：").foregroundColor(Color("wwysBlack"))
                                    Text(leiBie)
                                        .foregroundColor(.gray)
                                    Spacer()
                                    Button(action: {
                                        self.showLeiBieXuanZheView = true
                                    }, label: {
                                        leiBie == "" ? Text("选择类别") : Text("更改")
                                    }).sheet(isPresented: $showLeiBieXuanZheView, content: {
                                        LeiBieXuanZheView(leiBieGet: $leiBie)
                                    })
                                }
                                if leiBie != "车辆" && leiBie != "油库" {
                                    leiBie == "" ? Text("分类：").foregroundColor(.red) : Text("分类：").foregroundColor(Color("wwysBlack"))
                                    Text(leiBie)
                                        .foregroundColor(.gray)
                                    Spacer()
                                    Button(action: {
                                        self.showLeiBieXuanZheView = true
                                    }, label: {
                                        leiBie == "" ? Text("选择类别") : Text("更改")
                                    }).sheet(isPresented: $showLeiBieXuanZheView, content: {
                                        LeiBieXuanZheView(leiBieGet: $leiBie)
                                    })
                                }
                            }
                            
                        }
                        .onChange(of: leiBie) {newValue in
                            suLiang = 1
                            if leiBie == "车辆" {
                                danWei = "辆"
                            }
                            if leiBie == "油库" {
                                danWei = "升"
                            }
                            if leiBie != "车辆" && leiBie != "油库" {
                                danWei = "个"
                            }
                        }
                        HStack{
                            xiangMu == "" ? Text("所属部门：").foregroundColor(.red) : Text("所属部门：").foregroundColor(Color("wwysBlack"))
                            Text(xiangMu)
                                .foregroundColor(.gray)
                            Spacer()
                            Button(action: {
                                self.showXiangMuXuanZheView = true
                            }, label: {
                                xiangMu == "" ? Text("选择部门") : Text("更改")
                            }).sheet(isPresented: $showXiangMuXuanZheView, content: {
                                WuZhiXiangMuXuanZheView(xiangMuGet: $xiangMu)
                            })
                        }
                    })
                    Section(content: {
                        HStack{
                            Text("品牌：")
                            TextField("请输入品牌", text: $pinPai)
                                .foregroundColor(.gray)
                        }
                        VStack(alignment: .leading){
                            Text("规格：")
                            TextEditor(text: $guiGe)
                                .frame(height: 80)
                                .foregroundColor(.gray)
                        }
                        if leiBie == "车" || leiBie == "车辆" {
                            HStack {
                                Menu {
                                    Button(action: {nengYuanLeiBie = "汽油"}, label: {Text("汽油")})
                                    Button(action: {nengYuanLeiBie = "柴油"}, label: {Text("柴油")})
                                    Button(action: {nengYuanLeiBie = "新能源"}, label: {Text("新能源")})
                                } label: {
                                    nengYuanLeiBie == "" ? Text("能源类别：").foregroundColor(.red) : Text("能源类别：").foregroundColor(Color("wwysBlack"))
                                    Text("\(nengYuanLeiBie)")
                                        .foregroundColor(Color("wwysBlack"))
                                    Spacer()
                                    Text(nengYuanLeiBie == "" ? "请选择" : "更改")
                                }
                            }
                        }
                    })
                    Section(content: {
                        HStack{
                            DatePicker("入库时间：", selection: $ruKuShiJian, displayedComponents: .date)
                                .environment(\.locale, Locale(identifier: "zh_CN"))
                        }
                    })
                    Section(content: {
                        HStack{
                            Text("存放位置：")
                            TextField("请输入存放位置", text: $cunFangWeiZhi)
                                .foregroundColor(.gray)
                        }
                    })
                    Section(content: {
                        withAnimation {
                            Toggle(isOn: $baoxiu.animation(), label: {
                                if baoxiu {
                                    HStack{
                                        Text("保修：")
                                        Text("在保修期内")
                                            .foregroundColor(.green)
                                    }
                                }else{
                                    HStack{
                                        Text("保修：")
                                        Text("无保修")
                                            .foregroundColor(.gray)
                                    }
                                }
                            })
                        }
                        if baoxiu {
                            DatePicker("保修期至：", selection: $baoXiuQi, displayedComponents: .date)
                                .environment(\.locale, Locale(identifier: "zh_CN"))
                        }
                        if leiBie == "车" || leiBie == "车辆" {
                            withAnimation {
                                Toggle(isOn: $baoZhi.animation(), label: {
                                    if baoZhi {
                                        HStack{
                                            Text("年检：")
                                            Text("已年检")
                                                .foregroundColor(.green)
                                        }
                                    }else{
                                        HStack{
                                            Text("年检：")
                                            Text("无需年检")
                                                .foregroundColor(.gray)
                                        }
                                    }
                                })
                            }
                            if baoZhi {
                                DatePicker("年检到期：", selection: $baoZhiQi, displayedComponents: .date)
                                    .environment(\.locale, Locale(identifier: "zh_CN"))
                            }
                        } else {
                            withAnimation {
                                Toggle(isOn: $baoZhi.animation(), label: {
                                    if baoZhi {
                                        HStack{
                                            Text("保质期：")
                                            Text("在保质期内")
                                                .foregroundColor(.green)
                                        }
                                    }else{
                                        HStack{
                                            Text("保质期：")
                                            Text("无保质期")
                                                .foregroundColor(.gray)
                                        }
                                    }
                                })
                            }
                            if baoZhi {
                                DatePicker("保质期至：", selection: $baoZhiQi, displayedComponents: .date)
                                    .environment(\.locale, Locale(identifier: "zh_CN"))
                            }
                        }
                        
                    })
                    Section(content: {
                        HStack{
                            Text("采购地：")
                            TextField("请输入采购地", text: $caiGouDi)
                                .foregroundColor(.gray)
                        }
                    })
                    Section(content: {
                        HStack{
                            Text("采购人：")
                                .foregroundColor(Color("wwysBlack"))
                            Text("\(caiGouRen)")
                                .foregroundColor(.gray)
                            Spacer()
                            Button(action: {
                                self.showCaiGouRenXuanZheView = true
                            }, label: {
                                Text("更改")
                            }).sheet(isPresented: $showCaiGouRenXuanZheView, content: {
                                CaiGouRenXuanZheView(caiGouRenGet: $caiGouRen)
                            })
                        }
                    })
                    
                })
            })
            .textFieldStyle(.automatic)
            .gesture(
            DragGesture()
                .onChanged{
                    _ in
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                                    to: nil,
                                                    from: nil,
                                                    for: nil)
                }
            )
            .listStyle(.grouped)
            .navigationBarTitle("新增\(autoWuZiBiaoTi(leixing: leixing, mingChengBool: mingChengBool, mingCheng: mingCheng))")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button(action: {
                dismissAddWuZiView()
            }, label: {
                Text("取消")
            }), trailing: Button(action: {
                if editWuZiXinXiPanDuan() {
                    editWuZiDoneAndSave()
                    dismissAddWuZiView()
                }else{
                    self.isShowAlert1.toggle()
                }
                
            }, label: {
                Text("完成")
            }).disabled(!editWuZiXinXiPanDuan()))
            .alert(isPresented: self.$isShowAlert1, content: {
                Alert(title: Text("提示"), message: Text("请完善信息"))
            })
        }
        .onAppear {
            addLeiXingPanDuan(leixing: leixing)
        }
    }
    
    //判断添加类型来设定默认值
    func addLeiXingPanDuan(leixing: WuZiLeiXing) {
        
        switch leixing {
        case .车辆:
            var bool: Bool = true
            danWei = "辆"
            suLiang = 1
            //判断是否有车辆的默认类别，没有则创建一个，有则设置其分类为车辆
            for i in leiBies {
                if i.mingCheng == "车辆" {
                    bool = false
                }
            }
            if bool {
                let newLeiBie = WuZiLeiBie(context: viewContext)
                newLeiBie.id = UUID()
                newLeiBie.mingCheng = "车辆"
                newLeiBie.beiZhu = "此为系统级类别，无法修改或删除。"
                do{
                    try viewContext.save()
                } catch {
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
                leiBie = "车辆"
            } else {
                leiBie = "车辆"
            }
        case .油库:
            var bool: Bool = true
            danWei = "升"
            //判断是否有油库的默认类别，米有则创建一个，有则设置其分类为油库
            for i in leiBies {
                if i.mingCheng == "油库" {
                    bool = false
                }
            }
            if bool {
                let newLeiBie = WuZiLeiBie(context: viewContext)
                newLeiBie.id = UUID()
                newLeiBie.mingCheng = "油库"
                newLeiBie.beiZhu = "此为系统级类别，无法修改或删除。"
                do{
                    try viewContext.save()
                } catch {
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
                leiBie = "油库"
            } else {
                leiBie = "油库"
            }
        default: break
            
        }
    }
    
    func editWuZiXinXiPanDuan() -> Bool {
        if mingCheng == "" || suLiang < 0 ||  danWei == "" || leiBie == "" || xiangMu == "" {
            return false
        }
        if leiBie == "车" && nengYuanLeiBie == "" {
            return false
        }
        if leiBie == "车辆" && nengYuanLeiBie == "" {
            return false
        } else {return true}
    }
    func editWuZiDoneAndSave() {
        let newWuZi = WuZi(context: viewContext)
        newWuZi.id = UUID()
        newWuZi.mingCheng = mingCheng
        for i in leiBies {
            if i.mingCheng == leiBie {
                i.addToWuZi(newWuZi)
            }
        }
        newWuZi.bianHao = bianHao
        for i in xiangMus {
            if i.mingCheng == xiangMu {
                i.addToWuZi(newWuZi)
            }
        }
        newWuZi.suLiang = suLiang
        newWuZi.danWei = danWei
        newWuZi.pinPai = pinPai
        newWuZi.nengYuanLeiBie = nengYuanLeiBie
        newWuZi.guiGe = guiGe
        newWuZi.ruKuShiJian = ruKuShiJian
        newWuZi.cunFangWeiZhi = cunFangWeiZhi
        newWuZi.baoXiu = baoxiu
        newWuZi.baoXiuQi = baoXiuQi
        newWuZi.baoZhi = baoZhi
        newWuZi.baoZhiQi = baoZhiQi
        newWuZi.caiGouDi = caiGouDi
        for i in renYuans {
            if i.xingMing == caiGouRen {
                i.addToWuZi(newWuZi)
            }
        }
        LiuShuiJiLu_WuZi(newLiuShui: LiuShui(context: viewContext), wuZi: newWuZi, renYuan: nil, xiangMu: nil, leiBie: "物资_新增", beizhu: nil, houbeizhu: nil, sanRenYuan: nil, sanWuZi: newWuZi.mingCheng, sanXiangMu: nil)
        
        do{
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
//    func ceshi(int: Int) {
//        for i in 1...int {
//            let newWuZi = WuZi(context: viewContext)
//            newWuZi.id = UUID()
//            newWuZi.mingCheng = "mingCheng\(i)"
//            newWuZi.bianHao = "bianHao\(i)"
//            newWuZi.suLiang = 1 + Int32(i)
//            newWuZi.danWei = "danWei\(i)"
//            newWuZi.pinPai = "pinPai\(i)"
//            newWuZi.nengYuanLeiBie = "nengYuanLeiBie\(i)"
//            newWuZi.guiGe = "guiGe\(i)"
//            newWuZi.ruKuShiJian = Date()
//            newWuZi.cunFangWeiZhi = "cunFangWeiZhi\(i)"
//            newWuZi.baoXiu = false
//            newWuZi.baoZhi = false
//            newWuZi.caiGouDi = "caiGouDi\(i)"
//            
//            do{
//                try viewContext.save()
//            } catch {
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//        
//        
//    }
}

//struct AddWuZiView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddWuZiView()
//    }
//}
