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
    
    func onStart() {
        chatInteractor.messages
//        to change the message from mockChat? into mockChat
            .compactMap { chat in
                chat.map{ $0.MockChatToMessage() }
            }.assign(to: &$message)
    }
}
