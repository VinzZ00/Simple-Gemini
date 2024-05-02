//
//  Response.swift
//  Elvin'sGemini
//
//  Created by Elvin Sestomi on 30/04/24.
//

import Foundation
import ExyteChat

struct MockChat {
    let uid : String
    var user : User
    let createdAt : Date
    var status : Message.Status?
    var text : String
    
    public static func createMockChatForTest(addingTime : Int) -> MockChat {
        MockChat(
            uid: UUID().uuidString,
            user: User(id: "2", name: "Testing by system \(addingTime) to the future", avatarURL: nil, isCurrentUser: false),
            createdAt: Date().addingTimeInterval(TimeInterval(addingTime)),
            text: "Testing 1")
    }

}

extension MockChat {
    func toChatMessage() -> Message {
        Message(
            id: uid,
            user: user,
            status: status,
            createdAt: createdAt,
            text: text,
            attachments: [],
            recording: nil,
            replyMessage: nil
        )
    }
}
