//
//  CaffeineStore.swift
//  Caffeine Pal
//
//  Created by Jordan Morgan on 1/23/24.
//

import Foundation
import Observation
import AppIntents

enum EspressoShot: Int, CaseIterable, CustomStringConvertible {
    case single = 64, double = 128, triple = 192
    
    var description: String {
        switch self {
        case .single:
            "Single"
        case .double:
            "Double"
        case .triple:
            "Triple"
        }
    }
}

extension EspressoShot: AppEnum {
    static var typeDisplayRepresentation: TypeDisplayRepresentation = .init(name: "Shots")
    static var typeDisplayName: LocalizedStringResource = "Shots"
    static var caseDisplayRepresentations: [EspressoShot: DisplayRepresentation] = [
        .single: "Single",
        .double: "Double",
        .triple: "Triple"
    ]
}

@Observable
class CaffeineStore {
    static let shared = CaffeineStore()
    
    private init() {} 
    
    enum FormattedAmount {
        case dailyIntake, amountOver
    }
    
    let formatter: MeasurementFormatter = {
        let f = MeasurementFormatter()
        f.unitOptions = .providedUnit
        f.numberFormatter.maximumFractionDigits = 2
        return f
    }()
    
    var dailyLimit: Double = 300.0
    
    private(set) var todaysCaffeine: Double = 0.0 {
        didSet {
            let proposedValue = (todaysCaffeine/dailyLimit) * 1.0
            
            if proposedValue > 1.0 {
                amountIngested = 1.0
            } else {
                amountIngested = (todaysCaffeine/dailyLimit) * 1.0
            }
            
            if todaysCaffeine > dailyLimit {
                amountOver = (todaysCaffeine - dailyLimit)
            } else {
                amountOver = 0.0
            }
        }
    }
    
    private(set) var amountIngested: Double = 0.0
    private(set) var amountOver: Double = 0.0
    
    // MARK: Functions
    
    func log(_ amount: Double) {
        todaysCaffeine += amount
    }
    
    func log(espressoShot: EspressoShot) {
        todaysCaffeine += Double(espressoShot.rawValue)
    }
    
    func formattedAmount(for value: FormattedAmount = .dailyIntake) -> String {
        switch value {
        case .dailyIntake:
            return formattedAmount(.init(value: self.todaysCaffeine, unit: .milligrams))
        case .amountOver:
            return formattedAmount(.init(value: self.amountOver, unit: .milligrams))
        }
    }
    
    func formattedAmount(_ amount: Measurement<UnitMass>) -> String {
        return formatter.string(from: amount)
    }
}
