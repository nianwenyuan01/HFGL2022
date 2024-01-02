//
//  EditRenYuanView.swift
//  HFGL2022
//
//  Created by nwy on 2022/12/13.
//

import SwiftUI
import CoreData

struct EditRenYuanView: View {
    
    @Binding var edit: Bool
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Tel.haoMa, ascending: true)], animation: .default)
    var tels: FetchedResults<Tel>
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \ZhiWu.mingCheng, ascending: true)], animation: .default)
    var zhiWus: FetchedResults<ZhiWu>
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \XiangMu.mingCheng, ascending: true)], animation: .default)
    var xiangMus: FetchedResults<XiangMu>
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \RenYuan.xingMing, ascending: true)], animation: .default)
    var renYuans: FetchedResults<RenYuan>
//    let renYuanId: UUID
    let renYuan: FetchedResults<RenYuan>.Element
    @State var showEditRenYuanXiangMuXuanZheView1: Bool = false
    @State var showEditRenYuanXiangMuXuanZheView2: Bool = false
    @State var showEditRenYuanXiangMuXuanZheView3: Bool = false
    @State var showEditRenYuanZhiWuView: Bool = false
    @State private var isShowAlert1: Bool = false
    @State private var isShowAlertCongMing: Bool = false
    @State var xingMing: String
    @State var telArray: [Int]
    @State var telHaoMa1: String
    @State var telHaoMa2: String
    @State var telHaoMa3: String
    @State var telHaoMa4: String
    @State var telHaoMa5: String
    @State var xingBie: Bool
    @State var chuShengRiQi: Date
    @State var zhiWu: String
    @State var xiangMuArray: [Int]
    @State var xiangMu1: String
    @State var xiangMu2: String
    @State var xiangMu3: String
    @State var shenFenZheng: String
    @State var jiaZhao: String
    @State var zhuZhi: String
    @State var baoXian: Bool
    @State var baoXianRiQi: Date
    @State var baoXianShiChang: Int16
    @State var zaiZhi: Bool
    @State var liZhiYuanYin: String
    @State var ruZhiRiQi: Date
    @State var hunYin: Bool
    @State var wenHua: String
    @State var beiZhu: String
    
    
    var body: some View {
        NavigationStack{
            List{
                Group(content: {
    //                姓名
                    Section(content: {
                        HStack{
                            if xingMing == "" {
                                Text("姓名：")
                                    .foregroundColor(Color.red)
                            }else{Text("姓名：")}
                            TextField("姓名", text: $xingMing)
                                .foregroundColor(Color.gray)
                        }
                    })
    //                项目
                    Section(content: {
                        ForEach(xiangMuArray, id: \.self, content: {
                            i in
                            if i == 1 {
                                Button(action: {
                                    self.showEditRenYuanXiangMuXuanZheView1 = true
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
                                }).sheet(isPresented: $showEditRenYuanXiangMuXuanZheView1, content: {
                                    XiangMuAddView(op1: xiangMu1, op2: xiangMu2, op3: xiangMu3, xiangMuText: $xiangMu1)
                                })
                            }
                            if i == 2 {
                                Button(action: {
                                    self.showEditRenYuanXiangMuXuanZheView2 = true
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
                                }).sheet(isPresented: $showEditRenYuanXiangMuXuanZheView2, content: {
                                    XiangMuAddView(op1: xiangMu1, op2: xiangMu2, op3: xiangMu3, xiangMuText: $xiangMu2)
                                })
                            }
                            if i == 3 {
                                Button(action: {
                                    self.showEditRenYuanXiangMuXuanZheView3 = true
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
                                }).sheet(isPresented: $showEditRenYuanXiangMuXuanZheView3, content: {
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
                            self.showEditRenYuanZhiWuView = true
                        }, label: {
                            HStack{
                                if zhiWu == "" {
                                    Text("职务：")
                                        .foregroundColor(Color.red)
                                }else{
                                    Text("职务：")
                                        .foregroundColor(Color("wwysBlack"))
                                }
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
                        }).sheet(isPresented: self.$showEditRenYuanZhiWuView, content: {ZhiWuXZuanZheView(zhiWuText: $zhiWu)})
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
                                        .foregroundColor(Color.gray)
                                }else{
                                    Text("女")
                                        .foregroundColor(Color.gray)
                                }
                                Spacer()
                                Text("更改性别")
                            }
                        })
                    })
    //                出生日期
                    Section(content: {
                        DatePicker("出生日期：", selection: $chuShengRiQi, displayedComponents: .date)
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
    //                在职
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
    //                入职时间
                    Section(content: {
                        DatePicker("入职时间：", selection: $ruZhiRiQi, displayedComponents: .date)
                    })
    //                婚姻状况
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
    //                文化
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
    //                备注
                    Section("备注：", content: {
                        TextEditor(text: $beiZhu)
                            .frame(height: 200)
                    })
                })
            }
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
        }
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing, content: {
                Button(action: {
                    if editRenYuanXinXiPanDuan() {
                        if chaChong() {
                            editRenYuanXinXiDoneAndSave(tels: tels)
                            withAnimation{
                                edit.toggle()
                            }
                        }else{self.isShowAlertCongMing = true}
                    }else{
                        self.isShowAlert1 = true
                    }
//                    if edit {
//                        withAnimation{
//                            edit.toggle()
//                        }
//                    }
                }, label: {
                    Text("完成")
                })
                .alert(isPresented: self.$isShowAlert1, content: {
                    Alert(title: Text("请完善信息"), message: Text("提示： 红色的项目为必填项目"))
                })
                .alert(isPresented: self.$isShowAlertCongMing, content: {
                    Alert(title: Text("错误"), message: Text("与现有人员重名。"))
                })
            })
            
        })
        
    }
    private func chaChong() -> Bool {
        var bool: Bool = true
        if renYuan.xingMing != xingMing && xingMing != ""{
            for i in renYuans {
                if i.xingMing == xingMing {
                    bool = false
                }
            }
        }
        return bool
    }
    private func editRenYuanXinXiPanDuan() -> Bool {
        var xiangmubool: Bool = false
        let xiangmuarr = [xiangMu1, xiangMu2, xiangMu3]
        for i in xiangmuarr {
            if i != "" {
                xiangmubool = true
            }
        }
        var telbool:Bool = false
        let telarr: [String] = [telHaoMa1, telHaoMa2, telHaoMa3, telHaoMa4, telHaoMa5]
        for i in telarr {
            if i != "" {telbool = true}
        }
        if xingMing == "" || zhiWu == "" ||  shenFenZheng == "" || jiaZhao == "" || zhuZhi == "" || wenHua == "" || !xiangmubool || !telbool {
            return false
        }else{return true}
    }
    func editRenYuanXinXiDoneAndSave(tels: FetchedResults<Tel>) {
        
//        更名流水记录
        if renYuan.xingMing != xingMing {
            LiuShuiJiLu_RenYuan(newLiuShui: LiuShui(context: viewContext), renyuan: renYuan, zhiwu: nil, xiangmu: nil, lieBie: "基本信息_变动_姓名", beizhu: "\(renYuan.xingMing ?? "")", houbeizhu: nil, sanRenYuan: xingMing, sanWuZi: nil, sanXiangMu: nil, sanZhiWu: nil, qianZhiWu: nil, qianXiangMu: nil)
            renYuan.xingMing = xingMing
        }
        renYuan.xingBie = xingBie
        renYuan.chuShengRiQi = chuShengRiQi
        renYuan.jiaZhao = jiaZhao
        renYuan.zhuZhi = zhuZhi
        renYuan.baoXian = baoXian
        renYuan.baoXianRiQi = baoXianRiQi
        renYuan.baoXianShiChang = baoXianShiChang
        if renYuan.zaiZhi != zaiZhi {
            renYuan.zaiZhi = zaiZhi
//            在职流水记录
            LiuShuiJiLu_RenYuan(newLiuShui: LiuShui(context: viewContext), renyuan: renYuan, zhiwu: nil, xiangmu: nil, lieBie: "在职_变动", beizhu: zaiZhi ? "复职" : "离职", houbeizhu: nil, sanRenYuan: xingMing, sanWuZi: nil, sanXiangMu: nil, sanZhiWu: nil, qianZhiWu: nil, qianXiangMu: nil)
        }
        renYuan.liZhiYuanYin = liZhiYuanYin
//        入职时间变更流水记录
        if renYuan.ruZhiShiJian != ruZhiRiQi {
            LiuShuiJiLu_RenYuan(newLiuShui: LiuShui(context: viewContext), renyuan: renYuan, zhiwu: nil, xiangmu: nil, lieBie: "基本信息_变动_入职时间", beizhu: renYuan.ruZhiShiJian?.dateString(), houbeizhu: ruZhiRiQi.dateString(), sanRenYuan: xingMing, sanWuZi: nil, sanXiangMu: nil, sanZhiWu: nil, qianZhiWu: nil, qianXiangMu: nil)
            renYuan.ruZhiShiJian = ruZhiRiQi
        }
        renYuan.hunYin = hunYin
        renYuan.wenHua = wenHua
//        备注流水
        if renYuan.beiZhu != beiZhu {
            LiuShuiJiLu_RenYuan(newLiuShui: LiuShui(context: viewContext), renyuan: renYuan, zhiwu: nil, xiangmu: nil, lieBie: "备注更新", beizhu: renYuan.beiZhu, houbeizhu: nil, sanRenYuan: xingMing, sanWuZi: nil, sanXiangMu: nil, sanZhiWu: nil, qianZhiWu: nil, qianXiangMu: nil)
            renYuan.beiZhu = beiZhu
        }
        
//        电话全部删除
        for i in tels {
            if i.renYuan == renYuan {
                i.managedObjectContext?.delete(i)
            }
        }
//        电话全部重新加回来
        if telHaoMa1 != "" {
            let newTel1 = Tel(context: viewContext)
            newTel1.id = UUID()
            newTel1.haoMa = telHaoMa1
            newTel1.leiXing = "手机1"
            newTel1.renYuan = renYuan
        }
        if telHaoMa2 != "" {
            let newTel2 = Tel(context: viewContext)
            newTel2.id = UUID()
            newTel2.haoMa = telHaoMa2
            newTel2.leiXing = "手机2"
            newTel2.renYuan = renYuan
        }
        if telHaoMa3 != "" {
            let newTel3 = Tel(context: viewContext)
            newTel3.id = UUID()
            newTel3.haoMa = telHaoMa3
            newTel3.leiXing = "手机3"
            newTel3.renYuan = renYuan
        }
        if telHaoMa4 != "" {
            let newTel4 = Tel(context: viewContext)
            newTel4.id = UUID()
            newTel4.haoMa = telHaoMa4
            newTel4.leiXing = "手机4"
            newTel4.renYuan = renYuan
        }
        if telHaoMa5 != "" {
            let newTel5 = Tel(context: viewContext)
            newTel5.id = UUID()
            newTel5.haoMa = telHaoMa5
            newTel5.leiXing = "手机5"
            newTel5.renYuan = renYuan
        }
//        职务
        if renYuan.zhiWu?.mingCheng != zhiWu {
            for i in zhiWus {
                if i.mingCheng == zhiWu {
                    
    //                流水业务变更
                    LiuShuiJiLu_RenYuan(newLiuShui: LiuShui(context: viewContext), renyuan: renYuan, zhiwu: i, xiangmu: nil, lieBie: "职务_变动", beizhu: nil, houbeizhu: nil, sanRenYuan: xingMing, sanWuZi: nil, sanXiangMu: nil, sanZhiWu: i.mingCheng, qianZhiWu: renYuan.zhiWu?.mingCheng, qianXiangMu: nil)
                    i.addToRenYuan(renYuan)
                }
            }
        }

//        关于项目的流水，要实现“退出”和“加入”的两个流水，涉及新旧比对
//        获取旧项目
        var jiuxiangmuMC: [String] = []
        for i in renYuan.xiangMuArray {
            jiuxiangmuMC.append(i.mingCheng ?? "")
        }
//        获取新项目
        var xinxiangmuMC: [String] = []
        if xiangMu1 != "" {xinxiangmuMC.append(xiangMu1)}
        if xiangMu2 != "" {xinxiangmuMC.append(xiangMu2)}
        if xiangMu3 != "" {xinxiangmuMC.append(xiangMu3)}
//        新项目需不需要加入？
        for xinxiangmu in xinxiangmuMC {
            var addxin = true
            for jiuxiangmu in jiuxiangmuMC {
                if xinxiangmu == jiuxiangmu {
                    addxin = false
                }
            }
            if addxin {
                for i in xiangMus {
                    if i.mingCheng == xinxiangmu {
//                        记录流水
                        LiuShuiJiLu_RenYuan(newLiuShui: LiuShui(context: viewContext), renyuan: renYuan, zhiwu: nil, xiangmu: i, lieBie: "项目_变动_进入", beizhu: nil, houbeizhu: nil, sanRenYuan: xingMing, sanWuZi: nil, sanXiangMu: i.mingCheng, sanZhiWu: nil, qianZhiWu: nil, qianXiangMu: nil)

//                        加入新项目
                        i.addToRenYuan(renYuan)
                    }
                }
            }
        }
//        旧项目是否需要删除？
        for jiuxiangmu in jiuxiangmuMC {
            var deletjiu = true
            for xinxiangmu in xinxiangmuMC {
                if jiuxiangmu == xinxiangmu {
                    deletjiu = false
                }
            }
            if deletjiu {
                for i in xiangMus {
                    if i.mingCheng == jiuxiangmu {
//                        记录流水
                        LiuShuiJiLu_RenYuan(newLiuShui: LiuShui(context: viewContext), renyuan: renYuan, zhiwu: nil, xiangmu: i, lieBie: "项目_变动_退出", beizhu: nil, houbeizhu: nil, sanRenYuan: xingMing, sanWuZi: nil, sanXiangMu: i.mingCheng, sanZhiWu: nil, qianZhiWu: nil, qianXiangMu: nil)

//                        删除旧项目
                        i.removeFromRenYuan(renYuan)
                    }
                }
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

//struct EditRenYuanView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditRenYuanView()
//    }
//}
