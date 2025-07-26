//
//  TransactionRowView.swift
//  KBMobileBankingInterviewTest
//
//  Created by Admin on 25/07/2025.
//

import SwiftUI

struct TransactionRowView: View {
    var transaction: TransactionModel

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Text(transaction.date.getDateString())
                    .font(.body)
                    .lineLimit(1)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal)
                    .accessibilityLabel(Text("Transaction date"))
                    .accessibilityValue(Text(transaction.date.getDateString()))
                    .accessibilityHint(Text("The date the transaction occurred"))
                    .accessibilityIdentifier(ScreenIdentifier.ViewID.rowDate.rawValue)

                Text(transaction.description)
                    .font(.title3)
                    .lineLimit(1)
                    .multilineTextAlignment(.leading)
                    .accessibilityLabel(Text("Transaction description"))
                    .accessibilityValue(Text(transaction.description))
                    .accessibilityHint(Text("Description of the transaction"))
                    .accessibilityIdentifier(ScreenIdentifier.ViewID.rowDescription.rawValue)

                Spacer()

                Text(transaction.amount, format: .currency(code: "NZD"))
                    .font(.title3)
                    .bold()
                    .lineLimit(1)
                    .foregroundStyle(transaction.amount > 0 ? .green : .red)
                    .accessibilityLabel(Text("Transaction amount"))
                    .accessibilityValue(Text(transaction.amount, format: .currency(code: "NZD")))
                    .accessibilityHint(Text("Amount of the transaction, in NZD"))
                    .accessibilityIdentifier(ScreenIdentifier.ViewID.rowAmount.rawValue)
            }
            Divider()
        }
        .padding(.top, 5)
        .padding(.bottom, 5)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(Text("Transaction row"))
        .accessibilityHint(Text("Contains details about the transaction, such as date, description, and amount"))
    }
}

#Preview {
    let items = ModelData().items
    return Group {
        TransactionRowView(transaction: items[0])
        TransactionRowView(transaction: items[1])
    }
}
