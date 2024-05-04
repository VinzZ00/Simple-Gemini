//
//  ChatRoomSwiftUIComponent.swift
//  Elvin'sGemini
//
//  Created by Elvin Sestomi on 30/04/24.
//

import SwiftUI
import ExyteChat

struct ChatRoomSwiftUIComponent: View {
    @ObservedObject var viewModel: ChatRoomViewModel
    
    var body: some View {
        VStack {
            ChatView(messages: viewModel.message) { dm in
                viewModel.send(draft: dm)
            } inputViewBuilder: { textBinding, attachments, state, style, actionClosure, _  in
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
        }
        .onAppear {
            viewModel.onStart()
            //            // Only for test
            //            viewModel.testInteractor()
        }
    }
}


