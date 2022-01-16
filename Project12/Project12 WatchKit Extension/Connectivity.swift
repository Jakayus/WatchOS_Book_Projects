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
