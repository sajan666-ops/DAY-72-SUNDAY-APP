//
//  ContentView.swift
//  FocusTime
//
//  Created by SAJAN  on 14/09/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            TimerView()
                .navigationTitle("FocusTime ⏱")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}


#Preview {
    ContentView()
}
