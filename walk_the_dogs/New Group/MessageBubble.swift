

import SwiftUI

struct MessageBubble: View {
    
    var message: Message
    
    @State private var showTime = false
    
    
    var body: some View {
        VStack(alignment: message.received ? .leading : .trailing){
            HStack{
                Text(message.text)
                    .padding()
                    .font(.body)
                    .foregroundColor(.black)
//                    .background(message.received ? Color("Gray") : Color("Peach"))
                    .background(message.received ? Color.chatGray : Color.chatPeach)
                    .cornerRadius(30)
            }
            .frame(maxWidth: 300, alignment: message.received ? .leading : .trailing)
            .onTapGesture {
                showTime.toggle()
            }
            
            if showTime {
                Text("\(message.timestamp.formatted(.dateTime.hour().minute()))")
                    .font(.caption2)
                    .foregroundColor(.gray)
                    .padding(message.received ? .leading : .trailing, 25)
            }
        }
        .frame(maxWidth: .infinity, alignment: message.received ? .leading : .trailing)
        .padding(message.received ? .leading : .trailing)
        .padding(.horizontal, 10)
    }
}

struct MessageBubble_Previews: PreviewProvider {
    static var previews: some View {
        MessageBubble(message: Message(id: "123", text: "Hello there! I've been coding swiftui from scratch for a long time, and it's so fun.", received: true, timestamp: Date()))
    }
}
