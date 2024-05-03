//
//  interactorProtocol.swift
//  Elvin'sGemini
//
//  Created by Elvin Sestomi on 30/04/24.
//

import Foundation
import Combine
import ExyteChat

protocol ChatInteractorProtocol {
    var messages: CurrentValueSubject<[MockChat], Never> { get }
    var sender: ExyteChat.User? { get }
    var gemini: ExyteChat.User { get }

    func send(draftMessage: ExyteChat.DraftMessage)

    func fetchGemini(request : String)
    func didFetchRequest(draftMessage : ExyteChat.DraftMessage)
}
