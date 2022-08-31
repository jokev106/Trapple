//
//  ContentViewModel.swift
//  Trapple
//
//  Created by Antonnio Benedict Bryan Wijanto on 31/08/22.
//

import Foundation
import PDFKit

class ContentViewModel : ObservableObject {
    
    @Published private var content  = Content()

    var title : String {
        
        get { content.title }
        
        set (newTitle) {
            
            content.title = newTitle
        }
    }

    var body : String {
        
        get { content.body }
        
        set(newBody) {
            
            content.body = newBody
        }
    }
}


extension ContentViewModel {
    
    func clear(){
        
        self.title = ""
        self.body = ""
    }
}

extension ContentViewModel {
    
    
    func pdfData() -> Data? {
        
        return PdfCreator().pdfData(title: self.title, body: self.body)
    }
    
    func pdfDoc() -> PDFDocument? {
        
        let pdfCreator = PdfCreator()
        return pdfCreator.pdfDoc(title: self.title, body: self.body)
    }
    
}
