//
//  Tests.swift
//  Tests
//
//  Created by Ivan Dyptan on 11.10.25.
//  Copyright © 2025 Apple. All rights reserved.
//

import Testing
@testable import CareersApp
struct Tests {

    @Test func example() async throws {
        var t = try MigrationUtils.migrateCareersToV2()
    }

}
