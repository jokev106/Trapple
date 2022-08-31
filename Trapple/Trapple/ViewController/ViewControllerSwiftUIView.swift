//
//  ViewControllerSwiftUIView.swift
//  Trapple
//
//  Created by Antonnio Benedict Bryan Wijanto on 31/08/22.
//

import Foundation
import SwiftUI


struct ViewControllerSwiftUIView: UIViewControllerRepresentable {

   
    func makeUIViewController(context: UIViewControllerRepresentableContext<ViewControllerSwiftUIView>) -> ViewController {
        return ViewController()
    }

    func updateUIViewController(_ uiViewController: ViewController,
                                context: UIViewControllerRepresentableContext<ViewControllerSwiftUIView>) {

    }
}
