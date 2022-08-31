//
//  WebView.swift
//  Trapple
//
//  Created by Antonnio Benedict Bryan Wijanto on 31/08/22.
//

import Foundation
import SwiftUI
import WebKit

struct WebView : UIViewRepresentable {
    
    let urlString : String
    
    func makeUIView(context: Context) -> WKWebView  {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
        if let url = URL(string: urlString) {
        
            uiView.load( URLRequest(url: url ) )
        }
    }
    
}

struct WebView_Previews : PreviewProvider {
    static var previews: some View {
        WebView(urlString: "https://techchee.com" )
    }
}
