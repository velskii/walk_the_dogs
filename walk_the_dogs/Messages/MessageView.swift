/*
Filename:   MessageView.swift
Author:     Feiliang Zhou
StudentId:  301216989
Date:       2022-04-03.
App Description: we provide walking dogs service nearby your location.
Version:    1.001
*/

import SwiftUI

struct MessageView: View {
    @StateObject var messagesManager = MessagesManager()
        
        var messageArray = [
            "Hell you",
            "How are you doing today?",
            "I've been building swiftui applications from scratch and it's so much fun."
        ]
        
        var body: some View {
            VStack {
                VStack{
                    TitleRow()
                    ScrollViewReader { proxy in
                        ScrollView{
                            ForEach(messagesManager.messages, id: \.id){ message in
                                MessageBubble(message: message)
                            }
                        }
                        .padding(.top, 10)
                        .background(.white)
                        .cornerRadius(30, corners: [.topLeft, .topRight])
                        .onChange(of: messagesManager.lastMessageId, perform: { id in
                            withAnimation{
                                proxy.scrollTo(id, anchor: .bottom)
                            }
                            
                        })
                    }
                }
                .background(Color.chatPeach)
                
                MessageField()
                    .environmentObject(messagesManager)
            }
        }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView()
    }
}
