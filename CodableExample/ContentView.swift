//
//  ContentView.swift
//  CodableExample
//
//  Created by Condy on 2024/6/10.
//

import SwiftUI

struct ContentView: View {
    
    static let datas = {
        let data = Res.jsonData("Codable")!
        //return [ApiResponse<Model>.deserialize(from: data)!]
        return ApiResponse<[Model]>.deserialize(from: data) ?? []
    }()
    
    @State var longText: String = (Self.datas.toJSONString(prettyPrint: true)) ?? "hellow word!"
    
    var color = Color(Self.datas.randomElement()?.color ?? .blue)
    var backgroundColor = Color(Self.datas.randomElement()?.background_color ?? .blue)
    
    var body: some View {
        VStack {
            Text("Test Codable")
                .font(.body)
                .italic()
                .background(backgroundColor)
            TextEditor(text: $longText)
                .foregroundColor(color)
                .font(.custom("HelveticaNeue", size: 18))
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
