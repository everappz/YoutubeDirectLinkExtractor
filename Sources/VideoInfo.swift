//
//  VideoInfo.swift
//  YoutubeDirectLinkExtractor
//
//  Created by Andrey Sevrikov on 05/03/2018.
//  Copyright © 2018 Andrey Sevrikov. All rights reserved.
//

import Foundation
import AVFoundation

public struct VideoInfo {
    
    public let rawInfo: [[String: String]]
    
    public var highestQualityPlayableLink: String? {
        let urls = rawInfo.flatMap { $0["url"] }
        return firstPLayable(from: urls)
    }
    
    public var lowestQualityPlayableLink: String? {
        let urls = rawInfo.reversed().flatMap { $0["url"] }
        return firstPLayable(from: urls)
    }
    
    private func firstPLayable(from urls: [String]) -> String? {
        for urlString in urls {
            guard let url = URL(string: urlString) else {
                continue
            }
            let asset = AVAsset(url: url)
            if asset.isPlayable {
                return urlString
            }
        }
        
        return nil
    }
}
