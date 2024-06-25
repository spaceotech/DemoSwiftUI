import SwiftUI

/// View model for managing the shuffle feature and selected tags

@Observable class ShuffleViewModel {
     var clear: (() -> ())?
     var selectedTags = [String]()
}

/// A view that displays detailed filter options
struct DetailView: View {
    var viewModel = ShuffleViewModel()
    @Environment(\.presentationMode) private var presentationMode
    
    // MARK: - Filter Data
    
    /// Categories of filters
    let filters = [
        [Constant.filterRangeOne, Constant.filterRangeTwo, Constant.filterRangeThree, Constant.filterRangeFour],
        [Constant.filterColorOne, Constant.filterColorTwo, Constant.filterColorThree, Constant.filterColorFour, Constant.filterColorFive],
        [Constant.filterTypeOne, Constant.filterTypeTwo, Constant.filterTypeThree, Constant.filterTypeFour, Constant.filterTypeFive, Constant.filterTypeSix],
    ]
    
    /// Section headers
    let sections = [
        Header(Constant.headerFirst),
        Header(Constant.headerSecond),
        Header(Constant.headerThird)
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
            Text(Constant.backButton)
                .fontWeight(.regular)
                .font(.headline)
                .foregroundColor(.blue)
        }
    }
    
    private var clearButton: some View {
        Button(action: { self.viewModel.clear?() }) {
            Text(Constant.clearButton)
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

