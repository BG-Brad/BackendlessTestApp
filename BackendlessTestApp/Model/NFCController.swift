//
//  NFCController.swift
//  BackendlessTestApp
//
//  Created by brad on 6/2/21.
//

import Foundation
import CoreNFC


class NFCController : NSObject, ObservableObject {
    
    @Published var objectID = ""
    @Published var nfcScanned = false
    
    var nfcSession: NFCNDEFReaderSession?
    
    func startNFCReaderSession(invalidateAfterFirstRead : Bool = true) {
        self.nfcSession = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: invalidateAfterFirstRead)
        self.nfcSession?.alertMessage = "Hold your iPhone near a tag to read it."
        self.nfcSession?.begin()
    }
    
}

extension NFCController : NFCNDEFReaderSessionDelegate {
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        //
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        guard let nfcMessage = messages.first,
              let record  = nfcMessage.records.first,
              record.typeNameFormat == .absoluteURI || record.typeNameFormat == .nfcWellKnown,
              let payload = String(data: record.payload, encoding: .utf8)?.dropFirst(3)
              
      
       
        
        else {
            return
        }
        print(payload)
        DispatchQueue.main.async {
            self.objectID = String(payload)
            self.nfcScanned = true
        }
       
    }
    
    
}
