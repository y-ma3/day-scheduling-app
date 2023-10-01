import SwiftUI
import SwiftData

struct ContentView: View {
    
    @State var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            MainView()
                .tabItem() {
                    Label("時系列", systemImage: "calendar.day.timeline.left")
                }
                .tag(0)
            CalendarView()
                .tabItem() {
                    Label("カレンダー", systemImage: "calendar")
                }
                .tag(1)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Task.self)
}
