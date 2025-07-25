//
//  TransactionRowView.swift
//  KBMobileBankingInterviewTest
//
//  Created by Admin on 25/07/2025.
//

import SwiftUI

struct TransactionRowView: View {
    var transaction: Transaction

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Text(transaction.date.getDateString())
                    .font(.body)
                    .lineLimit(1)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal)
                Text(transaction.description)
                    .font(.title3)
                    .lineLimit(1)
                    .multilineTextAlignment(.leading)
                Spacer()
                Text(transaction.amount, format: .currency(code: "NZD"))
                    .font(.title3)
                    .bold()
                    .lineLimit(1)
                    .foregroundStyle(transaction.amount > 0 ? .green : .red)
            }
            Divider()
        }
        .padding(.top, 5)
        .padding(.bottom, 5)
    }
}

#Preview {
    let items = ModelData().items
    return Group {
        TransactionRowView(transaction: items[0])
        TransactionRowView(transaction: items[1])
    }
}
