//
//  AddRenYuanView.swift
//  HFGL2022
//
//  Created by nwy on 2022/12/8.
//

import SwiftUI
import CoreData
//var textZhiWu: String = ""
enum AlertType: Identifiable {
    var id: AlertType {self}
    
case jiancha
    case congming
}
struct AddRenYuanView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \XiangMu.mingCheng, ascending: true)], animation: .default)
    var xiangMus: FetchedResults<XiangMu>
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \ZhiWu.mingCheng, ascending: true)], animation: .default)
    var zhiWus: FetchedResults<ZhiWu>
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \RenYuan.xingMing, ascending: true)], animation: .default)
    var renYuans: FetchedResults<RenYuan>
    @State private var showXiangMuXuanZheView1: Bool = false
    @State private var showXiangMuXuanZheView2: Bool = false
    @State private var showXiangMuXuanZheView3: Bool = false
    
    @State private var alertType: AlertType? = nil
    @State private var isShowAlert1: Bool = false
    @State private var isShowAlertCongMing: Bool = false
    @State private var showZhiWuXuanZheView = false
//    @Environment(\.editMode) var editMode
    @Environment(\.dismiss) var dismiss1
    @State var xingMing: String = ""
    @State var telArray: [Int] = [1]
    @State var telHaoMa1: String = ""
    @State var telHaoMa2: String = ""
    @State var telHaoMa3: String = ""
    @State var telHaoMa4: String = ""
    @State var telHaoMa5: String = ""
    @State var xingBie: Bool = true
    @State var chuShengRiQi: Date = Date()
    @State var zhiWu: String = ""
    @State var xiangMuArray: [Int] = [1]
    @State var xiangMu1: String = ""
    @State var xiangMu2: String = ""
    @State var xiangMu3: String = ""
    @State var shenFenZheng: String = ""
    @State var jiaZhao: String = ""
    @State var zhuZhi: String = ""
    @State var baoXian: Bool = false
    @State var baoXianRiQi: Date = Date()
    @State var baoXianShiChang: Int16 = 0
    @State var zaiZhi: Bool = true
    @State var liZhiYuanYin: String = ""
    @State var ruZhiRiQi: Date = Date()
    @State var hunYin: Bool = true
    @State var wenHua: String = ""
    @State var beiZhu: String = ""
