//
//  ChatInteractor.swift
//  Elvin'sGemini
//
//  Created by Elvin Sestomi on 30/04/24.
//

import Foundation
import Combine
import ExyteChat

final class ChatInteractor : ChatInteractorProtocol {
    
    public static var testingMessages : [ExyteChat.Message] =
    [
        MockChat.createMockChatForTest(addingTime: 0).MockChatToMessage(),
        MockChat.createMockChatForTest(addingTime: 2).MockChatToMessage()
    ]
    
    init(user : ExyteChat.User) {
        self.sender = user
    }
    
    private var googleGenerative : GoogleGenerative = GoogleGenerative.shared
    
    
    var messages: CurrentValueSubject<[MockChat], Never> = CurrentValueSubject<[MockChat], Never>([])
    
    var sender: ExyteChat.User? = User(id: "1", name: "User", avatarURL: nil, isCurrentUser: true)
    
    let gemini: ExyteChat.User = User(
        id: "2",
        name: "Gemini",
        avatarURL: nil,
        isCurrentUser: false
    )
    
    func send(draftMessage: ExyteChat.DraftMessage) {
        let message = draftMessage.toMockChat(user: self.sender!, status: .sent)
        self.fetchGemini(request: message.text)
        self.messages.value.append(message)
    }
}

extension ChatInteractor {
    func fetchGemini(request : String) {
        Task {
            let response = await googleGenerative.sendRequest(prompt: request)
            DispatchQueue.main.async { [weak self] in
                self?.didFetchRequest(draftMessage: DraftMessage(
                    text: response,
                    medias: [],
                    recording: nil,
                    replyMessage: nil,
                    createdAt: Date()))
            }
        }
    }
    
    func didFetchRequest(draftMessage: ExyteChat.DraftMessage) {
        // TODO: convert from response to MockChat
        let message = draftMessage.toMockChat(user: gemini, status: .sent)
        self.messages.value.append(message)
    }
}
