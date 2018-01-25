//
//  Download.swift
//  khabar
//
//  Created by Singh, Abhay on 1/11/18.
//  Copyright © 2018 SHC. All rights reserved.
//

import Foundation

class Download {
    
    var paperPageLinkUrl: String
    init(paperPageLinkUrl: String) {
        self.paperPageLinkUrl = paperPageLinkUrl
    }
    
    // Download service sets these values:
    var task: URLSessionDownloadTask?
    var isDownloading = false
    var resumeData: Data?
    
    // Download delegate sets this value:
    var progress: Float = 0
    
}
