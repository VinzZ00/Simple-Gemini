//
//  draftMessage+MockChat.swift
//  GeminiChatBot
//
//  Created by Elvin Sestomi on 01/05/24.
//

import Foundation
import ExyteChat

extension DraftMessage {
    func toMockChat(user: User, status: Message.Status = .read) async -> MockChat {
        
        MockChat(
            uid: id ?? UUID().uuidString,
            user: user,
            createdAt: self.createdAt,
            text: self.text)
        

    }
}

