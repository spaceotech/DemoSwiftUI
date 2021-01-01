//
//  TagButton.swift
//  DemoSwiftUI
//


import SwiftUI

struct TagButton: View {
    
    let title: String
    @ObservedObject var viewModel : ShuffleViewModel
    
    private let vPad: CGFloat = 13
    private let hPad: CGFloat = 22
    private let radius: CGFloat = 24
    
    func clear(){
        self.viewModel.selectedTags.removeAll()
    }
    
    var body: some View {
        Button(action: {
            if self.viewModel.selectedTags.contains(self.title) == true {
                self.viewModel.selectedTags.remove(object: self.title)
            } else {
                self.viewModel.selectedTags.append(self.title)
            }
            self.viewModel.clear = {
                self.clear()
            }
        }) {
            if self.viewModel.selectedTags.contains(self.title) == true {
                HStack {
                    Text(title)
                        .font(.headline)
                }
                .padding(.vertical, vPad)
                .padding(.horizontal, hPad)
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(radius)
                .overlay(
                    RoundedRectangle(cornerRadius: radius)
                        .stroke(Color(UIColor.systemBackground), lineWidth: 1)
                )
                
            } else {
                HStack {
                    Text(title)
                        .font(.headline)
                        .fontWeight(.light)
                }
                .padding(.vertical, vPad)
                .padding(.horizontal, hPad)
                .foregroundColor(.gray)
                .overlay(
                    RoundedRectangle(cornerRadius: radius)
                        .stroke(Color.gray, lineWidth: 1)
                )
            }
        }
    }
}

extension Array where Element: Equatable {
    
    // Remove first collection element that is equal to the given `object`:
    mutating func remove(object: Element) {
        if let index = firstIndex(of: object) {
            remove(at: index)
        }
    }
}
