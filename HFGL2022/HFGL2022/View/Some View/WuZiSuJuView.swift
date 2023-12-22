//
//  WuZiSuJuView.swift
//  HFGL2022
//
//  Created by nwy on 2022/12/17.
//

import SwiftUI
import CoreData

struct WuZiSuJuView: View {
    let wuZi: FetchedResults<WuZi>.Element
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \WuZiLeiBie.mingCheng, ascending: true)], animation: .default)
    var leiBies: FetchedResults<WuZiLeiBie>
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \XiangMu.mingCheng, ascending: true)], animation: .default)
    var xiangMus: FetchedResults<XiangMu>
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \RenYuan.xingMing, ascending: true)], animation: .default)
    var renYuans: FetchedResults<RenYuan>
    
    
    
    
    @State var edit: Bool = false
    @State private var isShowAlert1: Bool = false
    @State var showCaiGouRenXuanZheView: Bool = false
    @State var showLeiBieXuanZheView: Bool = false
    @State var showXiangMuXuanZheView: Bool = false
    
    
    
    
    
    
    
    
    @State var danWei: String
    @State var suLiang: Int32
    @State var xiangMu: String
    @State var bianHao: String
    @State var leiBie: String
    @State var mingCheng: String
    @State var tuPian: String
    
    
    
    @State var nengYuanLeiBie: String
    
    
    
    @State var pinPai: String
    @State var guiGe: String
    @State var ruKuShiJian: Date
    @State var cunFangWeiZhi: String
    @State var baoxiu: Bool
    @State var baoXiuQi: Date
    @State var baoZhi: Bool
    @State var baoZhiQi: Date
    @State var caiGouDi: String
    @State var caiGouRen: String
    @State var renYuan: String
    
    var body: some View {
        NavigationStack{
//            头部
            if edit {
                Image("touxiang111")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .cornerRadius(30)
                    .padding(.leading)
            }else{
                VStack{
                    HStack{
                        Image("touxiang111")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 60, height: 60)
                            .cornerRadius(30)
                            .padding(.leading)
            //                .shadow(radius: 8)
                        VStack{
                            HStack{
                                Text("\(mingCheng)")
                                    .font(.title2)
                                Spacer()
                            }
                            HStack{
                                Text("\(xiangMu)")
//                                    .font(.title3)
                                    .foregroundStyle(.gray)
                                Text(" \(leiBie) ")
//                                    .font(.title3)
                                    .foregroundStyle(.gray)
                                Spacer()
                            }
                        }
                        
                        Text("\(suLiang)")
                            .font(.title3)
                        Text("\(danWei)")
                            .font(.title3)
                            .padding(.trailing)
                    }
                        .padding(.leading, 4)
                        Spacer()
                    }
                .frame(height: 70)
                .offset(y: 10)
            }
            
                List(content: {
                    Group(content: {
//                        头部信息
                        if edit {
                            Section(content: {
                                HStack{
                                    mingCheng == "" ? Text("名称：").foregroundColor(.red) : Text("名称：")
                                    TextField("请输入物资名称", text: $mingCheng)
                                        .foregroundColor(.gray)
                                }
                                HStack{
                                    bianHao == "" ? Text("编号：").foregroundColor(.red) : Text("编号：")
                                    TextField("请输入物资编号", text: $bianHao)
                                        .foregroundColor(.gray)
                                }
                                HStack{
                                    suLiang == 0 ? Text("数量：").foregroundColor(.red) : Text("数量：")
                                    TextField("请输入数量", value: $suLiang, formatter: NumberFormatter())
                                    TextField("单位", text: $danWei)
                                        .frame(width: 50)
                                }
                                HStack{
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
                        }
                    })
                    Group(content: {
        //                品牌规格
                        Section(content: {
                            HStack{
                                Text("品牌：")
                                if edit {
                                    TextField("请输入品牌", text: $pinPai)
                                        .foregroundColor(.gray)
                                }else{Text("\(pinPai)").foregroundColor(.gray)}
                            }
                            VStack(alignment: .leading){
                                Text("规格：")
                                if edit {
                                    TextEditor(text: $guiGe)
                                        .foregroundColor(.gray)
                                        .frame(height: 80)
                                }else{
                                    Text(guiGe)
                                        .foregroundColor(.gray)
                                }
                            }
                            //能源类别
                            if leiBie == "车辆" || leiBie == "车" {
                                HStack {
                                    if edit {
                                        Menu {
                                            Button(action: {nengYuanLeiBie = "汽油"}, label: {Text("汽油")})
                                            Button(action: {nengYuanLeiBie = "柴油"}, label: {Text("柴油")})
                                            Button(action: {nengYuanLeiBie = "新能源"}, label: {Text("新能源")})
                                        } label: {
                                            nengYuanLeiBie == "" ? Text("能源类别：").foregroundColor(.red) : Text("能源类别：").foregroundColor(Color("wwysBlack"))
                                            Text("\(nengYuanLeiBie)")
                                                .foregroundColor(Color("wwysBlack"))
                                            Spacer()
                                            Text("更改")
                                        }
                                    } else {
                                        Text("能源类别：")
                                        Text("\(nengYuanLeiBie)")
                                            .foregroundColor(.gray)
                                    }
                                }
                            }
                            
                            if !edit {
                                HStack{
                                    Text("编号：")
                                    Text("\(bianHao)")
                                        .foregroundStyle(.gray)
//                                    Spacer()
                                }
                            }
                        })
        //                入库时间
                        Section(content: {
                            HStack{
                                if edit {
                                    DatePicker("入库时间：", selection: $ruKuShiJian, displayedComponents: .date)
                                        .environment(\.locale, Locale(identifier: "zh_CN"))
                                }else{
                                    Text("入库时间：")
                                    Text("\(ruKuShiJian.dateString())")
                                        .foregroundColor(.gray)
                                }
                            }
                        })
        //                存放位置
                        Section(content: {
                            HStack{
                                Text("存放位置：")
                                if edit {
                                    TextField("请输入存放位置", text: $cunFangWeiZhi)
                                        .foregroundColor(.gray)
                                }else{
                                    Text("\(cunFangWeiZhi)")
                                        .foregroundColor(.gray)
                                }
                            }
                        })
        //                保修期、保质期
                        Section(content: {
                            if edit {
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
                                
                            }else{
                                if baoxiu {
                                    HStack{
                                        Text("保修期至：")
                                        Text(baoXiuQi.dateString())
                                            .foregroundColor(.gray)
                                    }
                                }else{
                                    HStack{
                                        Text("保修期：")
                                        Text("无保修")
                                            .foregroundColor(.gray)
                                    }
                                }
                                if leiBie == "车" || leiBie == "车辆" {
                                    if baoZhi {
                                        HStack{
                                            Text("年检到期：")
                                            Text(baoZhiQi.dateString())
                                                .foregroundColor(.gray)
                                        }
                                    }else{
                                        HStack{
                                            Text("年检：")
                                            Text("无需年检")
                                                .foregroundColor(.gray)
                                        }
                                    }
                                } else {
                                    if baoZhi {
                                        HStack{
                                            Text("保质期至：")
                                            Text(baoZhiQi.dateString())
                                                .foregroundColor(.gray)
                                        }
                                    }else{
                                        HStack{
                                            Text("保质期：")
                                            Text("无保质期")
                                                .foregroundColor(.gray)
                                        }
                                    }
                                }
                            }
                        })
        //                采购地
                        Section(content: {
                            HStack{
                                if edit {
                                    Text("采购地：")
                                    TextField("请输入采购地", text: $caiGouDi)
                                        .foregroundColor(.gray)
                                }else{
                                    Text("采购地：")
                                    Text("\(caiGouDi)")
                                        .foregroundColor(.gray)
                                }
                            }
                        })
        //                采购人
                        Section(content: {
                            HStack{
                                if edit {
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
        //                            .sheet(isPresented: $showCaiGouRenXuanZheView, content: CaiGouRenXuanZheView())
                                }else{
                                    Text("采购人：")
                                    Text("\(caiGouRen)")
                                        .foregroundColor(.gray)
                                }
                            }
                        })
                    })
                })
            }
            
        
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
        .navigationBarTitle("物资详情")
        .navigationBarTitleDisplayMode(.inline)
        .listStyle(.grouped)
//        .navigationBarItems(trailing: )
        .navigationBarBackButtonHidden(edit ? true : false)
        .navigationBarItems(leading: Button(action: {
            withAnimation {edit = false}
        }, label: {
            if edit {
                Text("取消")
            }
        }), trailing: Button(action: {
            if edit {
                if editWuZiXinXiPanDuan() {
                    editWuZiDoneAndSave()
                    withAnimation {edit = false}
                }else{
                    self.isShowAlert1.toggle()
                }
            }else{
                withAnimation {edit.toggle()}
            }
            
        }, label: {
            edit ? Text("完成") : Text("编辑")
            
        }))
        .alert(isPresented: self.$isShowAlert1, content: {
            Alert(title: Text("请完善信息"), message: Text("提示：红色的项目未必填项。"))
        })
    }
    public func editWuZiXinXiPanDuan() -> Bool {
        if mingCheng == "" || suLiang < 0 ||  danWei == "" || leiBie == "" || xiangMu == "" {
            return false
        }
        if leiBie == "车" && nengYuanLeiBie == "" {
            return false
        }
        if leiBie == "车辆" && nengYuanLeiBie == "" {
            return false
        }else{return true}
    }
    public func editWuZiDoneAndSave() {
//        名称变动
        if wuZi.mingCheng != mingCheng {
            LiuShuiJiLu_WuZi(newLiuShui: LiuShui(context: viewContext), wuZi: wuZi, renYuan: nil, xiangMu: nil, leiBie: "基本信息_变动_姓名", beizhu: wuZi.mingCheng, houbeizhu: mingCheng, sanRenYuan: nil, sanWuZi: mingCheng, sanXiangMu: nil)
            wuZi.mingCheng = mingCheng
        }
//        数量变动
        wuZi.suLiang = suLiang
//        单位变动
        wuZi.danWei = danWei
//        编号变动
        wuZi.bianHao = bianHao
//        类型变动
        for i in leiBies {
            if i.mingCheng == leiBie {
                i.addToWuZi(wuZi)
            }
        }
//        部门变动
        for i in xiangMus {
            if i.mingCheng == xiangMu {
                i.addToWuZi(wuZi)
            }
        }
//        品牌变动
        wuZi.pinPai = pinPai
//        规格变动
        wuZi.guiGe = guiGe
        //能源类别变动
        wuZi.nengYuanLeiBie = nengYuanLeiBie
//        入库时间变动
        wuZi.ruKuShiJian = ruKuShiJian
//        存放位置变动
        wuZi.cunFangWeiZhi = cunFangWeiZhi
//        保修变动
        wuZi.baoXiu = baoxiu
        wuZi.baoXiuQi = baoXiuQi
//        保质变动
        wuZi.baoZhi = baoZhi
        wuZi.baoZhiQi = baoZhiQi
//        采购地变动
        wuZi.caiGouDi = caiGouDi
//        采购人变动
        for i in renYuans {
            if i.xingMing == caiGouRen {
                i.addToWuZi(wuZi)
            }
        }
        do{
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
struct CaiGouRenXuanZheView: View {
    @Environment(\.dismiss) var dismissCaiGouRenXuanZheView
    @Binding var caiGouRenGet: String
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \RenYuan.xingMing, ascending: true)], animation: .default)
    var renYuans: FetchedResults<RenYuan>
    var body: some View {
        NavigationStack{
            List(content: {
                ForEach(renYuans, id: \.self, content: {
                    renYuan in
                    Button(action: {
                        caiGouRenGet = renYuan.xingMing ?? ""
                        dismissCaiGouRenXuanZheView()
                    }, label: {
                        Text("\(renYuan.xingMing ?? "")")
                    })
                })
            })
            .listStyle(.automatic)
            .navigationBarTitle("选择采购人")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button(action: {
                dismissCaiGouRenXuanZheView()
            }, label: {
                Text("取消")
            }))
        }
    }
}
struct LeiBieXuanZheView: View {
    @State var showLeiBieAdd: Bool = false
    @Environment(\.dismiss) var dismissLeiBieXuanZheView
    @Binding var leiBieGet: String
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \WuZiLeiBie.mingCheng, ascending: true)], animation: .default)
    var leiBies: FetchedResults<WuZiLeiBie>
    
    var body: some View {
        NavigationStack{
            List(content: {
                ForEach(leiBies, id: \.self, content: {
                    leiBie in
                    Button(action: {
                        leiBieGet = leiBie.mingCheng ?? ""
                        dismissLeiBieXuanZheView()
                    }, label: {
                        Text(leiBie.mingCheng ?? "")
                            .foregroundColor(Color("wwysBlack"))
                    })
                })
                Button(action: {
                    self.showLeiBieAdd = true
                }, label: {
                    HStack{
                        Spacer()
                        Text("添加类别")
                        Spacer()
                    }
                }).sheet(isPresented: $showLeiBieAdd, content: {
                    AddWuZhiLeiBieView()
                })
            })
            .listStyle(.automatic)
            .navigationBarTitle("选择物资类别")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button(action: {
                dismissLeiBieXuanZheView()
            }, label: {
                Text("取消")
            }))
        }
    }
    struct AddWuZhiLeiBieView: View {
        @State private var isShowAlert1: Bool = false
        @Environment(\.dismiss) var dismissAddLeiBieView
        @Environment(\.managedObjectContext) private var viewContext
        @State var mingCheng: String = ""
        @State var beiZhu: String = ""
        var body: some View {
            NavigationStack{
                List(content: {
                    Section(content: {
                        HStack{
                            Text("类别名称：")
                            TextField("请输入类别名称", text: $mingCheng)
                                .foregroundColor(.gray)
                        }
                    })
                    Section(content: {
                        VStack(alignment: .leading){
                            Text("备注：")
                            TextEditor(text: $beiZhu)
                                .frame(height: 140)
                        }
                    })
                })
                .listStyle(.grouped)
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
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(leading: Button(action: {
                    dismissAddLeiBieView()
                }, label: {
                    Text("取消")
                }), trailing:
                    HStack {
                        //Spacer()
                        //EditButton()
                        Spacer()
                        Button(action: {
                            if xinXiPanDuan() {
                                addLeiBieAction()
                                dismissAddLeiBieView()
                            }else{
                                self.isShowAlert1.toggle()
                            }
    //                        self.editMode?.wrappedValue = .active == self.editMode?.wrappedValue ? .inactive : .active
                        }) {
                            Text("完成")
    //                        Text(.active == self.editMode?.wrappedValue ? "Done" : "Edit")
                        }
                        Spacer()
                })
                .alert(isPresented: self.$isShowAlert1, content: {
                    Alert(title: Text("提示"), message: Text("请完善信息"))
                })
            }
        }
        private func xinXiPanDuan() -> Bool {
            if mingCheng == "" {
                return false
            }else{return true}
        }
        private func addLeiBieAction() {
            let newLeiBie = WuZiLeiBie(context: viewContext)
            newLeiBie.mingCheng = mingCheng
            newLeiBie.beiZhu = beiZhu
            newLeiBie.id = UUID()
//            LiuShuiJiLu_RenYuan(newLiuShui: LiuShui(context: viewContext), renyuan: nil, zhiwu: nil, xiangmu: nil, lieBie: "物资类别_新增", beizhu: mingCheng, houbeizhu: nil, sanRenYuan: nil, sanWuZi: nil, sanXiangMu: nil, sanZhiWu: nil, qianZhiWu: nil, qianXiangMu: nil)
            do{
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            
        }
    }
}


