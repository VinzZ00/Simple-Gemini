//
//  ViewController.swift
//  Elvin'sGemini
//
//  Created by Elvin Sestomi on 30/04/24.
//

import UIKit
import SwiftUI
import ExyteChat


class ChatRoom: UIViewController {
    
    var greeting : UILabel = {
        var l = UILabel()
        l.text = "Welcome to simplest Gemini, enjoy your self :)"
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    var uiviewChat : UIHostingController = {
        
        var view = ChatRoomSwiftUIComponent(
            viewModel: ChatRoomViewModel(
                chatInteractor: ChatInteractor(
                    user: User(id: "1", name: "Elvin", avatarURL: nil, isCurrentUser: true)
                )
            )
        )
        
        var hostingController : UIHostingController = UIHostingController(rootView: view)
        
        return hostingController
    }()
    
    
    
    
    override func loadView() {
        super.loadView()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
//        view.addSubview(uiLabel)
        
//        NSLayoutConstraint.activate([
//            uiLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            uiLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            uiLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor)
//        ])
        
        addChild(uiviewChat)
        
        view.addSubview(uiviewChat.view)
        view.addSubview(greeting)
        
        view.subviews.forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        
        
        let constraints = [
            greeting.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            greeting.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            greeting.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            greeting.heightAnchor.constraint(equalToConstant: 75),
            uiviewChat.view.topAnchor.constraint(equalTo: greeting.bottomAnchor, constant: 20),
            uiviewChat.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            uiviewChat.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            uiviewChat.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}