//    @FocusState private var focus: Bool
    
    
    
    
    
    
    var body: some View {
        NavigationStack {
            Image("touxiang111")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60)
                .cornerRadius(30)
                .padding(.leading)
            List {
                Group(content: {
                    //                姓名
                                    Section(content: {
                                        HStack{
                                            xingMing == "" ? Text("姓名：").foregroundColor(.red) : Text("姓名：")
                                            TextField("请输入姓名", text: $xingMing)
                                        }
                                    })
                    //                项目
                                Section(content: {
                                    ForEach(xiangMuArray, id: \.self, content: {
                                        i in
                                        if i == 1 {
                                            Button(action: {
                                                self.showXiangMuXuanZheView1 = true
                                            }, label: {
                                                HStack{
                                                    
                                                    if xiangMu1 == "" {
                                                        Text("部门：")
                                                            .foregroundColor(Color.red)
                                                    }else{Text("部门：")
                                                        .foregroundColor(Color("wwysBlack"))}
                                                    
                                                    Text("\(xiangMu1)")
                                                        .foregroundColor(Color.gray)
                                                    Spacer()
                                                    if xiangMu1 == "" {
                                                        Text("选择部门")
                                                    }else{Text("更改")}
                                                    
                                                }
                                            }).sheet(isPresented: $showXiangMuXuanZheView1, content: {
                                                XiangMuAddView(op1: xiangMu1, op2: xiangMu2, op3: xiangMu3, xiangMuText: $xiangMu1)
                                            })
                                        }
                                        if i == 2 {
                                            Button(action: {
                                                self.showXiangMuXuanZheView2 = true
                                            }, label: {
                                                HStack{
                                                    Text("部门2：")
                                                        .foregroundColor(Color("wwysBlack"))
                                                    Text("\(xiangMu2)")
                                                        .foregroundColor(Color.gray)
                                                    Spacer()
                                                    if xiangMu2 == "" {
                                                        Text("选择部门")
                                                    }else{Text("更改")}
                                                }
                                            }).sheet(isPresented: $showXiangMuXuanZheView2, content: {
                                                XiangMuAddView(op1: xiangMu1, op2: xiangMu2, op3: xiangMu3, xiangMuText: $xiangMu2)
                                            })
                                        }
                                        if i == 3 {
                                            Button(action: {
                                                self.showXiangMuXuanZheView3 = true
                                            }, label: {
                                                HStack{
                                                    Text("部门3：")
                                                        .foregroundColor(Color("wwysBlack"))
                                                    Text("\(xiangMu3)")
                                                        .foregroundColor(Color.gray)
                                                    Spacer()
                                                    if xiangMu3 == "" {
                                                        Text("选择部门")
                                                    }else{Text("更改")}
                                                }
                                            }).sheet(isPresented: $showXiangMuXuanZheView3, content: {
                                                XiangMuAddView(op1: xiangMu1, op2: xiangMu2, op3: xiangMu3, xiangMuText: $xiangMu3)
                                            })
                                        }
                                    })
                                    Button(action: {
                                        var i = xiangMuArray.last
                                        if i! < 3 {
                                            withAnimation{
                                                i! += 1
                                                xiangMuArray.append(i!)
                                            }
                                        }
                                    }, label: {
                                        if xiangMuArray.last! < 3 {
                                            HStack{
                                                Image(systemName: "plus")
                                                Text("添加部门")
                                                Spacer()
                                            }
                                        }else{
                                            HStack{
                                                Text("已达上限，无法再添加")
                                                Spacer()
                                            }.foregroundColor(Color.gray)
                                        }
                                        
                                    })
                                })
                    //                职务
                                    Section(content: {
                                        Button(action: {
                                            self.showZhiWuXuanZheView = true
                                        }, label: {
                                            HStack{
                                                if zhiWu == "" {
                                                    Text("职务：")
                                                        .foregroundColor(Color.red)
                                                }else{Text("职务：")
                                                    .foregroundColor(Color("wwysBlack"))}
                                                if zhiWu != "" {
                                                    Text("\(zhiWu)")
                                                        .foregroundColor(Color.gray)
                                                    Spacer()
                                                    Text("更改")
                                                }else{
                                                    Spacer()
                                                    Text("选择职务")
                                                }
                                            }
                                        }).sheet(isPresented: self.$showZhiWuXuanZheView, content: {ZhiWuXZuanZheView(zhiWuText: $zhiWu)})
                                    })
                    //                性别
                                    Section(content: {
                                        Button(action: {
                                            xingBie.toggle()
                                        }, label: {
                                            HStack{
                                                Text("性别：")
                                                    .foregroundColor(Color("wwysBlack"))
                                                if xingBie {
                                                    Text("男")
                                                        .foregroundColor(Color.blue)
                                                }else{
                                                    Text("女")
                                                        .foregroundColor(Color.red)
                                                }
                                                Spacer()
                                                Text("更改性别")
                                            }
                                        })
                                    })
                    //                出生日期
                                    Section(content: {
                                        DatePicker("出生日期：", selection: $chuShengRiQi, displayedComponents: .date)
                                            .environment(\.locale, Locale(identifier: "zh_CN"))
                                    })
                    //                电话
                                    Section(content: {
                                        ForEach(telArray, id: \.self, content: {
                                            i in
                                            HStack{
                                                if telHaoMa1 == "" && telHaoMa2 == "" && telHaoMa3 == "" && telHaoMa4 == "" && telHaoMa5 == "" {
                                                    Text("手机：")
                                                        .foregroundColor(Color.red)
                                                }else{Text("手机：")}
                                                if i == 1 {
                                                    TextField("请输入号码", text: $telHaoMa1)
                                                        .keyboardType(.numberPad)
                                                        .foregroundColor(Color.gray)
                                                        
                                                }
                                                if i == 2 {
                                                    TextField("请输入号码", text: $telHaoMa2)
                                                        .keyboardType(.numberPad)
                                                        .foregroundColor(Color.gray)
                                                }
                                                if i == 3 {
                                                    TextField("请输入号码", text: $telHaoMa3)
                                                        .keyboardType(.numberPad)
                                                        .foregroundColor(Color.gray)
                                                }
                                                if i == 4 {
                                                    TextField("请输入号码", text: $telHaoMa4)
                                                        .keyboardType(.numberPad)
                                                        .foregroundColor(Color.gray)
                                                }
                                                if i == 5 {
                                                    TextField("请输入号码", text: $telHaoMa5)
                                                        .keyboardType(.numberPad)
                                                        .foregroundColor(Color.gray)
                                                }
                                            }
                                        })
                                        
                                        Button(action: {
                                            var i = telArray.last
                                            if i! < 5 {
                                                withAnimation{
                                                    i! += 1
                                                    telArray.append(i!)
                                                    
                                                }
                                            }
                                        }, label: {
                                            if telArray.last! < 5 {
                                                HStack{
                                                    Image(systemName: "plus")
                                                    Text("添加联系方式")
                                                    Spacer()
                                                }
                                            }else{
                                                HStack{
                                                    Text("已达上限，无法再添加")
                                                    Spacer()
                                                }
                                                .foregroundColor(Color.gray)
                                            }
                                            
                                        })
                                    })
                    //                身份证
                                    Section(content: {
                                        HStack{
                                            if shenFenZheng == "" {
                                                Text("证件号：").foregroundColor(.red)
                                            }else{Text("证件号：")}
                                            TextField("请填写证件号", text: $shenFenZheng)
                                                .foregroundColor(Color.gray)
                                                .keyboardType(.namePhonePad)
                                        }
                                        
                                    })
                    //                驾照
                                    Section(content: {
                                        Menu(content: {
                                            Button(action: {
                                                jiaZhao = "无驾照"
                                            }, label: {
                                                Text("无驾照")
                                            })
                                            Button(action: {
                                                jiaZhao = "C照"
                                            }, label: {
                                                Text("C照：（手动挡、自动挡小汽车）")
                                            })
                                            Button(action: {
                                                jiaZhao = "B照"
                                            }, label: {
                                                Text("B照：（手动挡、自动挡作业车辆）")
                                            })
                                        }, label: {
                                            HStack{
                                                if jiaZhao == "" {
                                                    Text("驾照：")
                                                        .foregroundColor(Color.red)
                                                }else{Text("驾照：")
                                                    .foregroundColor(Color("wwysBlack"))}
                                                if jiaZhao == "无驾照" {
                                                    Text("无驾照")
                                                        .foregroundColor(Color.gray)
                                                }
                                                if jiaZhao == "C照" {
                                                    Text("C照")
                                                        .foregroundColor(Color.gray)
                                                }
                                                if jiaZhao == "B照" {
                                                    Text("B照")
                                                        .foregroundColor(Color.gray)
                                                }
                                                Spacer()
                                                Text("请选择驾照")
                                            }
                                        })
                                    })
                    //                住址
                                    Section(content: {
                                        HStack{
                                            if zhuZhi == "" {Text("住址：").foregroundColor(.red)}else{Text("住址：")}
                                            TextField("请填写住址", text: $zhuZhi)
                                                .foregroundColor(Color.gray)
                                                .keyboardType(.default)
                                        }
                                        
                                    })
                    //                保险
                                    Section(content: {
                                        Toggle(isOn: $baoXian.animation(), label: {
                                            if baoXian {
                                                HStack{
                                                    Text("保险：")
                                                    Text("已购买")
                                                        .foregroundColor(Color.green)
                                                }
                                            }else{
                                                HStack{
                                                    Text("保险：")
                                                    Text("未购买")
                                                        .foregroundColor(Color.purple)
                                                }
                                            }
                                        })
                                        if baoXian {
                                            DatePicker("购买日期：", selection: $baoXianRiQi, displayedComponents: .date)
                                            Menu(content: {
                                                Button(action: {baoXianShiChang = 1}, label: {Text("1个月")})
                                                Button(action: {baoXianShiChang = 6}, label: {Text("半年")})
                                                Button(action: {baoXianShiChang = 12}, label: {Text("一年")})
                                                Button(action: {baoXianShiChang = 144}, label: {Text("长期（自动续保的）")})
                                            }, label: {
                                                HStack{
                                                    Text("保险时长：")
                                                        .foregroundColor(Color("wwysBlack"))
                                                    if baoXianShiChang > 12 {
                                                        Text("自动续保...")
                                                    }else{
                                                        Text("\(baoXianShiChang)个月")
                                                            .foregroundColor(Color.gray)
                                                    }
                                                    Spacer()
                                                    Text("请选择时长")
                                                }
                                            })
                                        }
                                    })
                })
                Group(content: {
//                    在职
                    Section(content: {
                        Toggle(isOn: $zaiZhi.animation(), label: {
                            if zaiZhi {
                                HStack{
                                    Text("是否在职：")
                                    Text("在职")
                                        .foregroundColor(Color.green)
                                }
                            }else{
                                HStack{
                                    Text("是否在职：")
                                    Text("已离职")
                                        .foregroundColor(Color.purple)
                                }
                            }
                        })
                        if !zaiZhi {
                            VStack(alignment: .leading){
                                Text("离职原因：")
                                TextEditor(text: $liZhiYuanYin)
                                    .frame(height: 120)
                            }.foregroundColor(Color.gray)
                            
                //                .lineLimit(3, reservesSpace: true)
                //                .lineLimit(8)
                        }
                    })
//                    入职时间
                    Section(content: {
                        DatePicker("入职时间：", selection: $ruZhiRiQi, displayedComponents: .date)
                            .environment(\.locale, Locale(identifier: "zh_CN"))
                    })
//                    已婚
                    Section(content: {
                        Button(action: {
                            hunYin.toggle()
                        }, label: {
                            HStack{
                                Text("婚姻状况：")
                                    .foregroundColor(Color("wwysBlack"))
                                if hunYin {
                                    Text("已婚")
                                        .foregroundColor(Color.gray)
                                }else{
                                    Text("未婚")
                                        .foregroundColor(Color.gray)
                                }
                                Spacer()
                                Text("更改")
                            }
                        })
                    })
//                    文化
                    Section(content: {
                        Menu(content: {
                            Button(action: {wenHua = "小学以下"}, label: {Text("无")})
                            Button(action: {wenHua = "小学"}, label: {Text("小学")})
                            Button(action: {wenHua = "初中"}, label: {Text("初中")})
                            Button(action: {wenHua = "高中"}, label: {Text("高中")})
                            Button(action: {wenHua = "中专"}, label: {Text("中专")})
                            Button(action: {wenHua = "大学"}, label: {Text("大学")})
                        }, label: {
                            HStack{
                                if wenHua == "" {
                                    Text("文化程度：")
                                        .foregroundColor(Color.red)
                                }else{Text("文化程度：")
                                    .foregroundColor(Color("wwysBlack"))}
                                Text("\(wenHua)")
                                    .foregroundColor(Color.gray)
                                Spacer()
                                Text("更改")
                                
                            }
                        })
                    })
//                    备注
                    Section("备注：", content: {
                        TextEditor(text: $beiZhu)
                            .frame(height: 200)
                    })
                    
                })
            }
//            滑动隐藏键盘
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
            .navigationBarTitle("添加人员")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button(action: {
                dismiss1()
            }, label: {
                Text("取消")
            }), trailing:
                HStack {
                    //Spacer()
                    //EditButton()
                    Spacer()
                    Button(action: {
                        if xinXiPanDuan() {
                            if chaChong() {
                                addRenYuanAction()
                            }else{self.alertType = .congming}
                        }else{
//                            self.isShowAlert1.toggle()
                            self.alertType = .jiancha
                        }
//                        self.editMode?.wrappedValue = .active == self.editMode?.wrappedValue ? .inactive : .active
                    }) {
                        Text("完成")
//                        Text(.active == self.editMode?.wrappedValue ? "Done" : "Edit")
                    }
                    Spacer()
            })
