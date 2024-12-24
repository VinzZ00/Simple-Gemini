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
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            ChatView(messages: viewModel.message) { dm in
                viewModel.send(draft: dm)
            } inputViewBuilder: { textBinding, attachments, state, style, actionClosure, _  in
                Group {
                    HStack {
                        TextField("", text: textBinding)
                            .lineLimit(nil)
                            .overlay(
                                    Text("Write your message")
                                        .opacity(textBinding.wrappedValue.isEmpty ? 1 : 0)
                                        .foregroundStyle(colorScheme
                                                         == .dark ? .white.opacity(0.5) : .black.opacity(0.5))
                                        .padding(.leading, 8), alignment: .leading
                                )
                            .foregroundStyle(colorScheme == .dark ? .white : .black)
                        Button { actionClosure(.send)
                            
                        } label: {
                            Image(systemName: "paperplane.fill")
                                .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                        }
                        .disabled((textBinding.wrappedValue.count < 1))
                    }
                    .padding()
                    .background(colorScheme == .dark ? .black
                                : .gray.opacity(0.3))
                    
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding()
                }
            }
        }
        .onAppear {
            viewModel.onStart()
        }
    }
}


