import SwiftUI
import SwiftData

struct ModalViewSecond: View {
    @State var startTime = Date()
    @State var endTime = Date()
    @State var taskName:String = ""
    @State var isNotification = false
    @FocusState var selectState: Bool
    
    @Environment(\.modelContext) private var context
    @Query private var tasks: [Task]
    
    @Binding var selectedDate: Date?
    
    var body: some View {
        VStack {
            Form {
                Text(formatDate(selectedDate!))
                    .font(.title)
                    
                HStack {
                    DatePicker("", selection: $startTime, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                    Text("〜")
                    DatePicker("", selection: $endTime, in: startTime..., displayedComponents: .hourAndMinute)
                        .labelsHidden()
                    Spacer()
                    Image(systemName: isNotification ? "bell" : "bell.slash")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .onTapGesture {
                            isNotification.toggle()
                        }
                }.padding()
                TextField("予定名", text: $taskName)
                    .font(.title)
                    .multilineTextAlignment(TextAlignment.center)
                    .focused($selectState, equals : true)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            }
            TextButtonView(buttonText: "予定を追加", width: 200, color: .blue, action: {
                add(name: taskName, date: selectedDate!, start: startTime, end: endTime)
                taskName = ""
                startTime = Date()
                endTime = Date()
            })
        }
        .onAppear {
            UIDatePicker.appearance().minuteInterval = 15
        }
    }
    
    private func add(name: String, date: Date, start: Date, end: Date) {
        let data = Task(name: name, date: selectedDate!, start: startTime, end: endTime)
        context.insert(data)
    }
    
    private func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd(E)"
        dateFormatter.locale = Locale(identifier: "ja_jp")
        return dateFormatter.string(from: date)
    }
}

#Preview {
    ModalViewSecond(selectedDate: .constant(Date()))
}
