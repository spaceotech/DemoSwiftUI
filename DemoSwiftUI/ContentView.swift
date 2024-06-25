import SwiftUI

/// The main content view of the application
struct ContentView: View {
    /// State variable to control the presentation of the detail view
    @State private var showingDetail = false
    
    var body: some View {
        VStack {
            // Title
            Text("Filter Demo")
                .font(.largeTitle)
                .padding(.bottom, 20)
            
            // Button to show filter options
            Button(action: {
                self.showingDetail.toggle()
            }) {
                Text("Select Filter")
                    .font(.headline)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .sheet(isPresented: $showingDetail) {
                DetailView()
            }
        }
        .padding()
    }
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
