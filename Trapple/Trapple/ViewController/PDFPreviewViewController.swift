//
//  PDFPreviewViewController.swift
//  Trapple
//
//  Created by Antonnio Benedict Bryan Wijanto on 31/08/22.
//

import Foundation
//import UIKit
//import PDFKit
//
//class PDFPreviewViewController: UIViewController {
//  public var documentData: Data?
//  @IBOutlet weak var pdfView: PDFView!
//
//  override func viewDidLoad() {
//    super.viewDidLoad()
//
//    if let data = documentData {
//      pdfView.document = PDFDocument(data: data)
//      pdfView.autoScales = true
//    }
//  }
//}

import UIKit
import PDFKit

class PDFPreviewViewController: UIViewController {

    //1
    @IBOutlet weak private var pdfView : PDFView!

    override func viewDidLoad() {

        super.viewDidLoad()

        //2
        let pdfData = PDFCreator().prepareData()

        //3
        pdfView.document = PDFDocument(data: pdfData)
        pdfView.autoScales = true
    }
}
