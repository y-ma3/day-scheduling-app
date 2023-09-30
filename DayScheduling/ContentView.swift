import SwiftUI

struct ContentView: View {
    
    @State var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            MainView()
                .tabItem() {
                    Label("時系列", systemImage: "calendar.day.timeline.left")
                }
                .tag(0)
            MainView()
                .tabItem() {
                    Label("ToDo", systemImage: "gearshape")
                }
                .tag(1)
        }
    }
}

#Preview {
    ContentView()
}
