import SwiftUI

struct MainView: View {
    
    @State var nowDate = Date()
    @State var dateText = ""
    private let dateFormatter = DateFormatter()
    
    @State var isModal = false
    
    init() {
        dateFormatter.dateFormat = "YYYY/MM/dd(E)"
        dateFormatter.locale = Locale(identifier: "ja_jp")
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ButtonView(color: .blue, action: {
                isModal = true
            })
            VStack {
                Spacer()
                Text(dateText.isEmpty ? "\(dateFormatter.string(from: nowDate))" : dateText)
                    .font(.title)
                Spacer()
                ScrollView {
                    VStack {
                        
                    }
                }
            }
        }
        .sheet(isPresented: $isModal) {
            ModalView()
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                self.nowDate = Date()
                dateText = "\(dateFormatter.string(from: nowDate))"
            }
        }
    }
}

#Preview {
    MainView()
}
