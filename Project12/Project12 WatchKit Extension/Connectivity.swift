//
//  Connectivity.swift
//  Project12
//
//  Created by Joel Sereno on 1/15/22.
//

import Foundation
import WatchConnectivity


class Connectivity: NSObject, ObservableObject, WCSessionDelegate{
    
    @Published var receivedText = ""
    
    override init() {
        super.init()
        
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
    
    func transferUserInfo(_ userInfo: [String: Any]){
        let session = WCSession.default
        
        if session.activationState == .activated{
            session.transferUserInfo(userInfo)
        }
    }
    
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String: Any] = [:] ){
        DispatchQueue.main.async {
            if let text = userInfo["text"] as? String {
                self.receivedText = text
            }
        }
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String:Any], replyHandler: @escaping([String: Any]) -> Void) {
        DispatchQueue.main.async {
            if let text = message["text"] as? String {
                self.receivedText = text
                replyHandler(["response": "Be excellent to each other"])
            }
        }
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String: Any]){
        DispatchQueue.main.async {
            self.receivedText = "Application context received: \(applicationContext)"
        }
    }
    
    func sendMessage(_ data: [String: Any]){
        let session = WCSession.default
        
        if session.isReachable {
            session.sendMessage(data) { response in
                DispatchQueue.main.async {
                    self.receivedText = "Received response: \(response)"
                }
            }
        }
    }
    
    func setContext(to data: [String: Any]) {
        let session = WCSession.default
        
        if session.activationState == .activated {
            do {
                try session.updateApplicationContext(data)
            } catch {
                receivedText = "Alert! Updating app context failed"
            }
        }
    }
    
    //MARK: - Compiler Directives
    #if os(iOS)
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        //run on the main thread
        DispatchQueue.main.async {
            if activationState == .activated{
                if session.isWatchAppInstalled{
                    self.receivedText = "Watch app is installed!"
                }
            }
        }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    #else
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    #endif
}
