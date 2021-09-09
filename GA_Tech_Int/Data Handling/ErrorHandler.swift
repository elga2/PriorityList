//
//  Error.swift
//  GA_Tech_Int
//
//  Created by George Aldridge on 09/09/2021.
//

import Foundation

enum ErrorHandler: Error, LocalizedError {
    case loadError
    case urlError
    
    var errorDescription: String? {
        switch self {
        
        case .loadError:
            return NSLocalizedString("ERROR: Data did not load properly. Please try again", comment: "")
        case .urlError:
            return NSLocalizedString("ERROR: Please check your URL is correct", comment: "")
        }
    }
}

struct ErrorType: Identifiable {
    let id = UUID()
    let error: ErrorHandler
}
