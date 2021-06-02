//
//  NFCReader.swift
//  BackendlessTestApp
//
//  Created by brad on 6/2/21.
//

import Foundation
import CoreNFC

class NFCReader: NSObject, NFCNDEFReaderSessionDelegate, NFCTagReaderSessionDelegate {
    func tagReaderSessionDidBecomeActive(_ session: NFCTagReaderSession) {
        <#code#>
    }
    
    func tagReaderSession(_ session: NFCTagReaderSession, didInvalidateWithError error: Error) {
        <#code#>
    }
    
    func tagReaderSession(_ session: NFCTagReaderSession, didDetect tags: [NFCTag]) {
        session.connect(to: tags.first) { (error: Error?) in
            if error != nil {
                session.invalidate(errorMessage: "Connection error. Please try again.")
                return
            }

            print("Connected to tag!")

            switch nfcTag {
            case .miFare(let discoveredTag):
                print("Got a MiFare tag!", discoveredTag.identifier, discoveredTag.mifareFamily)
            case .feliCa(let discoveredTag):
                print("Got a FeliCa tag!", discoveredTag.currentSystemCode, discoveredTag.currentIDm)
            case .iso15693(let discoveredTag):
                print("Got a ISO 15693 tag!", discoveredTag.icManufacturerCode, discoveredTag.icSerialNumber, discoveredTag.identifier)
            case .iso7816(let discoveredTag):
                print("Got a ISO 7816 tag!", discoveredTag.initialSelectedAID, discoveredTag.identifier)
            @unknown default:
                session.invalidate(errorMessage: "Unsupported tag!")
            }
    }
    
    
    func scan() {
        let session = NFCTagReaderSession(pollingOption: [.iso14443, .iso15693], delegate: self)
            session.begin()
    }
    
    // Implement the NDEF reader delegate protocol.
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        // Error handling
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        // Handle received messages
    }
    
}
