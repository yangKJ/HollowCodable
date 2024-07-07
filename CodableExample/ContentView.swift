//
//  ContentView.swift
//  CodableExample
//
//  Created by Condy on 2024/6/10.
//

import SwiftUI

struct ContentView: View {
    
    @State var title: String
    @State var longText: String
    @State var color: HollowColor?
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            TextEditor(text: $longText)
                .foregroundColor(color?.toColor ?? Color("textColor"))
                .font(.custom("HelveticaNeue", size: 18))
        }
        .padding()
        .navigationBarTitle(title, displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }, label: {
            Text("BACK")
                .font(.custom("HelveticaNeue", size: 16))
                .foregroundColor(Color("textColor"))
                .padding(.leading, 5)
        }))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(title: "Test Codable", longText: "  Hollow Word!")
    }
}

extension HollowColor {
    var toColor: Color? {
        #if canImport(AppKit)
        return Color(nsColor: self)
        #elseif canImport(UIKit)
        return Color(uiColor: self)
        #else
        return nil
        #endif
    }
}
