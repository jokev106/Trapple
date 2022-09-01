//
//  PdfPreviewView.swift
//  Trapple
//
//  Created by Antonnio Benedict Bryan Wijanto on 01/09/22.
//

import Foundation
import SwiftUI

struct PdfPreviewView  : View {
    
    @EnvironmentObject private var contentViewModel : ContentViewModel
    
    @State private var showShareSheet : Bool = false
    
    var body: some View {
        
        VStack {
       
            PdfViewUI(data: contentViewModel.pdfData())
            
            shareButton()
            
            Spacer()
        }
        .navigationTitle(Text("Your PDF"))
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showShareSheet, content: {
        
            if let data = contentViewModel.pdfData() {
                ShareView(activityItems: [data])
            }
        })
        
    }
    
}


extension PdfPreviewView {

    private func shareButton() -> some View {
        
        Button(action: {
            self.showShareSheet.toggle()
        }, label: {
            Text("Share")
            .padding(10)
            .frame(width: 100)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(20)
            
        })
    }
}
