import SwiftUI

/// View model for managing the shuffle feature and selected tags
class ShuffleViewModel: ObservableObject {
    @Published var clear: (() -> ())?
    @Published var selectedTags = [String]()
}

/// A view that displays detailed filter options
struct DetailView: View {
    @ObservedObject var viewModel = ShuffleViewModel()
    @Environment(\.presentationMode) private var presentationMode
    
    // MARK: - Filter Data
    
    /// Categories of filters
    let filters = [
        ["$50-$100", "$101-$200", "$201-$500", "$500+"],
        ["Dark Gray", "Yellow", "Green", "Red", "Other"],
        ["Wool Fabric", "Leather Material", "Cotton", "Nylon", "Chiffon", "Silk Fabric"],
    ]
    
    /// Section headers
    let sections = [
        Header("Range"),
        Header("Color"),
        Header("Types")
    ]
    
    // MARK: - Initialization
    
    init() {
        // Customize the appearance of UITableView
        UITableView.appearance().backgroundColor = .clear
        UITableView.appearance().separatorStyle = .none
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            navigationBar
            filterSections
        }
    }
    
    // MARK: - Private Views
    
    private var navigationBar: some View {
        HStack {
            backButton
            Spacer()
            clearButton
        }
        .frame(height: 44)
        .padding(.horizontal)
    }
    
    private var backButton: some View {
        Button(action: { self.presentationMode.wrappedValue.dismiss() }) {
            Text("Back")
                .fontWeight(.regular)
                .font(.headline)
                .foregroundColor(.blue)
        }
    }
    
    private var clearButton: some View {
        Button(action: { self.viewModel.clear?() }) {
            Text("Clear")
                .fontWeight(.regular)
                .font(.headline)
                .foregroundColor(.blue)
        }
    }
    
    private var filterSections: some View {
            VStack(spacing: 0) {
                ForEach(sections.indices, id: \.self) { idx in
                    SectionView(
                        title: self.sections[idx].title ?? "",
                        tags: self.filters[idx],
                        viewModel: self.viewModel
                    ).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 200,  alignment: .topLeading)
                }
            }.frame(minWidth: 0, maxHeight: .infinity, alignment: .topLeading)
    }
}

// MARK: - Preview

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}

