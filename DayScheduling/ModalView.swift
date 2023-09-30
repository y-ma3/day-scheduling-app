import SwiftUI

struct ModalView: View {
    
    @State var startTime = Date()
    @State var endTime = Date()
    @State var taskName:String = ""
    @State var isNotification = false
    @FocusState var selectState: Bool
    
    init() {
        UIDatePicker.appearance().minuteInterval = 15
    }
    
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
            TaskAddButtonView(buttonText: "予定を追加", width: 200, color: .blue, action: {
                
            })
        }
    }
}

#Preview {
    ModalView()
}
