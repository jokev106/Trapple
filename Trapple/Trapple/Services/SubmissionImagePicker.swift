//
//  SubmissionImagePicker.swift
//  Trapple
//
//  Created by Jonathan Kevin on 29/08/22.
//

import SwiftUI
import UIKit

struct SubmissionPicker: UIViewControllerRepresentable {
    
    @Binding var selectedImage: UIImage
    @Environment(\.presentationMode) var presentationMode
    
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<SubmissionPicker>) -> UIImagePickerController {
        let submissionPicker = UIImagePickerController()
        submissionPicker.allowsEditing = false
        submissionPicker.sourceType = sourceType
        submissionPicker.delegate = context.coordinator
        
        return submissionPicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        var parent: SubmissionPicker
        
        init(_ parent: SubmissionPicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let submission = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = submission
            }
            
            parent.presentationMode.wrappedValue.dismiss()
            
        }
        
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
}
