import Foundation
import SwiftUI
import CoreNFC

class NFCData : ObservableObject {
    @Published var nfcTag = ""
    @Published var showingTag = false
}

struct nfcButton : UIViewRepresentable {
    
    @ObservedObject var nfcData = NFCData()
    @Binding var data : String
    
    func makeUIView(context: UIViewRepresentableContext<nfcButton>) -> UIButton {
        let button = UIButton()
        button.setTitle("Read NFC", for: .normal )
       button.backgroundColor = UIColor.blue
        button.addTarget(context.coordinator, action: #selector(context.coordinator.beginScan(_:)), for: .touchUpInside)
        return button
    }
    
    func updateUIView(_ uiView: UIButton, context: Context) {
        // Nothing
    }
    
    func makeCoordinator() -> nfcButton.Coordinator {
        return Coordinator(data: $data)
    }
    
    class Coordinator : NSObject, NFCNDEFReaderSessionDelegate {
        
        var session : NFCNDEFReaderSession?
        @Binding var data : String
        @ObservedObject var nfcData = NFCData()
        
        init(data: Binding<String>) {
            _data = data
        }
        
        
        @objc func beginScan(_ sender: Any) {
            guard NFCNDEFReaderSession.readingAvailable else {
                print("error no NFC Available")
                return
            }
            session = NFCNDEFReaderSession(delegate: self, queue: .main, invalidateAfterFirstRead: true)
            session?.alertMessage = "Hold Your iPhone Near To Scan"
            session?.begin()
        }
        
        func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
            if let readerError = error as? NFCReaderError {
                if (readerError.code != .readerSessionInvalidationErrorFirstNDEFTagRead) && (readerError.code != .readerSessionInvalidationErrorUserCanceled) {
                    print("Error nfc read \(readerError.localizedDescription)")
                }
            }
            self.session = nil
        }
        
        func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
            guard let nfcMessage = messages.first,
                  let record  = nfcMessage.records.first,
                  record.typeNameFormat == .absoluteURI || record.typeNameFormat == .nfcWellKnown,
                  let payload = String(data: record.payload, encoding: .utf8)?.dropFirst(3),
                  self.nfcData.showingTag == true
          
           
            
            else {
                return
            }
            print(payload)
            self.data = String(payload)
            self.nfcData.nfcTag = String(payload)
            print(nfcData.showingTag)
            
        }
        
        
        
    }
    
 
    
}
