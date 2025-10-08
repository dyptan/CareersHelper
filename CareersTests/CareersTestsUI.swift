import XCTest

final class CareersTestsUI: XCTestCase {

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
    }

    func testNavigatesToCareerDetail() {
        let app = XCUIApplication()
        app.launch()

        // NavigationSplitView shows progressively on compact devices.
        // We’ll tap first visible cells in order.

        // 1) Primary column: Personas list – tap the first cell if it exists.
        if let personasList = app.tables.firstMatchIfExists() {
            personasList.cells.firstMatch.tapIfHittable(timeout: 5)
        }

        // 2) Middle column: Categories list – tap the first cell if it exists.
        if let categoriesList = app.tables.element(boundBy: 1).ifExists() {
            categoriesList.cells.firstMatch.tapIfHittable(timeout: 5)
        } else if let categoriesList = app.tables.firstMatchIfExists() {
            // On compact, the middle column might have replaced the primary.
            categoriesList.cells.firstMatch.tapIfHittable(timeout: 5)
        }

        // 3) Right/detail column: Careers list – tap the first career row.
        // It may be the next table or the same on compact.
        let possibleTables = app.tables.allElementsBoundByIndex
        if possibleTables.count >= 1 {
            // Try the last table (most likely the detail list)
            let detailList = possibleTables.last!
            detailList.cells.firstMatch.tapIfHittable(timeout: 5)
        }

        // 4) Assert the detail is visible:
        // CareerDetail contains a static text "What is this job?"
        let detailSectionTitle = app.staticTexts["What is this job?"]
        XCTAssertTrue(detailSectionTitle.waitForExistence(timeout: 5), "CareerDetail did not appear")

        // Optionally also check that a navigation bar exists (title equals career.id).
        // Since we don't know the exact career title, we just assert a navigation bar exists.
        XCTAssertTrue(app.navigationBars.firstMatch.exists, "Navigation bar not present on detail screen")
    }
}

private extension XCUIElementQuery {
    func firstMatchIfExists() -> XCUIElement? {
        let el = firstMatch
        return el.exists ? el : nil
    }
}

private extension XCUIElement {
    func tapIfHittable(timeout: TimeInterval) {
        let exists = waitForExistence(timeout: timeout)
        if exists && isHittable {
            tap()
        }
    }
}

private extension XCUIElement {
    func ifExists() -> XCUIElement? {
        return exists ? self : nil
    }
}
