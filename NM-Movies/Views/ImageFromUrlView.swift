//
//  ImageFromUrlView.swift
//  NM-Movies
//
//  Created by Nikola on 24.3.21..
//

import SwiftUI

struct ImageFromUrlView: View {
    @ObservedObject var imgFetcher: MovieImageFetcher
    var predefinedHeight:CGFloat = .zero
    
    var imageHeight: CGFloat {
        get {
            if predefinedHeight > 0 {
                return predefinedHeight
            }
            return (UIFont.preferredFont(forTextStyle: .body).lineHeight * 3 + 22)
        }
    }
    var imageWidth: CGFloat {
        imageHeight * 3 / 4
    }
    
    init(url: String, height: CGFloat = .zero) {
        imgFetcher = MovieImageFetcher(imageUrl: "\(ApiEnd.imagesRootUrl)\(url)")
        predefinedHeight = height
    }
    
    var body: some View {
        Image(uiImage: imgFetcher.displayImage ?? // OR placeholder
                UIImage(systemName: "photo")!
        )
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: imageWidth, height: imageHeight, alignment: .center)
        .clipped()
    }
}
