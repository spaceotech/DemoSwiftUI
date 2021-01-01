//
//  DetailView.swift
//  DemoSwiftUI
//


import SwiftUI

class ShuffleViewModel : ObservableObject {
    @Published var clear: (()->())?
    @Published var selectedTags = [String]()
}

struct DetailView : View {
    @ObservedObject var viewModel : ShuffleViewModel = ShuffleViewModel()
    @Environment(\.presentationMode) private var presentationMode
    
    /// Categories Filters
    let filters =  [
        ["$50-$100", "$101-$200", "$201-$500", "$500+"],
        ["Dark Gray", "Yellow", "Green", "Red", "Other"],
        ["Wool Fabric", "Leather Material", "Cotton", "Nylon", "Chiffon", "Silk Fabric"],
    ]
    
    /// sections
    let sections: [Header] = [Header("Range"),
                              Header("Color"),
                              Header("Types")]
    
    init(){
        UITableView.appearance().backgroundColor = .clear
        UITableView.appearance().separatorStyle = .none
    }
    
    /// view body
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                // Button dismiss view
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Back")
                        .fontWeight(.regular)
                        .font(.headline)
                        .padding(.leading, 16)
                        .foregroundColor(.blue)
                        .background(Color.clear)
                }
                
                Spacer()
                
                // Button clear all selected filters
                Button(action: {
                    self.viewModel.clear?()
                }) {
                    Text("Clear")
                        .fontWeight(.regular)
                        .font(.headline)
                        .padding()
                        .foregroundColor(.blue)
                        .background(Color.clear)
                }
                
            }.frame(minWidth: 0, maxHeight: 44, alignment: .topLeading)
            
            //Stack for section and tag load.
            VStack(spacing: 0) {
                ForEach(self.sections.indices, id: \.self) {idx in
                    SectionView(title: self.sections[idx].title ?? "", tags: self.filters[idx],viewModel: self.viewModel)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 200,  alignment: .topLeading)
                }
            }.frame(minWidth: 0, maxHeight: .infinity, alignment: .topLeading)
        }
    }
}


struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
