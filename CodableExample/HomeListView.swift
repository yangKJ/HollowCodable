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
                    Button {
                        path.append(item)
                        print(item.model ?? "")
                    } label: {
                        Text(item.rawValue)
                            .foregroundColor(Color("textColor"))
                    }
                }
            }
            .navigationDestination(for: TestCase.self) {
                ContentView(title: $0.rawValue, longText: $0.jsonString ?? "Convert JSON Failed.", color: $0.color)
            }
            .navigationTitle("HollowCodable")
        }
    }
}

struct HomeListView_Previews: PreviewProvider {
    static var previews: some View {
        HomeListView()
    }
}
