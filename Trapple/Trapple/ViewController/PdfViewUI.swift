//
//  PdfViewUI.swift
//  Trapple
//
//  Created by Antonnio Benedict Bryan Wijanto on 01/09/22.
//

import Foundation
import SwiftUI
import PDFKit

struct PdfViewUI : UIViewRepresentable {

    private var data: Data?
    
    private let autoScales : Bool
    
    init(data : Data?, autoScales : Bool = true ) {
        self.data = data
        self.autoScales = autoScales
    }

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()

        pdfView.autoScales =  self.autoScales
        
        if let data = self.data {
            
            pdfView.document = PDFDocument(data: data)
     
        }
        
        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) {
        // Empty
    }

}

