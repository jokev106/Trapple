//
//  PDFKit.swift
//  Trapple
//
//  Created by Antonnio Benedict Bryan Wijanto on 13/09/22.
//

import SwiftUI

struct PDFView: View {
    let filename = "TrapplePDF"
    
    var body: some View {
        ScrollView {
                Text("Click button to share")
            Button {
                sharePDF(content: {self}, fileName: filename)
                
            } label: {
                Text("Export")
            }
            .buttonStyle(.borderedProminent)

        }
    }
    
    
}

struct PDFView_Previews: PreviewProvider {
    static var previews: some View {
        PDFView()
    }
}