//            .environment(.editButton, EditButton())
//            .environment(.editMode, .active)
            .listStyle(.grouped)
//            .alert(isPresented: self.$isShowAlert1) {
//                Alert(title: Text("请完善信息"), message: Text("提示：红色的项目未必填项。"))
//            }
            .alert(item: $alertType, content: { i in
                switch i {
                case .jiancha:
                    return Alert(title: Text("请完善信息"), message: Text("提示：红色的项目未必填项。"))
                case .congming:
                    return Alert(title: Text("错误"), message: Text("与现有人员重"))
                }
            })
//            .alert(isPresented: self.$isShowAlertCongMing, content: {
//                Alert(title: Text("错误"), message: Text("与现有人员重名。"))
//            })
            
        }
        
    }
//    查重
    private func chaChong() -> Bool {
        var bool: Bool = true
        for i in renYuans {
            if i.xingMing == xingMing {
                bool = false
            }
        }
        return bool
    }
//    判断信息是否完善
    private func xinXiPanDuan() -> Bool {
        var bool: Bool = true
        if xingMing == "" || telHaoMa1 == "" || zhiWu == "" || xiangMu1 == "" || shenFenZheng == "" || jiaZhao == "" || zhuZhi == "" || wenHua == "" {
            bool = false
        }else{bool = true}
        return bool
    }
