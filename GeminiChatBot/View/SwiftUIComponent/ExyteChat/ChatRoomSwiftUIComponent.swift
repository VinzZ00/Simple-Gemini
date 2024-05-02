//
//  ChatRoomSwiftUIComponent.swift
//  Elvin'sGemini
//
//  Created by Elvin Sestomi on 30/04/24.
//

import Foundation
import SwiftUI
import ExyteChat

struct ChatRoomSwiftUIComponent: View {
    @ObservedObject var viewModel: ChatRoomViewModel
    //    = ChatRoomViewModel(chatInteractor: ChatInteractor(user: User(id: "1", name: "User", avatarURL: nil, isCurrentUser: true)))
    
    
    var body: some View {
        VStack {
            ChatView(messages: viewModel.message) { dm in
                viewModel.send(draft: dm)
            }
        inputViewBuilder: { textBinding, attachments, state, style, actionClosure, _  in
            Group {
                HStack {
                    TextField("Write your message", text: textBinding)
                        .lineLimit(nil)
                    Button { actionClosure(.send)
                        
                    } label: {
                        Image(systemName: "paperplane.fill")
                            .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                    }
                    .disabled((textBinding.wrappedValue.count < 1))
                }
                .padding()
                .background(.gray.opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding()
            }
        }
        .messageUseMarkdown(messageUseMarkdown: true)
        .chatNavigation(
            title: "Gemini",
            status: "online",
            cover: nil
        )
        .mediaPickerTheme(
            main: .init(
                text: .white
            ),
            selection: .init(
                emptyTint: .white,
                emptyBackground: .black.opacity(0.25),
                selectedTint: .blue,
                fullscreenTint: .white
            )
        )
        }
        .onAppear {
            viewModel.onStart()
//            // Only for test
//            viewModel.testInteractor()
        }
    }
}


