//
//  ContentView.swift
//  DemoSwiftUI
//


import SwiftUI

struct ContentView: View {
    @State var showingDetail = false
    
    var body: some View {
        Button(action: {
            self.showingDetail.toggle()
        }) {
            Text("Select Filter")
        }.sheet(isPresented: $showingDetail) {
            DetailView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
