//
//  YoutubeDirectLinkExtractor.swift
//  Andrey Sevrikov
//
//  Created by Andrey Sevrikov on 04/03/2018.
//  Copyright © 2018 Andrey Sevrikov. All rights reserved.
//

import Foundation

public class YoutubeDirectLinkExtractor {
    
    private let infoBasePrefix = "https://www.youtube.com/get_video_info?video_id="
    private let userAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/604.5.6 (KHTML, like Gecko) Version/11.0.3 Safari/604.5.6"
    
    // MARK: - Public
    
    public init() {
    }
    
    public func extractInfo(for source: ExtractionSource,
                            success: @escaping (VideoInfo) -> Void,
                            failure: @escaping (Swift.Error) -> Void) {
        
        extractRawInfo(for: source) { info, error in
            
            if let error = error {
                failure(error)
                return
            }
            
            guard let highestQualityLink = info.first?["url"],
            let lowestQualityLink = info.last?["url"] else {
                failure(Error.unkown)
                return
            }
            
            success(VideoInfo(rawInfo: info,
                              highestQualityLink: highestQualityLink,
                              lowestQualityLink: lowestQualityLink))
        }
    }
    
    // MARK: - Internal
    
    func extractRawInfo(for source: ExtractionSource,
                        completion: @escaping ([[String: String]], Swift.Error?) -> Void) {
        
        guard let id = source.videoId else {
            completion([], Error.cantExtractVideoId)
            return
        }
        
        guard let infoUrl = URL(string: "\(infoBasePrefix)\(id)") else {
            completion([], Error.cantConstructRequestUrl)
            return
        }
        
        let r = NSMutableURLRequest(url: infoUrl)
        r.httpMethod = "GET"
        r.setValue(userAgent, forHTTPHeaderField: "User-Agent")
        
        URLSession.shared.dataTask(with: r as URLRequest) { data, response, error in

            guard let data = data else {
                completion([], error ?? Error.noDataInResponse)
                return
            }
            
            guard let dataString = String(data: data, encoding: .utf8) else {
                completion([], Error.cantConvertDataToString)
                return
            }
            
            let extractionResult = self.extractInfo(from: dataString)
            completion(extractionResult.0, extractionResult.1)
            
        }.resume()
    }
    
    func extractInfo(from string: String) -> ([[String: String]], Swift.Error?) {
        let pairs = string.queryComponents()
        
        guard let fmtStreamMap = pairs["url_encoded_fmt_stream_map"] else {
            let error = YoutubeError(errorDescription: pairs["reason"])
            return ([], error ?? Error.cantExtractFmtStreamMap)
        }
        
        let fmtStreamMapComponents = fmtStreamMap.components(separatedBy: ",")
        
        let infoPerPreset = fmtStreamMapComponents.map { $0.queryComponents() }
        return (infoPerPreset, nil)
    }
}
