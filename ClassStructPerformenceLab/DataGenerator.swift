//
//  DataGenerator.swift
//  ArrayVSDisctionaryPerformenceLab
//
//  Created by Mohammad Alabed on 01/06/2022.
//

import Foundation

class DataGenerator {

    private let rowsNumber: Int = 2000000
    static var shared = DataGenerator()

    private var classesArray:[SampleClass] = []
    private var structsArray:[SampleStruct] = []

    private var dataGenerated = false

    private func createDataIfNoDataGeneratedYest() {
        if dataGenerated == false {
            generateClasses()
            generateStructs()
            dataGenerated = true
        }
    }

    /// Generate records in classes array
    func generateClasses(){

        var array: [Int] = []
        for i in 0...1000000 {
            array.append(i)
        }
        for _ in 0...rowsNumber {
            classesArray.append(SampleClass(val1: "test1", val2: "test2", val3: "test3", val4: "test4", val5: "test5", array: array))
        }
    }

    /// Generate records in strcuts array
    func generateStructs(){

        var array: [Int] = []
        for i in 0...1000000 {
            array.append(i)
        }
        for _ in 0...rowsNumber {
            structsArray.append(SampleStruct(val1: "test1", val2: "test2", val3: "test3", val4: "test4", val5: "test5", array: array))
        }
    }

    enum ObjectType {
        case `class`
        case `struct`
    }

    enum OperationType {
        case create
        case access
        case accessAll
        case append
        case update
        case simpleUpdate
    }

    func check(type: ObjectType, opType: OperationType) -> String {
        
        if opType != .create {
            createDataIfNoDataGeneratedYest()
        }
        var result: Double = 0.0
        switch opType {
        case .create:
            result = checkCreatingTime(type: type)
        case .access:
            result = checkAccessTime(type: type)
        case .accessAll:
            result = checkAccessAllElementsTime(type: type)
        case .append:
            result = checkAppendTime(type: type)
        case .update:
            result = checkUpdateTime(type: type)
        case .simpleUpdate:
            result = checkUpdateSimplyTime(type: type)
        }
        return String(format: "%f", result) + " Seconds"
    }

    private func checkCreatingTime(type: ObjectType) -> Double {

        switch type {
        case .class:
            let timer = ParkBenchTimer()
            generateClasses()
            return timer.stop()
        case .struct:
            let timer = ParkBenchTimer()
            generateStructs()
            return timer.stop()
        }
    }

    private func checkAccessTime(type: ObjectType) -> Double {

        let randomIndex = Int(arc4random())%rowsNumber
        let timer = ParkBenchTimer()
        switch type {
        case .class:
            let _ = classesArray[randomIndex].array.last
            return timer.stop()
        case .struct:
            let _ = structsArray[randomIndex].array.last
            return timer.stop()
        }
    }

    private func checkAccessAllElementsTime(type: ObjectType) -> Double {

        let randomIndex = Int(arc4random())%rowsNumber
        let timer = ParkBenchTimer()
        switch type {
        case .class:
            classesArray.first?.array.forEach { item in
                let item = item
            }
            return timer.stop()
        case .struct:
            structsArray.first?.array.forEach { item in
                let item = item
            }
            return timer.stop()
        }
    }

    private func checkAppendTime(type: ObjectType) -> Double {

        let timer = ParkBenchTimer()
        var array: [Int] = []
        for i in 0...10 {
            array.append(i)
        }
        switch type {
        case .class:
            for (index,_) in classesArray.enumerated() {
                var currentArray = classesArray[index].array
                currentArray.append(contentsOf: array)
                classesArray[index].array = currentArray
                if index == 1000 {
                    break
                }
            }
            return timer.stop()
        case .struct:
            for (index,_) in structsArray.enumerated() {
                var currentArray = structsArray[index].array
                currentArray.append(contentsOf: array)
                structsArray[index].array = currentArray
                if index == 1000 {
                    break
                }
            }
            return timer.stop()
        }
    }

    private func checkUpdateTime(type: ObjectType) -> Double {

        let timer = ParkBenchTimer()
        var array: [Int] = []
        for i in 0...100000 {
            array.append(i)
        }
        switch type {
        case .class:
            for (index,_) in classesArray.enumerated() {
                classesArray[index].array = array
            }
            return timer.stop()
        case .struct:
            for (index,_) in structsArray.enumerated() {
                structsArray[index].array = array
            }
            return timer.stop()
        }
    }

    private func checkUpdateSimplyTime(type: ObjectType) -> Double {

        let timer = ParkBenchTimer()
        switch type {
        case .class:
            classesArray.removeLast()
            return timer.stop()
        case .struct:
            var arr = structsArray.last?.array
            arr?.removeLast()
            structsArray.removeLast()
            return timer.stop()
        }
    }

}
