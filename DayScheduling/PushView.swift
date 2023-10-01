import SwiftUI

struct PushView: View {
    
    private let dateFormatter = DateFormatter()
    @Binding var selectedDate: Date?
    
    @State var isModal = false
    
    init(selectedDate: Binding<Date?>) {
        _selectedDate = selectedDate
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                Text(formatDate(selectedDate!)).font(.title)
                Spacer()
            }
            ButtonView(color: .blue, action: {
                isModal = true
            })
        }
    }

    private func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd(E)"
        dateFormatter.locale = Locale(identifier: "ja_jp")
        return dateFormatter.string(from: date)
    }
}

#Preview {
    PushView(selectedDate: .constant(Date()))
}
