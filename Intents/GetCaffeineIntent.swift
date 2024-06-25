//
//  GetCaffeineIntent.swift
//  Caffeine Pal
//
//  Created by Jordan Morgan on 6/24/24.
//

import Foundation
import AppIntents

struct GetCaffeineIntent: AppIntent {
    static var title = LocalizedStringResource("Get Caffeine Intake")
    static var description = IntentDescription("Shows how much caffeine you've had today.")
    
    func perform() async throws -> some IntentResult & ReturnsValue<Double> & ProvidesDialog {
        let store = CaffeineStore()
        let amount = store.amountIngested
        return .result(value: amount,
                       dialog: .init("You've had \(store.formattedAmount(for: .dailyIntake))."))
    }
}
