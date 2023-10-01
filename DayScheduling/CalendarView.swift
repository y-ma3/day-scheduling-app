import SwiftUI
import FSCalendar

struct CalendarView: View {
    @State private var selectedDate: Date?

    var body: some View {
        NavigationView {
            VStack {
                FSCalendarWrapper(selectedDate: $selectedDate)

                // NavigationLinkを使って新しいビューにプッシュ遷移する
                NavigationLink(destination: PushView(selectedDate: self.$selectedDate)) {
                    Text("この日の予定を確認")
                        .padding()
                }
                .disabled(selectedDate == nil) // 日付が選択されていない場合は無効にする
            }
        }
    }
}

// FSCalendarをSwiftUIに統合するためのラッパービュー
struct FSCalendarWrapper: UIViewRepresentable {
    @Binding var selectedDate: Date?

    func makeUIView(context: Context) -> FSCalendar {
        let fsCalendar = FSCalendar()
        fsCalendar.dataSource = context.coordinator
        fsCalendar.delegate = context.coordinator
        // その他のカレンダーのカスタマイズ設定を行う
        fsCalendar.scrollDirection = .vertical
        fsCalendar.locale = Locale(identifier: "ja")

        return fsCalendar
    }

    func updateUIView(_ uiView: FSCalendar, context: Context) {
        // カレンダーの表示をアップデートするためのコード
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, FSCalendarDelegate, FSCalendarDataSource {
        var parent: FSCalendarWrapper

        init(_ parent: FSCalendarWrapper) {
            self.parent = parent
        }

        // カレンダーの日付が選択されたときの処理
        func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
            parent.selectedDate = date
        }
    }
}

#Preview {
    CalendarView()
}
