import SwiftUI
import SwiftData

struct MainView: View {
    
    @State var nowDate = Date()
    @State var dateText = ""
    private let dateFormatter = DateFormatter()
    private let timeFormatter = DateFormatter()
    
    @State var isModal = false
    
    @Environment(\.modelContext) private var context
    @Query(sort: \Task.start) private var tasks: [Task]
    
    init() {
        dateFormatter.dateFormat = "YYYY/MM/dd(E)"
        timeFormatter.dateFormat = "HH:mm"
        dateFormatter.locale = Locale(identifier: "ja_jp")
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                Spacer()
                Text(dateText.isEmpty ? "\(dateFormatter.string(from: nowDate))" : dateText)
                    .font(.title)
                Spacer()
                List {
                    ForEach(tasks) { task in
                        VStack {
                            Text("\(timeFormatter.string(from: task.start)) ~ \(timeFormatter.string(from: task.end))")
                                .padding(.bottom)
                            Text("\(task.name)").font(.title)
                                .padding(.bottom)
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
                isModal = true
            })
        }
        .sheet(isPresented: $isModal) {
            ModalView()
                .presentationDetents([.medium])
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                self.nowDate = Date()
                dateText = "\(dateFormatter.string(from: nowDate))"
            }
        }
    }
    private func delete(task: Task) {
        context.delete(task)
    }
}

#Preview {
    MainView()
        .modelContainer(for: Task.self)
}
