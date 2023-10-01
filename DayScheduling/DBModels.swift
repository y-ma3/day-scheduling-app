import Foundation
import SwiftData

@Model
class Task {
    var name: String
    let date: Date
    var start: Date
    var end: Date

    init(name: String, start: Date, end: Date) {
        self.name = name
        date = Date()
        self.start = start
        self.end = end
    }
}
