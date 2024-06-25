//
//  CaffeinePalWidgetsControl.swift
//  CaffeinePalWidgets
//
//  Created by Jordan Morgan on 6/25/24.
//

import AppIntents
import SwiftUI
import WidgetKit

struct CaffeinePalWidgetsControl: ControlWidget {
    static let kind: String = "com.superwall.caffeinePal.Caffeine-Pal.CaffeinePalWidgets"

    var body: some ControlWidgetConfiguration {
        StaticControlConfiguration(kind: Self.kind) {
            ControlWidgetButton(action: GetCaffeineIntent()) {
                Label("Caffeine Intake", systemImage: "cup.and.saucer.fill")
            }
        }
        .displayName("Get Caffeine Intake")
        .description("Shows how much caffeine you've had today.")
    }
}
