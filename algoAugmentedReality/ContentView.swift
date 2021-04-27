//
//  ContentView.swift
//  algoAugmentedReality
//
//  Created by Mario Fernandes on 25/03/2021.
//

import SwiftUI
import RealityKit

struct ContentView: View {
    
    
    
    var body: some View {
        
        
//
        NavigationView {
            
            VStack(alignment: .center) {//vs1
              
                Image("augmenteAlgo")
                    
                    
                    .edgesIgnoringSafeArea(.top)
                    
                    .frame(minWidth: 0, maxWidth: UIScreen.main.bounds.width)
            
                
                VStack(alignment: .center){
                    
                   
                    
                    NavigationLink(destination: arView()) {
                        
                        Image("go")
                      
                        
                    }
                    
                    }
                    
              
                
                VStack(alignment: .leading) {//vs1
                    
                    Text("3DLIFESTUDIO")
                        .font(.custom("Avenir-Bold", size: 10))
                        
                        .foregroundColor(Color.gray)
                        .multilineTextAlignment(.leading)
                        .padding([.leading, .bottom], 10.0)
                    
                }
                
                
                .frame(minWidth: 0, maxWidth: UIScreen.main.bounds.width)
                .edgesIgnoringSafeArea(.all)
                .background(Color.white)
            }
            .background(Color.white)
            
            .edgesIgnoringSafeArea(.all)
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
   
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
