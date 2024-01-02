//
//  NewRenYuanSuJuView.swift
//  HFGL2022
//
//  Created by nwy on 2023/11/27.
//

import SwiftUI
import CoreData

struct NewRenYuanSuJuView: View {
    let renYuan: FetchedResults<RenYuan>.Element
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \RenYuan.xingMing, ascending: true)], animation: .default)
    var renYuans: FetchedResults<RenYuan>
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \ZhiWu.mingCheng, ascending: true)], animation: .default)
    var zhiWus: FetchedResults<ZhiWu>
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \XiangMu.mingCheng, ascending: true)], animation: .default)
    var xiangMus: FetchedResults<XiangMu>
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Tel.haoMa, ascending: true)], animation: .default)
    var tels: FetchedResults<Tel>
    
    let isSheetMolde: Bool
    
    @State var edit: Bool = false
    @State private var isShowAlertCongMing: Bool = false
    @State var showXiangMuXuanZheView1: Bool = false
    @State var showXiangMuXuanZheView2: Bool = false
    @State var showXiangMuXuanZheView3: Bool = false
    @State var showTelXuanZheView: Bool = false
    @State var showZhiWuXuanZheView: Bool = false
    
    @State var xingMing: String
    @State var xingBie: Bool
    @State var zaiZhi: Bool
    @State var zhuZhi: String
    @State var wenHua: String
    @State var shenFenZheng: String
    @State var ruZhiShiJian: Date
    @State var nianLing: Int16
    @State var liZhiYuanYin: String
    @State var jiaZhao: String
    @State var hunYin: Bool
    @State var chuShengRiQi: Date
    @State var beiZhu: String
    @State var baoXianShiChang: Int16
    @State var baoXianRiQi: Date
    @State var baoXian: Bool
    
    @State var zhiWu: String
    @State var tel: [Tel]
    @State var telArray: [Int]
    @State var tel1: String
    @State var tel2: String
    @State var tel3: String
    @State var tel4: String
    @State var tel5: String
    @State var xiangMuArray: [Int]
    @State var xiangMu1: String
    @State var xiangMu2: String
    @State var xiangMu3: String
    
    
    @State private var isImagePickerPresented = false
    @State private var selectedImage: UIImage?
    
    
    
    var body: some View {
        NavigationStack {
            ///头部
            if edit {
                Image("touxiang111")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80)
                    .cornerRadius(40)
                
                if let image = selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 80, height: 80)
                        .cornerRadius(40)
                } else {
                    Text("无照片")
                }
                Button("选择照片") {
                    isImagePickerPresented.toggle()
                }
                .padding()
                .sheet(isPresented: $isImagePickerPresented) {
                    ImagePicker(selectedImage: $selectedImage)
                }
                
                
            } else {
                VStack {
                    HStack {
                        Image("touxiang111")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 60, height: 60)
                            .cornerRadius(30)
                            .padding(.horizontal)
                        //性别图标
                            .overlay {
                                Image(systemName: "star")
                                    .foregroundColor(xingBie ? .blue : .red)
                                    .frame(width: 30, height: 30)
                                    .offset(x: 20, y: 20)
                                    
                            }
                        VStack {
                            HStack {
                                //姓名
                                Text("\(xingMing)")
                                    .font(.title)
                                    .padding(.trailing, 16)
                                //司机标签
                                if zhiWu == "司机" || zhiWu == "驾驶员" {
                                    LabelView(title: jiaZhao == "" ? "无驾照" : jiaZhao, color: jiaZhao == "" ? .red : .blue)
                                }
                                //离职标签
                                if !zaiZhi {
                                    LabelView(title: "已离职", color: Color("wwysW"))
                                        .fontWeight(.bold)
                                } else {
                                    //新员工标签
                                    if calculateWorkAge(ruZhiShiJian: ruZhiShiJian, currentdate: Date()) ?? 100 < 1 {
                                        LabelView(title: "新员工", color: .green)
                                    }
                                }
                                Spacer()
                            }
                            HStack {
                                //项目标签
                                if xiangMu1 != "" {
                                    LabelView(title: xiangMu1, color: Color("wwysW"))
                                }
                                if xiangMu2 != "" {
                                    LabelView(title: xiangMu2, color: Color("wwysW"))
                                }
                                if xiangMu3 != "" {
                                    LabelView(title: xiangMu3, color: Color("wwysW"))
                                }
                                //职务标签
                                if zhiWu != "" {
                                    Image(systemName: "photo")
                                        .font(.system(size: 16))
                                        .foregroundColor(Color("wwysW2"))
                                        .offset(x: 8)
                                    Text(zhiWu)
                                        .font(.system(size: 16))
                                        .foregroundColor(Color("wwysW2"))
                                }
                                Spacer()
                            }
                        }
                    }
                    //异常标签
                    let baoXianAge = calculateWorkAge(ruZhiShiJian: baoXianRiQi, currentdate: Date()) ?? 12
                    if !edit {
                        if !baoXian || baoXianAge <= 1 {
                            HStack {
                                if !baoXian {
                                    LabelView(title: "未购保险", color: .red)
                                }
                                if baoXianAge <= 1 && baoXian {
                                    LabelView(title: "保险即将到期", color: .red)
                                }
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                .padding(.top, 20)
            }
            
            ///以下是人员信息
            List {
                Group {
                    //离职原因
                    if !edit {
                        if !zaiZhi {
                            Section {
                                HStack {
                                    VStack(alignment: .leading) {
                                        listHeaderText(title: "离职原因：")
                                        Text("\(liZhiYuanYin)")
                                            .foregroundColor(.gray)
                                            .lineLimit(5)
                                    }
                                }
                            }
                        }
                    }
                    //基本信息
                    if edit {
                        Section {
                            HStack {
                                xingMing == "" ? Text("姓名：").foregroundColor(.red).fontWeight(.bold) : Text("姓名：").fontWeight(.bold)
                                TextField("请输入姓名", text: $xingMing)
                            }
                            
                            Button {
                                xingBie.toggle()
                            } label: {
                                HStack {
                                    Text("性别：")
                                        .foregroundColor(Color("wwysBlack"))
                                        .fontWeight(.bold)
                                    Text(xingBie ? "男" : "女")
                                        .foregroundColor(Color("wwysBlack"))
                                    Spacer()
                                    Text("更改")
                                }
                            }

                            
                            
                            //项目
                            ForEach(xiangMuArray, id: \.self) { i in
                                if i == 1 {
                                    Button {
                                        self.showXiangMuXuanZheView1 = true
                                    } label: {
                                        HStack {
                                            xiangMu1 == "" ? Text("部门：").foregroundColor(.red) : Text("部门：").foregroundColor(Color("wwysBlack")).fontWeight(.bold)
                                            Text("\(xiangMu1)")
                                                .foregroundColor(Color("wwysBlack"))
                                            Spacer()
                                            xiangMu1 == "" ? Text("选择部门") : Text("更改")
                                        }
                                    }
                                    .sheet(isPresented: $showXiangMuXuanZheView1) {
                                        XiangMuAddView(op1: xiangMu1, op2: xiangMu2, op3: xiangMu3, xiangMuText: $xiangMu1)
                                    }
                                }
                                if i == 2 {
                                    Button {
                                        self.showXiangMuXuanZheView2 = true
                                    } label: {
                                        HStack {
                                            Text("部门2：").foregroundColor(Color("wwysBlack")).fontWeight(.bold)
                                            Text("\(xiangMu2)")
                                                .foregroundColor(Color("wwysBlack"))
                                            Spacer()
                                            xiangMu2 == "" ? Text("选择部门") : Text("更改")
                                        }
                                    }
                                    .sheet(isPresented: $showXiangMuXuanZheView2) {
                                        XiangMuAddView(op1: xiangMu1, op2: xiangMu2, op3: xiangMu3, xiangMuText: $xiangMu2)
                                    }
                                }
                                if i == 3 {
                                    Button {
                                        self.showXiangMuXuanZheView3 = true
                                    } label: {
                                        HStack {
                                            Text("部门3：").foregroundColor(Color("wwysBlack")).fontWeight(.bold)
                                            Text("\(xiangMu3)")
                                                .foregroundColor(Color("wwysBlack"))
                                            Spacer()
                                            xiangMu3 == "" ? Text("选择部门") : Text("更改")
                                        }
                                    }
                                    .sheet(isPresented: $showXiangMuXuanZheView3) {
                                        XiangMuAddView(op1: xiangMu1, op2: xiangMu2, op3: xiangMu3, xiangMuText: $xiangMu3)
                                    }
                                }
                            }
                            Button {
                                var i = xiangMuArray.last
                                if i! < 3 {
                                    withAnimation {
                                        i! += 1
                                        xiangMuArray.append(i!)
                                    }
                                }
                            } label: {
                                if xiangMuArray.last! < 3 {
                                    HStack {
                                        Image(systemName: "plus")
                                        Text("添加部门")
                                        Spacer()
                                    }
                                } else {
                                    HStack{
                                        Text("已达上限，无法再添加")
                                        Spacer()
                                    }
                                    .foregroundColor(.gray)
                                }
                            }
                            
                            //职务
                            Button {
                                showZhiWuXuanZheView.toggle()
                            } label: {
                                HStack {
                                    zhiWu == "" ? Text("职务：").foregroundColor(.red) : Text("职务：").foregroundColor(Color("wwysBlack")).fontWeight(.bold)
                                    Text("\(zhiWu)")
                                        .foregroundColor(Color("wwysBlack"))
                                    Spacer()
                                    Text(zhiWu == "" ? "选择职务" : "更改")
                                }
                            }
                            .sheet(isPresented: $showZhiWuXuanZheView) {
                                ZhiWuXZuanZheView(zhiWuText: $zhiWu)
                            }
                        }
                    }
                }
                
                Group {
                    //电话
                    Section {
                        if edit {
                            ForEach(telArray, id: \.self) { i in
                                HStack {
                                    tel1 == "" && tel2 == "" && tel3 == "" && tel4 == "" && tel5 == "" ? Text("手机：").foregroundColor(.red) : Text("手机：")
                                    if i == 1 {
                                        TextField("请输入号码", text: $tel1)
                                            .keyboardType(.numberPad)
                                    }
                                    if i == 2 {
                                        TextField("请输入号码", text: $tel2)
                                            .keyboardType(.numberPad)
                                    }
                                    if i == 3 {
                                        TextField("请输入号码", text: $tel3)
                                            .keyboardType(.numberPad)
                                    }
                                    if i == 4 {
                                        TextField("请输入号码", text: $tel4)
                                            .keyboardType(.numberPad)
                                    }
                                    if i == 5 {
                                        TextField("请输入号码", text: $tel5)
                                            .keyboardType(.numberPad)
                                    }
                                }
                            }
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
                        } else {
                            TelView(telArray: tel)
                        }
                    }
                    
                    Section {
                        //入职时间
                        HStack {
                            if edit {
                                DatePicker("入职时间：", selection: $ruZhiShiJian, displayedComponents: .date)
                                    .environment(\.locale, Locale(identifier: "zh_CN"))
                            } else {
                                Text("入职时间：")
                                Text("\(ruZhiShiJian.dateString())")
                                    .foregroundColor(.gray)
                                Spacer()
                                //工龄标签
                                let workAge = calculateWorkAge(ruZhiShiJian: ruZhiShiJian, currentdate: Date()) ?? 0
                                if workAge >= 12 {
                                    Text("\(workAge/12) 工龄")
                                        .foregroundColor(.gray)
                                } else {
                                    //新入职标签
                                    if zaiZhi && workAge < 1 {
                                        Text("新入职")
                                            .foregroundColor(.gray)
                                    }
                                }
                            }
                        }
                        //保险
                        HStack {
                            let baoXianAge = calculateWorkAge(ruZhiShiJian: baoXianRiQi, currentdate: Date()) ?? 12
                            if edit {
                                Toggle(isOn: $baoXian.animation()) {
                                    HStack {
                                        Text("保险：")
                                        baoXian ? Text("已购买").foregroundColor(.green) : Text("未购买").foregroundColor(.purple)
                                    }
                                }
                            }else {
                                Text("保险：")
                                if baoXian {
                                    if baoXianAge > 1 {
                                        Text("已购买")
                                            .foregroundColor(.gray)
                                    }
                                    if baoXianAge <= 1 {
                                        Text("即将到期")
                                            .foregroundColor(.gray)
                                    }
                                } else {
                                    Text("未购买")
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        if baoXian {
                            if edit {
                                HStack {
                                    DatePicker("保险到期：", selection: $baoXianRiQi, displayedComponents: .date)
                                        .environment(\.locale, Locale(identifier: "zh_CN"))
                                }
                            } else {
                                HStack {
                                    Text("保险到期：")
                                    Text("\(baoXianRiQi.dateString())")
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                    
                    Section {
                        //出生日期
                        HStack {
                            if edit {
                                DatePicker("出生日期：", selection: $chuShengRiQi, displayedComponents: .date)
                                    .environment(\.locale, Locale(identifier: "zh_CN"))
                            } else {
                                let age = calculateAge(birthdate: chuShengRiQi, currentdate: Date()) ?? 0
                                Text("出生日期：")
                                Text("\(chuShengRiQi.dateString())")
                                    .foregroundColor(.gray)
                                Spacer()
                                //年龄标签
                                Text(age == 0 ? "" : "（\(age)岁）")
                                    .foregroundColor(.gray)
                            }
                        }
                        //身份证
                        HStack {
                            if edit {
                                shenFenZheng == "" ? Text("身份证：").foregroundColor(.red) : Text("身份证：")
                                TextField("请输入身份证号码", text: $shenFenZheng)
                            } else {
                                Text("身份证：")
                                Text("\(shenFenZheng)")
                                    .foregroundColor(.gray)

                            }
                        }
                        //住址
                        HStack {
                            if edit {
                                Text("住址：")
                                TextField("请输入住址", text: $zhuZhi)
                            } else {
                                Text("住址：")
                                Text(zhuZhi == "" ? "待完善..." : "\(zhuZhi)")
                                    .foregroundColor(.gray)
                            }
                        }
                        //文化
                        HStack {
                            if edit {
                                Menu {
                                    Button(action: {wenHua = "小学以下"}, label: {Text("无")})
                                    Button(action: {wenHua = "小学"}, label: {Text("小学")})
                                    Button(action: {wenHua = "初中"}, label: {Text("初中")})
                                    Button(action: {wenHua = "高中"}, label: {Text("高中")})
                                    Button(action: {wenHua = "中专"}, label: {Text("中专")})
                                    Button(action: {wenHua = "大学"}, label: {Text("大学")})
                                } label: {
                                    wenHua == "" ? Text("文化程度：").foregroundColor(.red) : Text("文化程度：").foregroundColor(Color("wwysBlack"))
                                    Text("\(wenHua)")
                                        .foregroundColor(Color("wwysBlack"))
                                    Spacer()
                                    Text("更改")
                                }
                            } else {
                                Text("文化程度：")
                                Text("\(wenHua)")
                                    .foregroundColor(.gray)
                            }
                        }
                        //驾照
                        HStack {
                            if edit {
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
                                        Text("\(jiaZhao)")
                                            .foregroundColor(Color("wwysBlack"))
                                        Spacer()
                                        Text("请选择驾照")
                                    }
                                })
                            }else {
                                Text("驾照：")
                                Text("\(jiaZhao)")
                                    .foregroundColor(.gray)
                            }
                        }
                        //婚姻
                        HStack {
                            if edit {
                                Button {
                                    hunYin.toggle()
                                } label: {
                                    HStack {
                                        Text("婚姻状况：")
                                            .foregroundColor(Color("wwysBlack"))
                                        Text(hunYin ? "已婚" : "未婚")
                                            .foregroundColor(Color("wwysBlack"))
                                        Spacer()
                                        Text("更改")
                                    }
                                }
                            } else {
                                HStack {
                                    Text("婚姻状况：")
                                    Text(hunYin ? "已婚" : "未婚")
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                    Section {
                        //在职
                        HStack {
                            if edit {
                                Toggle(isOn: $zaiZhi.animation()) {
                                    HStack {
                                        Text("是否在职：")
                                        zaiZhi ? Text("在职").foregroundColor(.green) : Text("已离职").foregroundColor(.purple)
                                    }
                                }
                            }else {
                                Text("是否在职：")
                                zaiZhi ? Text("在职").foregroundColor(.green) : Text("已离职").foregroundColor(.purple)
                            }
                        }
                        if !zaiZhi {
                            if edit {
                                VStack(alignment: .leading) {
                                    Text("离职原因：")
                                    TextEditor(text: $liZhiYuanYin)
                                        .frame(height: 120)
                                }
                            }
                        }
                    }
                    //备注
                    Section("备注：") {
                        if edit {
                            TextEditor(text: $beiZhu)
                                .frame(height: 200)
                        } else {
                            Text("\(beiZhu)")
                                .lineLimit(8)
                                .foregroundColor(.gray)
                        }
                    }
                }
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
            .navigationTitle(edit ? "编辑信息" : "人员详情")
            .navigationBarTitleDisplayMode(.inline)
            .listStyle(.grouped)
            .navigationBarBackButtonHidden(edit ? true : false)
            .navigationBarItems(leading: xAnNiu(edit: $edit, bool: isSheetMolde), trailing: Button(action: {
                if !edit {
                    withAnimation {edit.toggle()}
                }
                else {
                    if editRenYuanXinXiPanDuan() {
                        if chaChong() {
                            editRenYuanXinXiDoneAndSave(tels: tels)
                            withAnimation {edit.toggle()}
                        }
                        else {
                            isShowAlertCongMing = true
                        }
                    }
                    else {}
                }
            }, label: {
                if !edit {
                    Text("编辑")
                } else {
                    Text("完成")
                }
            }).disabled(!editRenYuanXinXiPanDuan()).controlSize(.small).buttonStyle(.bordered).buttonBorderShape(.capsule))
            .alert(isPresented: $isShowAlertCongMing) {
                Alert(title: Text("错误"), message: Text("与现有人员重名。"))
            }
        }
        
    }
//查重
    private func chaChong() -> Bool {
        var bool: Bool = true
        if renYuan.xingMing != xingMing {
            for i in renYuans {
                if i.xingMing == xingMing {
                    bool = false
                }
            }
        }
        return bool
    }
//信息判断是否能保存
    private func editRenYuanXinXiPanDuan() -> Bool {
        var xiangmubool: Bool = false
        let xiangmuarr = [xiangMu1, xiangMu2, xiangMu3]
        for i in xiangmuarr {
            if i != "" {
                xiangmubool = true
            }
        }
        var telbool:Bool = false
        let telarr: [String] = [tel1, tel2, tel3, tel4, tel5]
        for i in telarr {
            if i != "" {telbool = true}
        }
        if xingMing == "" || zhiWu == "" ||  shenFenZheng == "" || jiaZhao == "" || zhuZhi == "" || wenHua == "" || !xiangmubool || !telbool {
            return false
        }else{return true}
    }
//保存
    private func editRenYuanXinXiDoneAndSave(tels: FetchedResults<Tel>) {
        
        //更名流水记录
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
        if renYuan.ruZhiShiJian != ruZhiShiJian {
            LiuShuiJiLu_RenYuan(newLiuShui: LiuShui(context: viewContext), renyuan: renYuan, zhiwu: nil, xiangmu: nil, lieBie: "基本信息_变动_入职时间", beizhu: renYuan.ruZhiShiJian?.dateString(), houbeizhu: ruZhiShiJian.dateString(), sanRenYuan: xingMing, sanWuZi: nil, sanXiangMu: nil, sanZhiWu: nil, qianZhiWu: nil, qianXiangMu: nil)
            renYuan.ruZhiShiJian = ruZhiShiJian
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
        if tel1 != "" {
            let newTel1 = Tel(context: viewContext)
            newTel1.id = UUID()
            newTel1.haoMa = tel1
            newTel1.leiXing = "手机1"
            newTel1.renYuan = renYuan
        }
        if tel2 != "" {
            let newTel2 = Tel(context: viewContext)
            newTel2.id = UUID()
            newTel2.haoMa = tel2
            newTel2.leiXing = "手机2"
            newTel2.renYuan = renYuan
        }
        if tel3 != "" {
            let newTel3 = Tel(context: viewContext)
            newTel3.id = UUID()
            newTel3.haoMa = tel3
            newTel3.leiXing = "手机3"
            newTel3.renYuan = renYuan
        }
        if tel4 != "" {
            let newTel4 = Tel(context: viewContext)
            newTel4.id = UUID()
            newTel4.haoMa = tel4
            newTel4.leiXing = "手机4"
            newTel4.renYuan = renYuan
        }
        if tel5 != "" {
            let newTel5 = Tel(context: viewContext)
            newTel5.id = UUID()
            newTel5.haoMa = tel5
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
//关闭、取消按钮
private struct xAnNiu: View {
    @Binding var edit: Bool
    let bool: Bool
    @Environment(\.dismiss) private var dismiss
    var body: some View{
        if edit {
            Button {
                withAnimation {edit = false}
            } label: {
                Text("取消")
            }
            .controlSize(.small).buttonStyle(.bordered).buttonBorderShape(.capsule).opacity(edit ? 1 : 0)
        }
        if bool {
            Button {
                dismiss()
            } label: {
                Text("关闭")
            }
            .controlSize(.small).buttonStyle(.bordered).buttonBorderShape(.capsule)
        }
    }
}


//项目选择页面
struct XiangMuAddView: View {
    @State var showAddXiangMu2: Bool = false
    let op1: String
    let op2: String
    let op3: String
    @Binding var xiangMuText: String
    @Environment(\.dismiss) var dismiss3
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \XiangMu.mingCheng, ascending: true)], animation: .default)
    var xiangMus: FetchedResults<XiangMu>
    var body: some View {
        NavigationStack{
            List{
                Section {
                    Button(action: {
                        xiangMuText = ""
                        dismiss3()
                    }, label: {
                        Text("无项目")
                            .foregroundColor(Color("wwysBlack"))
                    })
                }
                Section {
                    ForEach(xiangMus, id: \.self, content: {
                        xiangmu in
                        if xiangmu.mingCheng != op1 && xiangmu.mingCheng != op2 && xiangmu.mingCheng != op3 {
                            Button(action: {
                                xiangMuText = xiangmu.mingCheng ?? ""
                                dismiss3()
                            }, label: {
                                Text("\(xiangmu.mingCheng ?? "")")
                                    .foregroundColor(Color("wwysBlack"))
                            })
                        }
                        
                    })
                }
                
                Button(action: {
                    self.showAddXiangMu2 = true
                }, label: {
                    HStack{
                        Spacer()
                        Text("添加项目")
                        Spacer()
                    }
                }).sheet(isPresented: $showAddXiangMu2, content: {
                    AddXiangMuView()
                })
            }
            .navigationTitle("选择所属项目")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading, content: {
                    Button(action: {
                        dismiss3()
                    }, label: {
                        Text("取消")
                    })
                })
            })
        }
        
    }
}

//职务选择页面
struct ZhiWuXZuanZheView: View {
    @State var showZhiWu2: Bool = false
    @Binding var zhiWuText: String
    @Environment(\.dismiss) var dismiss2
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \ZhiWu.mingCheng, ascending: true)], animation: .default)
    var zhiWus: FetchedResults<ZhiWu>
    var body: some View {
        
        NavigationStack{
            List{
                ForEach(zhiWus, id: \.self, content: {
                    zhiwu in
                    Button(action: {
                        zhiWuText = zhiwu.mingCheng ?? ""
                        dismiss2()
                    }, label: {
                        Text("\(zhiwu.mingCheng ?? "")")
                            .foregroundColor(Color("wwysBlack"))
                    })
                })
                Button(action: {
                    showZhiWu2 = true
                }, label: {
                    HStack{
                        Spacer()
                        Text("添加职务")
                        Spacer()
                    }
                }).sheet(isPresented: $showZhiWu2, content: {
                    AddZhiWuView()
                })
            }
            .navigationTitle("选择职务")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading, content: {
                    Button(action: {
                        dismiss2()
                    }, label: {
                        Text("取消")
                    })
                })
            })
        }
    }
}

//电话视图
struct TelView: View {
    let telArray: [Tel]
    var body: some View {
        if !telArray.isEmpty {
            ForEach(telArray, id: \.self, content: {
                tel in
                HStack{
                    Text("\(tel.leiXing ?? "手机")")
                    Button(action: {
//                        拨打电话
                    }, label: {
                        Text("\(tel.wHaoMa)")
                    })
                }
            })
        }else{
            Text("无电话号码")
                .foregroundColor(.gray)
        }
    }
}

//#Preview {
//    NewRenYuanSuJuView()
//}



