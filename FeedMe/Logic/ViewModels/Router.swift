//
//  Router.swift
//  FeedMe
//
//  Created by Steven Elliott on 1/9/25.
//

import SwiftUI

enum TabIdentifier: Hashable {
    case list
    case spin
}

@Observable
class Router {
    var selectedTab: TabIdentifier = .list
    var listTabNavigationPath: NavigationPath = NavigationPath()
    var spinTabNavigationPath: NavigationPath = NavigationPath()
}
