//
//  GameServerWebsocket.swift
//  FitMove
//
//  Created by Peter Andrew on 11/10/20.
//

import Foundation
import Starscream

class GameServerWebsocket: WebSocketDelegate {
    static var instance:GameServerWebsocket? = nil
    let socket:WebSocket
    var isConnected = false
    var delegate:GameServerWebsocketDelegate? = nil
    init() {
        socket = WebSocket(request: URLRequest(url: URL(string: "ws://192.168.100.5:8000")!))
        socket.delegate = self
        socket.connect()
        var iteration = 0
        while(true && !isConnected && iteration < 10) {
            RunLoop.current.run(until: Date())
            usleep(10)
            iteration+=1
        }
    }
    
    static func getInstance() -> GameServerWebsocket {
        if let instance =  GameServerWebsocket.instance {
            return instance
        }
        GameServerWebsocket.instance = GameServerWebsocket()
        return GameServerWebsocket.getInstance()
    }
    
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
        case .connected( _):
            isConnected = true
        case .disconnected( _, _):
            self.isDisconnected()
        case .text(let text):
            self.receiveMessage(text)
        case .binary(let data):
          print("received data: \(data)")
        case .pong(_ ): break
          // process pong data
        case .ping(_ ): break
          // process ping data
        case .error(let error):
          print("error \(String(describing: error))")
        case .viabilityChanged: break
          // viability changes
        case .reconnectSuggested:
            self.reconnect()
        case .cancelled:
            self.isDisconnected()
        }
    }
    
    private func reconnect() {
        socket.disconnect()
        socket.connect()
    }
    
    private func receiveMessage(_ message:String) {
        if let delegate = self.delegate {
            delegate.didReceiveMessage(message)
        }
    }
    
    private func isDisconnected() {
        self.isConnected = false
        if let delegate = self.delegate {
            delegate.onDisconnect()
        }
    }
    
    // public function
    
    func send(_ message:String) {
        socket.write(string: message)
    }
}
