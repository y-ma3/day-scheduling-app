import SwiftUI

struct ButtonView: View {
    
    var color: Color
    var action: () -> Void
    
    var body: some View {
        
        ZStack {
            Button (action: action) {
                ZStack {
                    Color.white.frame(width: 70, height: 70)
                        .cornerRadius(35)
                        .shadow(radius: 10)
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.black)
                }
            }
        }
    }
}

struct TextButtonView: View {
    
    var buttonText: String
    var width: CGFloat
    var color: Color
    var action: () -> Void
    
    var body: some View {
        
        Button (action: action) {
            ZStack {
                Color.white.frame(width: width, height: 50)
                    .cornerRadius(25)
                    .shadow(radius: 10)
                Text(buttonText)
                    .scaledToFill()
                    .foregroundColor(color)
            }
        }
    }
}