//    添加人员并保存
    private func addRenYuanAction() {
        let newRenYuan = RenYuan(context: viewContext)
        newRenYuan.xingMing = xingMing
        newRenYuan.id = UUID()
        newRenYuan.xingBie = xingBie
        newRenYuan.chuShengRiQi = chuShengRiQi
        newRenYuan.shenFenZheng = shenFenZheng
        newRenYuan.jiaZhao = jiaZhao
        newRenYuan.zhuZhi = zhuZhi
        newRenYuan.baoXian = baoXian
        newRenYuan.baoXianRiQi = baoXianRiQi
        newRenYuan.baoXianShiChang = baoXianShiChang
        newRenYuan.zaiZhi = zaiZhi
        newRenYuan.liZhiYuanYin = liZhiYuanYin
        newRenYuan.ruZhiShiJian = ruZhiRiQi
        newRenYuan.hunYin = hunYin
        newRenYuan.wenHua = wenHua
        newRenYuan.beiZhu = beiZhu
        if telHaoMa1 != "" {
            let newTel1 = Tel(context: viewContext)
            newTel1.id = UUID()
            newTel1.haoMa = telHaoMa1
            newTel1.leiXing = "手机1"
            newTel1.renYuan = newRenYuan
        }
        if telHaoMa2 != "" {
            let newTel2 = Tel(context: viewContext)
            newTel2.id = UUID()
            newTel2.haoMa = telHaoMa2
            newTel2.leiXing = "手机2"
            newTel2.renYuan = newRenYuan
        }
        if telHaoMa3 != "" {
            let newTel3 = Tel(context: viewContext)
            newTel3.id = UUID()
            newTel3.haoMa = telHaoMa3
            newTel3.leiXing = "手机3"
            newTel3.renYuan = newRenYuan
        }
        if telHaoMa4 != "" {
            let newTel4 = Tel(context: viewContext)
            newTel4.id = UUID()
            newTel4.haoMa = telHaoMa4
            newTel4.leiXing = "手机4"
            newTel4.renYuan = newRenYuan
        }
        if telHaoMa5 != "" {
            let newTel5 = Tel(context: viewContext)
            newTel5.id = UUID()
            newTel5.haoMa = telHaoMa5
            newTel5.leiXing = "手机5"
            newTel5.renYuan = newRenYuan
        }
        for i in xiangMus {
            if i.mingCheng == xiangMu1 {
                i.addToRenYuan(newRenYuan)
            }
            if i.mingCheng == xiangMu2 {
                i.addToRenYuan(newRenYuan)
            }
            if i.mingCheng == xiangMu3 {
                i.addToRenYuan(newRenYuan)
            }
        }
        for i in zhiWus {
            if i.mingCheng == zhiWu {
                i.addToRenYuan(newRenYuan)
//                产生（新增）流水记录
                let newLiuShui1 = LiuShui(context: viewContext)
                newLiuShui1.id = UUID()
                newLiuShui1.riQiShiJian = ruZhiRiQi
                i.addToLiuShui(newLiuShui1)
                newLiuShui1.sanChuZhiWu = i.mingCheng
                newRenYuan.addToLiuShui(newLiuShui1)
                newLiuShui1.sanChuRenYuan = xingMing
                newLiuShui1.leiBie = "职务_入职"
            }
        }
        do{
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        dismiss1()
    }
}














struct AddRenYuanView_Previews: PreviewProvider {
    static var previews: some View {
        AddRenYuanView()
    }
}
