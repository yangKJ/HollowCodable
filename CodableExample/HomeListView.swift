//
//  HomeListView.swift
//  CodableExample
//
//  Created by Condy on 2024/7/5.
//

import SwiftUI

struct HomeListView: View {
    
    @State private var path: NavigationPath = .init()
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(TestCase.allCases, id:\.self) { item in
                    NavigationLink(value: item) {
                        Text(item.rawValue)
                            .foregroundColor(Color("textColor"))
                    }
                }
            }
            .navigationDestination(for: TestCase.self) {
                ContentView(title: $0.rawValue, longText: $0.jsonString ?? "Convert JSON Failed.", color: $0.color)
            }
            .navigationTitle("HollowCodable")
            .navigationBarItems(trailing: Button(action: {
                path.append(TestCase.mix)
            }, label: {
                Text("mix test")
                    .font(.bold(.system(size: 24))())
                    .foregroundColor(.red)
                    .padding(.trailing, 5)
            }))
        }
    }
}

struct HomeListView_Previews: PreviewProvider {
    static var previews: some View {
        HomeListView()
    }
}
