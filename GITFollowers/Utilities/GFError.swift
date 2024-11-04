//
//  ErrorMessage.swift
//  GITFollowers
//
//  Created by sujith on 27/09/24.
//

import Foundation

enum GFError: String, Error {
    case invalidUsername = "This username create invalid URL, please try again"
    case unableToComplete = "Unable to complete your request, please check network connection"
    case invalidResponse = "Invalid response from server, please try again"
    case invalidData = "Data received from server is invalid, please try again"
    case unableToFavourite = "Unable to favourite this user. Please try again"
    case alreadyFavourited = "This user is already in your favourites."
}
