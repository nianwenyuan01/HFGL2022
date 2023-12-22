//
//  YeWu_PaiFa_View.swift
//  HFGL2022
//
//  Created by nwy on 2022/12/24.
//

import SwiftUI

struct YeWu_PaiFa_View: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \RenYuan.xingMing, ascending: true)], animation: .default)
    var renYuans: FetchedResults<RenYuan>
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \WuZi.mingCheng, ascending: true)], animation: .default)
    var wuZis: FetchedResults<WuZi>
    @State var isShowAlert1: Bool = false
    @State var showRenYuanXuanZhe: Bool = false
    @State var renYuanMingCheng: String = ""
    @State var showWuZiXuanZheView1: Bool = false
    @State var showWuZiXuanZheView2: Bool = false
    @State var showWuZiXuanZheView3: Bool = false
    @State var showWuZiXuanZheView4: Bool = false
    @State var showWuZiXuanZheView5: Bool = false
    @State var itemMingChengArr: [UUID] = []
    @State var itemID1: UUID? = nil
    @State var itemID2: UUID? = nil
    @State var itemID3: UUID? = nil
    @State var itemID4: UUID? = nil
    @State var itemID5: UUID? = nil
    @State var itemSuLiang1: Int16 = 1
    @State var itemSuLiang2: Int16 = 1
    @State var itemSuLiang3: Int16 = 1
    @State var itemSuLiang4: Int16 = 1
    @State var itemSuLiang5: Int16 = 1
    @State var isXuGuiHuan1: Bool = false
    @State var isXuGuiHuan2: Bool = false
    @State var isXuGuiHuan3: Bool = false
    @State var isXuGuiHuan4: Bool = false
    @State var isXuGuiHuan5: Bool = false
    @State var yuJiGuiHuanRiQi1: Date = Date()
    @State var yuJiGuiHuanRiQi2: Date = Date()
    @State var yuJiGuiHuanRiQi3: Date = Date()
    @State var yuJiGuiHuanRiQi4: Date = Date()
    @State var yuJiGuiHuanRiQi5: Date = Date()
    @State var itemSuLiangArr: [Int] = [1]
    @State var intabc: Int = 2

    var body: some View {
        NavigationStack{
            List(content: {
                Section(content: {
                    VStack{
                        HStack{
                            Text("物资派发给：")
                            Spacer()
                            if renYuanMingCheng == "" {
                                Button(action: {
                                    self.showRenYuanXuanZhe = true
                                }, label: {
                                    Text("请选择人员")
                                }).sheet(isPresented: $showRenYuanXuanZhe, content: {
                                    CaiGouRenXuanZheView(caiGouRenGet: $renYuanMingCheng)
                                })
                            }
                        }
                        if renYuanMingCheng != "" {
                            ForEach(renYuans, id: \.self, content: {
                                renYuan in
                                if renYuan.xingMing == renYuanMingCheng {
                                    HStack{
                                        Image("touxiang111")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 40, height: 40)
                                            .cornerRadius(20)
                                            .padding(.leading)
                                        Text(renYuan.wName)
                                        Spacer()
                                    }
                                }
                            })
                            Button(action: {
                                self.showRenYuanXuanZhe = true
                            }, label: {
                                Text("更换人员")
                            }).sheet(isPresented: $showRenYuanXuanZhe, content: {
                                CaiGouRenXuanZheView(caiGouRenGet: $renYuanMingCheng)
                            })
                        }
                    }
                })
                ForEach(itemSuLiangArr, id: \.self, content: {
                    i in
                    if i == 1 {
                        Section("物品\(i)", content: {
                            if itemID1 != nil {
                                ForEach(wuZis, id: \.self, content: {
                                    j in
                                    if j.id == itemID1 {
                                        HStack{
                                            Text("\(j.mingCheng ?? "")")
                                            Button(action: {
                                                self.showWuZiXuanZheView1 = true
                                            }, label: {
                                                HStack{
                                                    Spacer()
                                                    Text("更改")
                                                }
                                            })
                                            .sheet(isPresented: $showWuZiXuanZheView1, content: {WuZiXuanZheView(wuZiID: $itemID1, op1: itemID1, op2: itemID2, op3: itemID3, op4: itemID4, op5: itemID5)})
                                        }
                                        HStack{
                                            Text("数量：")
                                            Spacer()
                                            TextField("请输入数量", value: $itemSuLiang1, formatter: NumberFormatter())
                                                .frame(width: 60)
                                            Text(j.danWei ?? "")

                                        }
                                        Toggle(isOn: $isXuGuiHuan1.animation(), label: {
                                            if isXuGuiHuan1 {
                                                HStack{
                                                    Text("是否应归还：")
                                                    Text("应归还")
                                                        .foregroundColor(.green)
                                                }
                                            }else{
                                                HStack{
                                                    Text("是否应归还：")
                                                    Text("无需归还")
                                                        .foregroundColor(.purple)
                                                }
                                            }
                                        })
                                        if isXuGuiHuan1 {
                                            DatePicker("预计归还时间：", selection: $yuJiGuiHuanRiQi1, displayedComponents: .date)
                                        }
                                    }
                                })
                            }else{
                                Button(action: {
                                    self.showWuZiXuanZheView1 = true
                                }, label: {
                                    Text("选择物品")
                                })
                                .sheet(isPresented: $showWuZiXuanZheView1, content: {WuZiXuanZheView(wuZiID: $itemID1, op1: itemID1, op2: itemID2, op3: itemID3, op4: itemID4, op5: itemID5)})
                            }
                        })
                    }
                    if i == 2 {
                        Section("物品\(i)", content: {
                            if itemID2 != nil {
                                ForEach(wuZis, id: \.self, content: {
                                    j in
                                    if j.id == itemID2 {
                                        HStack{
                                            Text("\(j.mingCheng ?? "")")
                                            Button(action: {
                                                self.showWuZiXuanZheView2 = true
                                            }, label: {
                                                HStack{
                                                    Spacer()
                                                    Text("更改")
                                                }
                                            })
                                            .sheet(isPresented: $showWuZiXuanZheView2, content: {WuZiXuanZheView(wuZiID: $itemID2, op1: itemID1, op2: itemID2, op3: itemID3, op4: itemID4, op5: itemID5)})
                                        }
                                        HStack{
                                            Text("数量：")
                                            Spacer()
                                            TextField("请输入数量", value: $itemSuLiang2, formatter: NumberFormatter())
                                                .frame(width: 60)
                                            Text(j.danWei ?? "")

                                        }
                                        Toggle(isOn: $isXuGuiHuan2, label: {
                                            if isXuGuiHuan2 {
                                                HStack{
                                                    Text("是否应归还：")
                                                    Text("应归还")
                                                        .foregroundColor(.green)
                                                }
                                            }else{
                                                HStack{
                                                    Text("是否应归还：")
                                                    Text("无需归还")
                                                        .foregroundColor(.purple)
                                                }
                                            }
                                        })
                                        if isXuGuiHuan2 {
                                            DatePicker("预计归还时间：", selection: $yuJiGuiHuanRiQi2, displayedComponents: .date)
                                        }
                                    }
                                })
                            }else{
                                Button(action: {
                                    self.showWuZiXuanZheView2 = true
                                }, label: {
                                    Text("选择物品")
                                })
                                .sheet(isPresented: $showWuZiXuanZheView2, content: {WuZiXuanZheView(wuZiID: $itemID2, op1: itemID1, op2: itemID2, op3: itemID3, op4: itemID4, op5: itemID5)})
                            }
                        })
                    }
                    if i == 3 {
                        Section("物品\(i)", content: {
                            if itemID3 != nil {
                                ForEach(wuZis, id: \.self, content: {
                                    j in
                                    if j.id == itemID3 {
                                        HStack{
                                            Text("\(j.mingCheng ?? "")")
                                            Button(action: {
                                                self.showWuZiXuanZheView3 = true
                                            }, label: {
                                                HStack{
                                                    Spacer()
                                                    Text("更改")
                                                }
                                            })
                                            .sheet(isPresented: $showWuZiXuanZheView3, content: {WuZiXuanZheView(wuZiID: $itemID3, op1: itemID1, op2: itemID2, op3: itemID3, op4: itemID4, op5: itemID5)})
                                        }
                                        HStack{
                                            Text("数量：")
                                            Spacer()
                                            TextField("请输入数量", value: $itemSuLiang3, formatter: NumberFormatter())
                                                .frame(width: 60)
                                            Text(j.danWei ?? "")

                                        }
                                        Toggle(isOn: $isXuGuiHuan3, label: {
                                            if isXuGuiHuan3 {
                                                HStack{
                                                    Text("是否应归还：")
                                                    Text("应归还")
                                                        .foregroundColor(.green)
                                                }
                                            }else{
                                                HStack{
                                                    Text("是否应归还：")
                                                    Text("无需归还")
                                                        .foregroundColor(.purple)
                                                }
                                            }
                                        })
                                        if isXuGuiHuan3 {
                                            DatePicker("预计归还时间：", selection: $yuJiGuiHuanRiQi3, displayedComponents: .date)
                                        }
                                    }
                                })
                            }else{
                                Button(action: {
                                    self.showWuZiXuanZheView3 = true
                                }, label: {
                                    Text("选择物品")
                                })
                                .sheet(isPresented: $showWuZiXuanZheView3, content: {WuZiXuanZheView(wuZiID: $itemID3, op1: itemID1, op2: itemID2, op3: itemID3, op4: itemID4, op5: itemID5)})
                            }
                        })
                    }
                    if i == 4 {
                        Section("物品\(i)", content: {
                            if itemID4 != nil {
                                ForEach(wuZis, id: \.self, content: {
                                    j in
                                    if j.id == itemID4 {
                                        HStack{
                                            Text("\(j.mingCheng ?? "")")
                                            Button(action: {
                                                self.showWuZiXuanZheView4 = true
                                            }, label: {
                                                HStack{
                                                    Spacer()
                                                    Text("更改")
                                                }
                                            })
                                            .sheet(isPresented: $showWuZiXuanZheView4, content: {WuZiXuanZheView(wuZiID: $itemID4, op1: itemID1, op2: itemID2, op3: itemID3, op4: itemID4, op5: itemID5)})
                                        }
                                        HStack{
                                            Text("数量：")
                                            Spacer()
                                            TextField("请输入数量", value: $itemSuLiang4, formatter: NumberFormatter())
                                                .frame(width: 60)
                                            Text(j.danWei ?? "")

                                        }
                                        Toggle(isOn: $isXuGuiHuan4, label: {
                                            if isXuGuiHuan4 {
                                                HStack{
                                                    Text("是否应归还：")
                                                    Text("应归还")
                                                        .foregroundColor(.green)
                                                }
                                            }else{
                                                HStack{
                                                    Text("是否应归还：")
                                                    Text("无需归还")
                                                        .foregroundColor(.purple)
                                                }
                                            }
                                        })
                                        if isXuGuiHuan4 {
                                            DatePicker("预计归还时间：", selection: $yuJiGuiHuanRiQi4, displayedComponents: .date)
                                        }
                                    }
                                })
                            }else{
                                Button(action: {
                                    self.showWuZiXuanZheView4 = true
                                }, label: {
                                    Text("选择物品")
                                })
                                .sheet(isPresented: $showWuZiXuanZheView4, content: {WuZiXuanZheView(wuZiID: $itemID4, op1: itemID1, op2: itemID2, op3: itemID3, op4: itemID4, op5: itemID5)})
                            }
                        })
                    }
                    if i == 5 {
                        Section("物品\(i)", content: {
                            if itemID5 != nil {
                                ForEach(wuZis, id: \.self, content: {
                                    j in
                                    if j.id == itemID5 {
                                        HStack{
                                            Text("\(j.mingCheng ?? "")")
                                            Button(action: {
                                                self.showWuZiXuanZheView5 = true
                                            }, label: {
                                                HStack{
                                                    Spacer()
                                                    Text("更改")
                                                }
                                            })
                                            .sheet(isPresented: $showWuZiXuanZheView5, content: {WuZiXuanZheView(wuZiID: $itemID5, op1: itemID1, op2: itemID2, op3: itemID3, op4: itemID4, op5: itemID5)})
                                        }
                                        HStack{
                                            Text("数量：")
                                            Spacer()
                                            TextField("请输入数量", value: $itemSuLiang5, formatter: NumberFormatter())
                                                .frame(width: 60)
                                            Text(j.danWei ?? "")

                                        }
                                        Toggle(isOn: $isXuGuiHuan5, label: {
                                            if isXuGuiHuan5 {
                                                HStack{
                                                    Text("是否应归还：")
                                                    Text("应归还")
                                                        .foregroundColor(.green)
                                                }
                                            }else{
                                                HStack{
                                                    Text("是否应归还：")
                                                    Text("无需归还")
                                                        .foregroundColor(.purple)
                                                }
                                            }
                                        })
                                        if isXuGuiHuan5 {
                                            DatePicker("预计归还时间：", selection: $yuJiGuiHuanRiQi5, displayedComponents: .date)
                                        }
                                    }
                                })
                            }else{
                                Button(action: {
                                    self.showWuZiXuanZheView5 = true
                                }, label: {
                                    Text("选择物品")
                                })
                                .sheet(isPresented: $showWuZiXuanZheView5, content: {WuZiXuanZheView(wuZiID: $itemID5, op1: itemID1, op2: itemID2, op3: itemID3, op4: itemID4, op5: itemID5)})
                            }
                        })
                    }
                    
                })
                if intabc <= 5 {
                    Button(action: {
                        withAnimation{
                            itemSuLiangArr.append(intabc)
                            intabc += 1
                        }
                    }, label: {
                        Text("添加物品")
                    })
                }else{
                    Text("无法再添加物品")
                }
            })
            .listStyle(.grouped)
            .navigationBarTitle("派发物资")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing:
                Button(action: {
                if xinXiPanDuan() {
                    
                }else{
                    self.isShowAlert1 = true
                }
            }, label: {
                Text("完成")
            }).alert(isPresented: $isShowAlert1, content: {
                        Alert(title: Text("错误"), message: Text("请完善信息。"))
                    })
            )
        }
        
    }
    func xinXiPanDuan() -> Bool {
        var i: Bool = false
        if renYuanMingCheng != "" {
            if itemID1 != nil || itemID2 != nil || itemID3 != nil || itemID4 != nil || itemID5 != nil {
                i = true
            }
        }
        return i
    }
    func paiFaAction(){
        if itemID1 != nil {
            
        }
    }
    struct WuZiXuanZheView: View {
        @Environment(\.dismiss) var dismissWuZiXuanZheView
        @Binding var wuZiID: UUID?
        let op1: UUID?
        let op2: UUID?
        let op3: UUID?
        let op4: UUID?
        let op5: UUID?
        @Environment(\.managedObjectContext) private var viewContext
        @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \WuZi.mingCheng, ascending: true)], animation: .default)
        var wuZis: FetchedResults<WuZi>
        var body: some View {
            NavigationStack{
                List(content: {
                    Section(content: {
                        HStack{
                            Button(action: {
                                wuZiID = nil
                                dismissWuZiXuanZheView()
                            }, label: {
                                Text("无")
                            })
                        }
                    })
                    Section(content: {
                        ForEach(wuZis, id: \.self, content: {
                            wuZi in
                            if wuZi.id == op1 || wuZi.id == op2 || wuZi.id == op3 || wuZi.id == op4 || wuZi.id == op5 || wuZi.suLiang <= 0 {
                                HStack{
                                    Text("\(wuZi.mingCheng ?? "")")
                                        .foregroundColor(.gray)
                                    Spacer()
                                    Text("\(wuZi.suLiang)")
                                        .foregroundColor(.white)
                                        .font(.system(.headline))
                                        .frame(width: 40 , height: 18, alignment: .center)
                                        .minimumScaleFactor(0.5)
                                        .fixedSize(horizontal: true, vertical: true)
                                        .background(Color("wwysW"))
                                        .cornerRadius(9)
                                }
                            }else{
                                Button(action: {
                                    wuZiID = wuZi.id ?? UUID()
                                    dismissWuZiXuanZheView()
                                }, label: {
                                    HStack{
                                        Text("\(wuZi.mingCheng ?? "")")
                                        Spacer()
                                        Text("\(wuZi.suLiang)")
                                            .foregroundColor(.white)
                                            .font(.system(.headline))
                                            .frame(width: 40 , height: 18, alignment: .center)
                                            .minimumScaleFactor(0.5)
                                            .fixedSize(horizontal: true, vertical: true)
                                            .background(Color("wwysW"))
                                            .cornerRadius(9)
                                    }
                                })
                            }
                        })
                    })
                })
                .listStyle(.automatic)
                .navigationBarTitle("选择物品")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(leading: Button(action: {
                    dismissWuZiXuanZheView()
                }, label: {
                    Text("取消")
                }))
            }
        }
    }
}

struct YeWu_PaiFa_View_Previews: PreviewProvider {
    static var previews: some View {
        YeWu_PaiFa_View()
    }
}
