//
//  TextView.swift
//  Nabrah
//
//  Created by Mashael Alghunaim on 12/06/1444 AH.
//

import SwiftUI

struct TextView: View {
    @State private var dismisss = false
    var body: some View {
            ZStack{
                Color("darkBlue")
                    .ignoresSafeArea()
                VStack{
                    Button("إلغاء"){
                        dismisss.toggle()
                    }.foregroundColor(Color.white).padding(.trailing, 220)
                        .padding()
                    if dismisss{
                        // stop translation and go back to main page
                    }
                }
            }
    }
}

struct TextView_Previews: PreviewProvider {
    static var previews: some View {
        TextView()
    }
}
