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
        let response = try? Decodering<ApiResponse<[Model]>>.decodering(Model.self, element: data)
        return response?.data ?? []
    }()
    
    @State var longText: String = (try? Self.datas.toJSONString(Model.self, prettyPrint: true)) ?? "hellow word!"
    
    var color = Color(Self.datas.randomElement()?.color ?? .blue)
    
    var body: some View {
        VStack {
            Text("Test Codable")
                .font(.body)
                .italic()
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
