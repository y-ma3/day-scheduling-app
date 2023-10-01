import Foundation
import SwiftData

@Model
class Task {
    var name: String
    let date: Date
    var start: Date
    var end: Date

    init(name: String, date: Date, start: Date, end: Date) {
        self.name = name
        self.date = date
        self.start = start
        self.end = end
    }
}
