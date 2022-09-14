//
//  PDFKit.swift
//  Trapple
//
//  Created by Antonnio Benedict Bryan Wijanto on 13/09/22.
//

import CloudKit
import SwiftUI

struct PDFView: View {
    let filename = "TrapplePDF"

    @ObservedObject var vm: ActivitiesViewModel
    @Binding var planID: CKRecord.ID
    @Binding var startDate: Date
    @Binding var endDate: Date
    
    static let stackDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(vm.dates.indices, id: \.self) { index in
                    VStack {
                        VStack(spacing: 0) {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("Day \(index + 1)")
                                        .font(Font.custom("Gilroy-ExtraBold", size: 20))
                                        .foregroundColor(deepblue)
                                    
                                    Spacer()
                                    
                                    Text("\(vm.dates[index])")
                                        .font(Font.custom("Gilroy-ExtraBold", size: 15))
                                        .foregroundColor(deepblue)
                                }
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(lightpurple)
                            .cornerRadius(15)
                            
                            ForEach(vm.activity, id: \.recordID) { item in
                                if dateFormatter(date: item.actualDate) == vm.dates[index] {
                                    HStack(spacing: 0) {
                                        VStack {
                                            Text("\(item.startDate, formatter: Self.stackDateFormat) - \(item.endDate, formatter: Self.stackDateFormat)")
                                                .font(Font.custom("Gilroy-ExtraBold", size: 13))
                                                .padding(.top, 2)
                                                .foregroundColor(blacktext)
                                        }
                                        .frame(maxWidth: 100, maxHeight: .infinity, alignment: .top)
                                        .padding()
                                            
                                        Rectangle()
                                            .frame(width: 3)
                                            .foregroundColor(deepblue)
                                            
                                        VStack(alignment: .leading) {
                                            Text("\(item.title)")
                                                .foregroundColor(blacktext)
                                                .font(Font.custom("Gilroy-ExtraBold", size: 13))
                                        }
                                        .frame(maxWidth: .infinity, alignment: .topLeading)
                                        .padding()
                                    }
                                    .font(Font.custom("Gilroy-Light", size: 11))
                                    .frame(maxWidth: .infinity)
                                    .background(tripcardColor)
                                    .cornerRadius(15)
                                    .shadow(color: Color.gray.opacity(0.105), radius: 2, x: 0, y: 3)
                                }
                            }
                        }
                    }
                    .foregroundColor(.black)
                    .background(.white)
                    .cornerRadius(15)
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .shadow(color: Color.gray.opacity(0.105), radius: 2, x: 0, y: 3)
                }
            }
        }
        .navigationTitle("Preview PDF")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Text("Export")
                    .onTapGesture {
//                            self.showPDF.toggle()
                        sharePDF(content: { self }, fileName: filename)
                    }
            }
        }
    }
    
    func dateFormatter(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d"
        
        return dateFormatter.string(from: date)
    }
}

// struct PDFView_Previews: PreviewProvider {
//    static var previews: some View {
//        PDFView(showPDF: .constant())
//    }
// }
