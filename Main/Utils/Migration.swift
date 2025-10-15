import Foundation

enum MigrationError: Error {
    case inputNotFound
    case loadFailed(Error)
    case decodeFailed(Error)
    case encodeFailed(Error)
    case writeFailed(Error)
}

public struct MigrationUtils {

    // Loads [Career] from the bundle file "careersData.json",
    // migrates to [CareerV2], and writes "careerV2.json" to Documents directory.
    static func migrateCareersToV2(
        inputFilename: String = "careersData.json",
        outputFilename: String = "careerV2.json",
        prettyPrinted: Bool = true
    ) throws -> URL {

        // 1) Locate input JSON in bundle
        guard let inputURL = Bundle.main.url(forResource: inputFilename, withExtension: nil) else {
            throw MigrationError.inputNotFound
        }

        // 2) Read input data
        let inputData: Data
        do {
            inputData = try Data(contentsOf: inputURL)
        } catch {
            throw MigrationError.loadFailed(error)
        }

        // 3) Decode as [Career]
        let decoder = JSONDecoder()
        do {
            _ = try decoder.decode([CareerV1].self, from: inputData)
        } catch {
            throw MigrationError.decodeFailed(error)
        }

        // 4) Map to [CareerV2]
        // let careersV2 = careers.map { ModelV2(from: $0) }

        // 5) Encode pretty JSON
        let encoder = JSONEncoder()
        if prettyPrinted {
            encoder.outputFormatting = [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes]
        }

        // let outputData: Data
        // do {
        //     outputData = try encoder.encode(careersV2)
        // } catch {
        //     throw MigrationError.encodeFailed(error)
        // }

        // 6) Write to Documents/careerV2.json
        let documentsURL = try FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
        )
        let outputURL = documentsURL.appendingPathComponent(outputFilename)

        print("Writing: \(outputURL)")
        // do {
        //     try outputData.write(to: outputURL, options: [.atomic])
        // } catch {
        //     throw MigrationError.writeFailed(error)
        // }

        return outputURL
    }

    // NEW: Migrate data.json -> dataV3.json
    // - Removes "interest" key from each entry
    // - Maps requirements.education (0...5) to EU EQF levels using:
    //   0 -> 1, 1 -> 3, 2 -> 4, 3 -> 5, 4 -> 6, 5 -> 7
    // - Writes the result to Documents/dataV3.json
    // - Returns the destination URL
    public static func migrateCareersToV3(
        inputFilename: String = "data.json",
        outputFilename: String = "dataV3.json",
        prettyPrinted: Bool = true
    ) throws -> URL {

        // 1) Locate input JSON in bundle
        guard let inputURL = Bundle.main.url(forResource: inputFilename, withExtension: nil) else {
            throw MigrationError.inputNotFound
        }

        // 2) Read input data
        let inputData: Data
        do {
            inputData = try Data(contentsOf: inputURL)
        } catch {
            throw MigrationError.loadFailed(error)
        }

        // 3) Decode as a flexible JSON payload ([String: Any]-like) using JSONSerialization
        //    so we can drop "interest" without needing to change app models.
        let rawArray: [[String: Any]]
        do {
            let obj = try JSONSerialization.jsonObject(with: inputData, options: [])
            guard let arr = obj as? [[String: Any]] else {
                throw MigrationError.decodeFailed(NSError(domain: "MigrationV3", code: 0, userInfo: [NSLocalizedDescriptionKey: "Root is not an array of objects"]))
            }
            rawArray = arr
        } catch {
            throw MigrationError.decodeFailed(error)
        }

        // 4) Transform each entry
        let transformed: [[String: Any]] = rawArray.map { item in
            var dict = item

            // Remove top-level "interest"
            dict.removeValue(forKey: "interest")

            // Map requirements.education -> EQF
            if var requirements = dict["requirements"] as? [String: Any] {
                if let education = requirements["education"] as? Int {
                    let eqf = mapEducationToEQF(education)
                    requirements["education"] = eqf
                }
                dict["requirements"] = requirements
            }

            return dict
        }

        // 5) Encode to JSON
        let outputData: Data
        do {
            let options: JSONSerialization.WritingOptions = prettyPrinted ? [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes] : []
            outputData = try JSONSerialization.data(withJSONObject: transformed, options: options)
        } catch {
            throw MigrationError.encodeFailed(error)
        }

        // 6) Write to Documents/dataV3.json
        let documentsURL = try FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
        )
        let outputURL = documentsURL.appendingPathComponent(outputFilename)

        do {
            try outputData.write(to: outputURL, options: [.atomic])
        } catch {
            throw MigrationError.writeFailed(error)
        }

        print("dataV3.json written to: \(outputURL.path)")
        return outputURL
    }

    // MARK: - Helpers

    // Map your current education scale (0...5) to EU EQF levels
    // 0 -> 1, 1 -> 3, 2 -> 4, 3 -> 5, 4 -> 6, 5 -> 7
    private static func mapEducationToEQF(_ value: Int) -> Int {
        switch value {
        case ..<0: return 1
        case 0: return 1
        case 1: return 3
        case 2: return 4
        case 3: return 5
        case 4: return 6
        case 5: return 7
        default: return 7
        }
    }
}

// Placeholder types from earlier scaffold (kept to avoid compile errors if referenced).
// If not used, you can remove them or replace with your actual V1/V2 models.
struct CareerV1: Decodable {}
