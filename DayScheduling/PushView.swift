import SwiftUI
import SwiftData

struct PushView: View {
    
    private let dateFormatter = DateFormatter()
    private let timeFormatter = DateFormatter()
    @Binding var selectedDate: Date?
    
    @State var isModal2 = false
    
    @Environment(\.modelContext) private var context
    @Query(sort: \Task.start) private var tasks: [Task]
    
    init(selectedDate: Binding<Date?>) {
        _selectedDate = selectedDate
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                Text(formatDate(selectedDate!)).font(.title)
                Spacer()
                List {
                    ForEach(tasks) { task in
                        if formatDate(task.date) == formatDate(selectedDate!) {
                            VStack {
                                Text("\(formatTime(task.start)) ~ \(formatTime(task.end))")
                                    .padding(.bottom)
                                Text("\(task.name)").font(.title)
                                    .padding(.bottom)
                            }
                        }
                    }
                    .onDelete(perform: { indexSet in
                        for index in indexSet {
                            delete(task: tasks[index])
                        }
                    })
                }
            }
            ButtonView(color: .blue, action: {
                isModal2 = true
            })
        }
        .sheet(isPresented: $isModal2) {
            ModalViewSecond(selectedDate: self.$selectedDate)
                .presentationDetents([.large, .height(400), .fraction(0.5)])
        }
    }


    private func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd(E)"
        dateFormatter.locale = Locale(identifier: "ja_jp")
        return dateFormatter.string(from: date)
    }
                                 
    private func formatTime(_ date: Date) -> String {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        timeFormatter.locale = Locale(identifier: "ja_jp")
        return timeFormatter.string(from: date)
    }
    
    private func delete(task: Task) {
        context.delete(task)
    }
}

#Preview {
    PushView(selectedDate: .constant(Date()))
}
