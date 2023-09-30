import Foundation
import SwiftData

@Model
class Task {
    var name: String
    let date: Date
    var startTime: String
    var endTime: String

    init(name: String, startTime: String, endTime: String) {
        self.name = name
        date = Date()
        self.startTime = startTime
        self.endTime = endTime
    }
}
