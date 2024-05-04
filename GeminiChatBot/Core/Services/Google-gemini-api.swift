//
//  Google-gemini-api.swift
//  GeminiChatBot
//
//  Created by Elvin Sestomi on 01/05/24.
//

import Foundation
import GoogleGenerativeAI

class GoogleGenerative {
    
    static public var shared = GoogleGenerative()
    
    var apiKey : String = {
        guard let filePath = Bundle.main.path(forResource: "google-api-info", ofType: "plist") else {
            fatalError("google-api-info not available, check your project is the plist file available")
        }
        
        let plist = NSDictionary(contentsOfFile: filePath)
        
        guard let value = plist?.object(forKey: "gemini_api_key") as? String else { 
            fatalError("Couldn't find key 'API_KEY' in 'GenerativeAI-Info.plist'.")
        }
        
        if value.starts(with: "_") {
            fatalError("the google API start with underscore and is not allowed")
        }
        return value
    }()
    
    var model : GenerativeModel
    var chat : Chat
    init() {
        self.model = GenerativeModel(name: "gemini-pro", apiKey: apiKey,generationConfig: GenerationConfig(maxOutputTokens: 100))
        self.chat = model.startChat()
    }
    
    func sendRequest(prompt : String) async -> String {
        let response = try? await chat.sendMessage(prompt)
        if let resp = response {
            return resp.text ?? "sorry, your response is not available"
        } else {
            print("Response : \(String(describing: response))")
            return "Error, please check your internet"
        }
    }
}
