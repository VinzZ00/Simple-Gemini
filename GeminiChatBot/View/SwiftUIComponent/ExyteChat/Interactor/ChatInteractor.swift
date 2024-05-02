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
    
    public static var testingMessages : [ExyteChat.Message] = {
        [
            MockChat.createMockChatForTest(addingTime: 0).toChatMessage(),
            MockChat.createMockChatForTest(addingTime: 2).toChatMessage()
        ]
    }()
    
    init(user : ExyteChat.User) {
        self.sender = user
    }
    
    var googleGenerative : GoogleGenerative = GoogleGenerative.shared
    var messages: AnyPublisher<[MockChat], Never> { chatState.eraseToAnyPublisher()
    }
    
    var sender: ExyteChat.User? = User(id: "1", name: "User", avatarURL: nil, isCurrentUser: true)
    
    var gemini: ExyteChat.User = User(
        id: "2",
        name: "Gemini",
        avatarURL: nil,
        isCurrentUser: false
    )
    private lazy var chatState = CurrentValueSubject<[MockChat], Never>([])
    
    
    
    func send(draftMessage: ExyteChat.DraftMessage) {
        // TODO: send request to gemini & call response
        
        // MARK: In-case of in need of validation
//        if draftMessage.id != nil {
//            guard let index = chatState.value.firstIndex(where: {$0.uid
//                == draftMessage.id}) else { return }
//            
//            chatState.value.remove(at: index)
//        }
        
        Task {
            let message = await draftMessage.toMockChat(user: sender!, status: .sent)
            DispatchQueue.main.async { [weak self] in
                self?.chatState.value.append(message)
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
                self?.chatState.value.append(message)
            }
        }
    }
    
    func disconnect() {
        
    }
    
    
    
    
    
}
