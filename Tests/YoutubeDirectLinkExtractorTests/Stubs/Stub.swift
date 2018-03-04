//
//  StubAllQualities.swift
//  YoutubeDirectLinkExtractor
//
//  Created by Andrey Sevrikov on 04/03/2018.
//  Copyright © 2018 Andrey Sevrikov. All rights reserved.
//

import Foundation

extension String {
    
    init?(contentsOfBundleFile file: String, type: String?) {
        guard let bundle = Bundle.allBundles.first(where: { $0.bundleIdentifier?.contains("Tests") ?? false }),
        let path = bundle.path(forResource: file, ofType: type),
        let contents = try? String(contentsOfFile: path, encoding: .utf8) else {
            return nil
        }
        
        self = contents.replacingOccurrences(of: "\n", with: "")
    }
}
