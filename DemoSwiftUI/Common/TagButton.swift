import SwiftUI

/// A custom button view for selecting and deselecting tags
struct TagButton: View {
    
    // MARK: - Properties
    
    let title: String
    var viewModel: ShuffleViewModel
    
    // Button appearance constants
    private let verticalPadding: CGFloat = 13
    private let horizontalPadding: CGFloat = 22
    private let cornerRadius: CGFloat = 24
    
    // MARK: - Methods
    
    /// Clears all selected tags
    func clear() {
        self.viewModel.selectedTags.removeAll()
    }
    
    // MARK: - Body
    
    var body: some View {
        Button(action: {
            toggleTag()
        }) {
            buttonContent
        }
    }
    
    // MARK: - Private Views
    
    /// Determines the appearance of the button based on its selection state
    private var buttonContent: some View {
        HStack {
            Text(title)
                .font(.headline)
                .fontWeight(isSelected ? .regular : .light)
        }
        .padding(.vertical, verticalPadding)
        .padding(.horizontal, horizontalPadding)
        .foregroundColor(isSelected ? .white : .gray)
        .background(isSelected ? Color.blue : Color.clear)
        .cornerRadius(cornerRadius)
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(isSelected ? Color(UIColor.systemBackground) : Color.gray, lineWidth: 1)
        )
    }
    
    // MARK: - Private Helpers
    
    /// Checks if the current tag is selected
    private var isSelected: Bool {
        viewModel.selectedTags.contains(title)
    }
    
    /// Toggles the selection state of the tag
    private func toggleTag() {
        if isSelected {
            viewModel.selectedTags.remove(object: title)
        } else {
            viewModel.selectedTags.append(title)
        }
        
        viewModel.clear = {
            self.clear()
        }
    }
}

// MARK: - Array Extension

extension Array where Element: Equatable {
    /// Removes the first occurrence of a specified object from the array
    mutating func remove(object: Element) {
        if let index = firstIndex(of: object) {
            remove(at: index)
        }
    }
}
