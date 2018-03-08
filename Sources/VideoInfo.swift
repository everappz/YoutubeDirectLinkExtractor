//
//  VideoInfo.swift
//  YoutubeDirectLinkExtractor
//
//  Created by Andrey Sevrikov on 05/03/2018.
//  Copyright © 2018 Andrey Sevrikov. All rights reserved.
//

import Foundation

public struct VideoInfo {
    public let rawInfo: [[String: String]]
    public let highestQualityLink: String
    public let lowestQualityLink: String
}
