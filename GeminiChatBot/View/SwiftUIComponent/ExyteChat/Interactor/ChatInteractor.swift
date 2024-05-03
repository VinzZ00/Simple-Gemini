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
        MockChat.createMockChatForTest(addingTime: 0).toChatMessage(),
        MockChat.createMockChatForTest(addingTime: 2).toChatMessage()
    ]
    
    
    init(user : ExyteChat.User) {
        self.sender = user
    }
    
    var googleGenerative : GoogleGenerative = GoogleGenerative.shared
    
    
    var messages: CurrentValueSubject<[MockChat], Never> = CurrentValueSubject<[MockChat], Never>([])
    
    var sender: ExyteChat.User? = User(id: "1", name: "User", avatarURL: nil, isCurrentUser: true)
    
    var gemini: ExyteChat.User = User(
        id: "2",
        name: "Gemini",
        avatarURL: nil,
        isCurrentUser: false
    )

    
    
    
    func send(draftMessage: ExyteChat.DraftMessage) {
        Task {
            let message = await draftMessage.toMockChat(user: sender!, status: .sent)
            DispatchQueue.main.async { [weak self] in
                self?.messages.value.append(message)
            }
            fetchGemini(request: message.text)
        }
    }
    
    func fetchGemini(request : String) {
        Task {
            var response = await googleGenerative.sendRequest(prompt: request)
            didFetchRequest(draftMessage: DraftMessage(
                text: response,
                medias: [],
                recording: nil,
                replyMessage: nil,
                createdAt: Date()))
        }
    }
    
    func didFetchRequest(draftMessage: ExyteChat.DraftMessage) {
        // TODO: convert from response to MockChat
        Task {
            let message = await draftMessage.toMockChat(user: gemini, status: .sent)
            DispatchQueue.main.async { [weak self] in
                self?.messages.value.append(message)
            }
        }
    }
}
