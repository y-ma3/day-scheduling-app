import SwiftUI
import SwiftData

@main
struct DaySchedulingApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Task.self)
        }
    }
}
