////
////  Utils.swift
////  CareersApp
////
////  Created by Ivan Dyptan on 11.10.25.
////  Copyright © 2025 Apple. All rights reserved.
////
//
//import Foundation
//
//enum MigrationError: Error {
//    case inputNotFound
//    case loadFailed(Error)
//    case decodeFailed(Error)
//    case encodeFailed(Error)
//    case writeFailed(Error)
//}
//
//public struct MigrationUtils {
//
//    // Loads [Career] from the bundle file "careersData.json",
//    // migrates to [CareerV2], and writes "careerV2.json" to Documents directory.
//    static func migrateCareersToV2(
//        inputFilename: String = "careersData.json",
//        outputFilename: String = "careerV2.json",
//        prettyPrinted: Bool = true
//    ) throws -> URL {
//
//        // 1) Locate input JSON in bundle
//        guard let inputURL = Bundle.main.url(forResource: inputFilename, withExtension: nil) else {
//            throw MigrationError.inputNotFound
//        }
//
//        // 2) Read input data
//        let inputData: Data
//        do {
//            inputData = try Data(contentsOf: inputURL)
//        } catch {
//            throw MigrationError.loadFailed(error)
//        }
//
//        // 3) Decode as [Career]
//        let careers: [CareerV1]
//        do {
//            let decoder = JSONDecoder()
//            careers = try decoder.decode([CareerV1].self, from: inputData)
//        } catch {
//            throw MigrationError.decodeFailed(error)
//        }
//
//        // 4) Map to [CareerV2]
////        let careersV2 = careers.map { ModelV2(from: $0) }
//
//        // 5) Encode pretty JSON
//        let encoder = JSONEncoder()
//        
//        
//        if prettyPrinted {
//            encoder.outputFormatting = [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes]
//        }
//        let outputData: Data
////        do {
////            outputData = try encoder.encode(careersV2)
////        } catch {
////            throw MigrationError.encodeFailed(error)
////        }
//
//        // 6) Write to Documents/careerV2.json
//        let documentsURL = try FileManager.default.url(
//            for: .documentDirectory,
//            in: .userDomainMask,
//            appropriateFor: nil,
//            create: true
//        )
//        let outputURL = documentsURL.appendingPathComponent(outputFilename)
//
//        print("Writing: \(outputURL)")
////        do {
////            try outputData.write(to: outputURL, options: [.atomic])
////        } catch {
////            throw MigrationError.writeFailed(error)
////        }
//
////        return outputURL
//    }
//}
