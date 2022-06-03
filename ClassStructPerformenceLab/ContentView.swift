//
//  ContentView.swift
//  ClassStructPerformenceLab
//
//  Created by Mohammad Alabed on 03/06/2022.
//

import SwiftUI

class MainPresenter: ObservableObject {

    @Published var rows:[CellViewPresneter] = []
    func append(sectionTitle: String, arrayValue: String, dictValue: String) {
        rows.append(CellViewPresneter(title: sectionTitle, arrayValue: arrayValue, dictValue: dictValue))
    }
}

struct ContentView: View {

    @StateObject fileprivate var presenter = MainPresenter()

    var body: some View {
        VStack {
            Button("Creation Time") {
                presenter.rows = []
                let classT = DataGenerator.shared.check(type: .class, opType: .create)
                let structT = DataGenerator.shared.check(type: .struct, opType: .create)
                presenter.append(sectionTitle: "Creating Data", arrayValue: classT, dictValue: structT)
            }
            Button("Access Time") {
                presenter.rows = []
                let classT = DataGenerator.shared.check(type: .class, opType: .access)
                let structT = DataGenerator.shared.check(type: .struct, opType: .access)
                presenter.append(sectionTitle: "Access Item", arrayValue: classT, dictValue: structT)
            }
            Button("Access All Elements Time") {
                presenter.rows = []
                let classT = DataGenerator.shared.check(type: .class, opType: .accessAll)
                let structT = DataGenerator.shared.check(type: .struct, opType: .accessAll)
                presenter.append(sectionTitle: "Access All Elements Item", arrayValue: classT, dictValue: structT)
            }
            Button("Append Time") {
                presenter.rows = []
                let classT = DataGenerator.shared.check(type: .class, opType: .append)
                let structT = DataGenerator.shared.check(type: .struct, opType: .append)
                presenter.append(sectionTitle: "Append Item", arrayValue: classT, dictValue: structT)
            }
            Button("Update Item Time") {
                presenter.rows = []
                let classT = DataGenerator.shared.check(type: .class, opType: .update)
                let structT = DataGenerator.shared.check(type: .struct, opType: .update)
                presenter.append(sectionTitle: "Update Item Inside Class/Struct", arrayValue: classT, dictValue: structT)
            }
            Button("Simple Update Item") {
                presenter.rows = []
                let classT = DataGenerator.shared.check(type: .class, opType: .simpleUpdate)
                let structT = DataGenerator.shared.check(type: .struct, opType: .simpleUpdate)
                presenter.append(sectionTitle: "Simple Update Item Inside Class/Struct", arrayValue: classT, dictValue: structT)
            }

            List(presenter.rows) { item in
                CellView(presentation: item)
            }
            .listStyle(.plain)
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
