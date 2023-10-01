import SwiftUI
import SwiftData

struct ModalView: View {
    
    @Binding var isModal:Bool
    
    @State var startTime = Date()
    @State var endTime = Date()
    @State var taskName:String = ""
    @State var isNotification = false
    @FocusState var selectState: Bool
    
    @Environment(\.modelContext) private var context
    @Query private var tasks: [Task]
    
    var body: some View {
        VStack {
            Form {
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
                add(name: taskName, start: startTime, end: endTime)
                taskName = ""
                startTime = Date()
                endTime = Date()
                isModal = false
            })
        }.onAppear {
            UIDatePicker.appearance().minuteInterval = 15
        }
    }
    private func add(name: String, start: Date, end: Date) {
        let data = Task(name: name, start: startTime, end: endTime)
        context.insert(data)
    }
}

#Preview {
    ModalView(isModal: .constant(true))
        .modelContainer(for: Task.self)
}
