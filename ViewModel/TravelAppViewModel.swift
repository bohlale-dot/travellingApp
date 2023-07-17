//
//  TravelAppViewModel.swift
//  TravelApp
//
//  Created by Bohlale Manage on 2023/07/09.
//

import Foundation

struct CountryData: Hashable {
    var name: String;
    var flag: String;
}

struct Location: Identifiable {
    var id = UUID()
    var name: String
    var startPrice: Int
    var image: String
}

struct Tab: Identifiable {
    var id = UUID()
    var label: String
    var value: Int
}


final class TravelAppViewModel: ObservableObject {
    @Published var countriesData: [CountryData] = []
    @Published var country: CountryData;
    @Published var isLocationViewVisible: Bool = false;
    @Published var locationData: [Location] = []
    @Published var tabs: [Tab] = []
    
    init() {
        country = CountryData(name: "", flag: "")
        countriesData = getCountries();
        locationData = [
            .init(name: "Bali, Inonesia", startPrice: 8000, image: "Bali"),
            .init(name: "Singapore", startPrice: 10000, image: "singapore"),
            .init(name: "Paris, France", startPrice: 15000, image: "paris"),
            .init(name: "Rome, Italy", startPrice: 8000, image: "rome"),
            .init(name: "Athens, Greece", startPrice: 11000, image: "greece"),
            .init(name: "Vienna", startPrice: 8000, image: "vienna"),
            .init(name: "Kruger National Park", startPrice: 6000, image: "south"),
            .init(name: "Maasai mara National Reserve", startPrice: 5000, image: "kenya"),
        ]
        tabs = [
            .init(label: "All", value: 0),
            .init(label: "North America", value: 1),
            .init(label: "Africa", value: 2),
            .init(label: "Europe", value: 3),
            .init(label: "Asia", value: 4),
            .init(label: "South America", value: 5),
        ]

    }
    
    func getCountries() -> [CountryData] {
        var data: [CountryData] = []
        for code in NSLocale.isoCountryCodes  {
            
            let flag = String.emojiFlag(for: code)
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])

            if let name = NSLocale(localeIdentifier: "en_UK").displayName(forKey: NSLocale.Key.identifier, value: id) {

                data.append(CountryData(name: name, flag: flag!))
                
                if code == Locale.current.language.region?.identifier {
                    country = CountryData(name: name, flag: flag!)
                }
                
            }else{
                 
            }
            
        }
        return data
    }
    
    func setCountry(data: CountryData) {
        country = data
    }
    
    func toggleLocationView() {
        isLocationViewVisible.toggle()
    }
    
    func setLocationView(state: Bool) {
        isLocationViewVisible = state
    }
}


extension String {

    static func emojiFlag(for countryCode: String) -> String! {
        func isLowercaseASCIIScalar(_ scalar: Unicode.Scalar) -> Bool {
            return scalar.value >= 0x61 && scalar.value <= 0x7A
        }

        func regionalIndicatorSymbol(for scalar: Unicode.Scalar) -> Unicode.Scalar {
            precondition(isLowercaseASCIIScalar(scalar))

            // 0x1F1E6 marks the start of the Regional Indicator Symbol range and corresponds to 'A'
            // 0x61 marks the start of the lowercase ASCII alphabet: 'a'
            return Unicode.Scalar(scalar.value + (0x1F1E6 - 0x61))!
        }

        let lowercasedCode = countryCode.lowercased()
        guard lowercasedCode.count == 2 else { return nil }
        guard lowercasedCode.unicodeScalars.reduce(true, { accum, scalar in accum && isLowercaseASCIIScalar(scalar) }) else { return nil }

        let indicatorSymbols = lowercasedCode.unicodeScalars.map({ regionalIndicatorSymbol(for: $0) })
        return String(indicatorSymbols.map({ Character($0) }))
    }
}

