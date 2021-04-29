//
//  arView.swift
//  algoAugmentedReality
//
//  Created by Mario Fernandes on 26/03/2021.
//

import SwiftUI
import RealityKit
import swift_algorand_sdk


struct arView: View {
    
    var body: some View {
        return VStack {
            
            ARViewContainer().edgesIgnoringSafeArea(.all)
            
        }
        
    }
    
}


struct ARViewContainer: UIViewRepresentable {
    
    @State var ALGOD_API_ADDR="https://testnet-algorand.api.purestake.io/ps2"
    var ALGOD_API_TOKEN="G----------------------------------"
    @State var ALGOD_API_PORT=""
    
    @State private var transactionIsShowing = false
    
    func makeUIView(context: Context) -> ARView{
        
        let arView = ARView(frame:.zero)
        
        let algoAnchor = try! AlgoAugment.loadRussPizza()
        
        let sunInfoAction = algoAnchor.actions.allActions.filter({$0.identifier == "buy"}).first
        sunInfoAction?.onAction = { entity in
            
            self.goTransaction()
            if transactionIsShowing == true {
                
                algoAnchor.notifications.showTransaction.post()
            }
            
        }
        
        arView.scene.anchors.append(algoAnchor)
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        
    }
    

func goTransaction()  {
    
    let algodClient=AlgodClient(host: ALGOD_API_ADDR, port: ALGOD_API_PORT, token: ALGOD_API_TOKEN)
    algodClient.set(key: "X-API-KeY")
    
    do {
        
        let mnemonic = "digital music music music crew review music unit finger music music music special music special review cost special music music music review review music music"
        
        
        let account = try Account(mnemonic)
        //all fine with jsonData here
        
        let senderAddress = account.getAddress()
        let receiverAddress = try! Address("ICUJJVODN5F6CYMRZYF4UJJV----------------------Y")
    
        
        algodClient.transactionParams().execute(){ paramResponse in
            if(!(paramResponse.isSuccessful)){
                print(paramResponse.errorDescription!);
                print("transaction OK!")
                return;
            }
            
            let tx = try? Transaction.paymentTransactionBuilder().setSender(senderAddress)
                .amount(1000000)
                .receiver(receiverAddress)
                .note("Swift Algo sdk is cool".bytes)
                .suggestedParams(params: paramResponse.data!)
                .build()
        
            
            let signedTransaction=account.signTransaction(tx: tx!)
            
            let encodedTrans:[Int8]=CustomEncoder.encodeToMsgPack(signedTransaction)
            
            
            
            algodClient.rawTransaction().rawtxn(rawtaxn: encodedTrans).execute(){
                response in
                if(response.isSuccessful){
                    print(response.data!.txId)
                    print("Sucess")
//
                    transactionIsShowing = true
//
                }else{
                    print(response.errorDescription!)
                    print("Failed")
                }
                
            }
        }
        
    } catch {
        //handle error
        print(error)
    }
    print("algo buy!")
}
       
//

   }

struct arView_Previews: PreviewProvider {
    static var previews: some View {
        arView()
    }
}
