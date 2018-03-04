//
//  ExtractionSourceTests.swift
//  YoutubeDirectLinkExtractor
//
//  Created by Andrey Sevrikov on 04/03/2018.
//  Copyright © 2018 Andrey Sevrikov. All rights reserved.
//

import Foundation
import XCTest
@testable import YoutubeDirectLinkExtractor

class ExtractionSourceTests: XCTestCase {
    
    let videoId = "L_jWHffIx5E"
    
    // MARK: - Different sources handling
    
    func testCreatesCorrectUrl() {
        // given
        let urlString = "https://www.youtube.com/watch?v=L_jWHffIx5E"
        
        // when
        let id = ExtractionSource.urlString(urlString).videoId
        
        // then
        XCTAssertEqual(id, videoId)
    }
    
    func testUsesUrl() {
        // given
        let urlString = "https://www.youtube.com/watch?v=L_jWHffIx5E"
        let url = URL(string: urlString)!
        
        // when
        let id = ExtractionSource.url(url).videoId
        
        // then
        XCTAssertEqual(id, videoId)
    }
    
    func testOutputsSameId() {
        // given
        let inputId = videoId
        
        // when
        let id = ExtractionSource.id(inputId).videoId
        
        // then
        XCTAssertEqual(id, videoId)
    }
    
    // MARK: - Video id extraction logic
    
    func testVideoIdFromPlainUrl() {
        // given
        let urlString = "https://www.youtube.com/watch?v=L_jWHffIx5E"

        // when
        let id = ExtractionSource.urlString(urlString).videoId
        
        // then
        XCTAssertEqual(id, videoId)
    }
    
    func testVideoIdFromShortUrl() {
        // given
        let urlString = "https://youtu.be/L_jWHffIx5E"

        // when
        let id = ExtractionSource.urlString(urlString).videoId
        
        // then
        XCTAssertEqual(id, videoId)
    }
    
    func testVideoIdFromEmbedUrl() {
        // given
        let urlString = "https://www.youtube.com/embed/L_jWHffIx5E"
        
        // when
        let id = ExtractionSource.urlString(urlString).videoId
        
        // then
        XCTAssertEqual(id, videoId)
    }
    
    func testVideoIdFromMobileUrl() {
        // given
        let urlString = "https://m.youtube.com/#/watch?v=L_jWHffIx5E"
        
        // when
        let id = ExtractionSource.urlString(urlString).videoId
        
        // then
        XCTAssertEqual(id, videoId)
    }
    
    // MARK: - Host name variations
    
    func testVideoIdFromPlainUrlWithoutWWW() {
        // given
        let urlString = "https://youtube.com/watch?v=L_jWHffIx5E"
        
        // when
        let id = ExtractionSource.urlString(urlString).videoId
        
        // then
        XCTAssertEqual(id, videoId)
    }
    
    func testVideoIdFromEmbedUrlWithoutWWW() {
        // given
        let urlString = "https://youtube.com/embed/L_jWHffIx5E"
        
        // when
        let id = ExtractionSource.urlString(urlString).videoId
        
        // then
        XCTAssertEqual(id, videoId)
    }
}
