//
//  CaffeinePalWidgetsBundle.swift
//  CaffeinePalWidgets
//
//  Created by Jordan Morgan on 6/25/24.
//

import WidgetKit
import SwiftUI

@main
struct CaffeinePalWidgetsBundle: WidgetBundle {
    var body: some Widget {
        EspressoWidget()
        CaffeinePalWidgetsControl()
    }
}
