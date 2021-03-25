//
//  ImageFetcherTests.swift
//  NM-MoviesUnitTests
//
//  Created by Nikola on 25.3.21..
//

import XCTest
@testable import NM_Movies

class ImageFetcherTests: XCTestCase {
    var sut: MovieImageFetcher?
    var sutCache: CachedImage?
    
    override func setUp() {
        super.setUp()
        sut = MovieImageFetcher(imageUrl: "")
        sutCache = CachedImage()
    }
    
    override func tearDown() {
        sut = nil
        sutCache = nil
        super.tearDown()
    }
    
    func test_imageFromCache() {
        let testUrlString = "testKey"
        let testImage =  UIImage(systemName: "photo")!
        sutCache!.set(key: testUrlString, image: testImage)
        let cachedImage = sutCache!.get(key: testUrlString)
        XCTAssertTrue(cachedImage == testImage, "Cached image incorrect")
        
        sut = MovieImageFetcher(imageUrl: testUrlString)
        XCTAssertNotNil(sut!.cachedImage, "Display image incorrect")
    }
}
