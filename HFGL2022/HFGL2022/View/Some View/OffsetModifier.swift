//
//  OffsetModifier.swift
//  HFGL2022
//
//  Created by nwy on 2022/12/17.
//

import SwiftUI

// 继承于 ViewModifier 最主要是能方便扩展一些常见的设置属性
/*
 比如 给Text设置字体\背景颜色\阴影效果
 extension Text {
     func songStyle() -> some View {
         self
             .font(.system(size: 24, weight: .bold))
             .foregroundColor(.white)
             .shadow(radius: 20)
     }
 }
 ⭐️如果是继承ViewModifier
 struct SongTextViewModifier: ViewModifier {
     func body(content: Content) -> some View {
         content
           .font(.system(size: 24, weight: .bold))
           .foregroundColor(.white)
           .shadow(radius: 20)
     }
 }
 然后直接通过
 Text(song)
       .modifier(SongTextViewModifier())
 设置
 */
struct OffsetModifier: ViewModifier {
    @Binding var offset: CGFloat
    // 可选从0返回值
    var returnFromStart: Bool = true
    @State var startValue: CGFloat = 222
    func body(content: Content) -> some View {
        content
            .overlay {
                GeometryReader{proxy in
                    Color.clear
                        .preference(key: OffsetKey.self, value: 1)
                        .onPreferenceChange(OffsetKey.self) { value in
                            if startValue == 1{
                                startValue = value
                            }
                            print(value);
                            offset = (value - (returnFromStart ? startValue : 2000))
                            print("offset is \(offset)");
                        }
                }
            }
    }
}
// 偏好的关键
struct OffsetKey: PreferenceKey{
    static var defaultValue: CGFloat = 1000
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