struct WuZhiXiangMuXuanZheView: View {
    @State var showXiangMuAdd: Bool = false
    @Environment(\.dismiss) var dismissXiangMuXuanZheView
    @Binding var xiangMuGet: String
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \XiangMu.mingCheng, ascending: true)], animation: .default)
    var xiangMus: FetchedResults<XiangMu>
    
    var body: some View {
        NavigationStack{
            List(content: {
                ForEach(xiangMus, id: \.self, content: {
                    xiangMu in
                    Button(action: {
                        xiangMuGet = xiangMu.mingCheng ?? ""
                        dismissXiangMuXuanZheView()
                    }, label: {
                        Text(xiangMu.mingCheng ?? "")
                            .foregroundColor(Color("wwysBlack"))
                    })
                })
                Button(action: {
                    self.showXiangMuAdd = true
                }, label: {
                    HStack{
                        Spacer()
                        Text("添加部门")
                        Spacer()
                    }
                }).sheet(isPresented: $showXiangMuAdd, content: {
                    AddXiangMuView()
                })
            })
            .listStyle(.automatic)
            .navigationBarTitle("选择部门")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button(action: {
                dismissXiangMuXuanZheView()
            }, label: {
                Text("取消")
            }))
        }
    }
    
}


//struct WuZiSuJuView_Previews: PreviewProvider {
//    static var previews: some View {
//        WuZiSuJuView()
//    }
//}
