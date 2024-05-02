//
//  ChatRoomViewModel.swift
//  Elvin'sGemini
//
//  Created by Elvin Sestomi on 30/04/24.
//

import Foundation
import Combine
import ExyteChat

class ChatRoomViewModel : ObservableObject {
    private let chatInteractor : ChatInteractorProtocol
    private var googleGeminiAPI = GoogleGenerative.shared
    
    @Published var message : [Message] = []
    
    // TODO: Later on delete this
    func testInteractor() {
        ChatInteractor.testingMessages.forEach { msg in
            chatInteractor.send(draftMessage: DraftMessage(text: "send draft Message", medias: [], recording: nil, replyMessage: nil, createdAt: Date()))
        }
    }
    
    init(chatInteractor: ChatInteractorProtocol ) {
        self.chatInteractor = chatInteractor
    }
    
    func send(draft : DraftMessage) {
        chatInteractor.send(draftMessage: draft)
    }
    
    func onStop() {
        chatInteractor.disconnect()
    }
    
    func onStart() {
        chatInteractor.messages

//        to change the message from mockChat? into mockChat
            .compactMap { chat in
                chat.map{ $0.toChatMessage() }
            }.assign(to: &$message)
    }
}



extension DraftMessage {
    func toMockChat(user: User, status: Message.Status = .read) -> MockChat {
        MockChat(
            uid: self.id ?? UUID().uuidString,
            user: user,
            createdAt: Date(),
            status: status,
            text: self.text
        )
    }
}
