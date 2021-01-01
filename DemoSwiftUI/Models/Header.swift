//
//  Header.swift
//  DemoSwiftUI


import SwiftUI

struct Header: Identifiable {
    /// unique id
    var id: String = UUID().uuidString
    
    /// post content
    let title: String?
    
    init(_ title: String) {
        self.title = title
    }
    
}
