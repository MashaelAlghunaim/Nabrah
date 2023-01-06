//
//  ContentView.swift
//  Nabrah
//
//  Created by Mashael Alghunaim on 11/06/1444 AH.
//

import SwiftUI

struct ContentView: View {
    @State var pickedTheme = "1"
    @State private var animateAquaColor = false
    @State private var animateSkyColor = false
    var body: some View {
        ZStack{
            Color("darkBlue")
                .ignoresSafeArea()
            VStack{
                Text("اختر اللغة المراد عرضها:").foregroundColor(Color.white)
                    .font(.system(size: 20))
                    .padding(.bottom, 700.0)
                    .padding(.leading,160.0)
                
                
            }
            
            Picker(" ", selection: $pickedTheme, content: {
                Text("العربية").tag("1")
                    .foregroundColor(.gray)
                Text("الإنجليزية").tag("2")
                
                
            }).padding(.bottom, 600.0).pickerStyle(.segmented)
                .padding(.horizontal)
            
            Divider()
            
                .frame(height:0.5)
                .background(Color.gray)
                .padding(.bottom, 540.0)
            VStack{
                Spacer()
                Spacer()
                Text("كُلي آذانٌ صاغية")
                    .foregroundColor(Color.white)
                    .font(.system(size: 30))
                    .padding(.top, 280)
            ZStack{
                    Circle()
                        .frame(width: 300, height: 300, alignment: .bottomLeading)
                        .foregroundColor(Color("veryMediumBlue"))
                    //  .padding(.top ,550)
                        .scaleEffect(animateSkyColor ? 1 : 0.8)
                        .animation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true).speed(2))
                        .onAppear(){
                            self.animateSkyColor.toggle()
                        }
                    Circle()
                        .frame(width: 200, height: 200, alignment: .bottomLeading)
                        .foregroundColor(Color("mediumblue"))
                    //   .padding(.top ,550)
                        .scaleEffect(animateSkyColor ? 1 : 1.5)
                        .animation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true).speed(3))
                        .onAppear(){
                            self.animateAquaColor.toggle()
                        }
                    
                    Image (systemName: "ear")
                        .font(.system(size: 100))
                        .foregroundColor(.white)
                        .frame(width: 200, height: 200)
                    
                }
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
