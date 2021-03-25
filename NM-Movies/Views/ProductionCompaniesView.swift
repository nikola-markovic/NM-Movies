//
//  ProductionCompaniesView.swift
//  NM-Movies
//
//  Created by Nikola on 25.3.21..
//

import SwiftUI

struct ProductionCompaniesView: View {
    
    var production_companies: [ProductionCompany]?
    
    var body: some View {
        if production_companies?.count ?? 0 > 0 {
            VStack(alignment: .leading, spacing: 2) {
                ForEach(production_companies!, id: \.id) { company in
                    HStack {
                        ImageFromUrlView(url: company.logo_path ?? "", height: 40)
                        Text(company.name ?? "")
                            .lineLimit(2)
                    }
                }
            }
        }
    }
}
