import XCTest

final class LandmarksUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testNavigateToCareerDetail() throws {
        let app = XCUIApplication()
        app.launch()

        // 1) Select the first persona
        let primaryTables = app.tables
        XCTAssertTrue(primaryTables.count > 0, "Expected at least one list for personas")
        let personaTable = primaryTables.element(boundBy: 0)
        XCTAssertTrue(personaTable.exists, "Persona list should exist")
        let firstPersonaCell = personaTable.cells.element(boundBy: 0)
        XCTAssertTrue(firstPersonaCell.waitForExistence(timeout: 3), "First persona cell should exist")
        firstPersonaCell.tap()

        // 2) Select the first category
        let middleTables = app.tables
        XCTAssertTrue(middleTables.count >= 1, "Expected at least one list present")
        let categoryTable = middleTables.element(boundBy: middleTables.count - 1)
        XCTAssertTrue(categoryTable.waitForExistence(timeout: 3), "Category list should exist")
        let firstCategoryCell = categoryTable.cells.element(boundBy: 0)
        XCTAssertTrue(firstCategoryCell.waitForExistence(timeout: 3), "First category cell should exist")
        firstCategoryCell.tap()

        // 3) Tap the first career row in the detail list
        let detailTables = app.tables
        XCTAssertTrue(detailTables.count >= 1, "Expected a careers list")
        let careersTable = detailTables.element(boundBy: detailTables.count - 1)
        XCTAssertTrue(careersTable.waitForExistence(timeout: 3), "Careers list should exist")

        let firstCareerCell = careersTable.cells.element(boundBy: 0)
        if careersTable.cells.count > 1 {
            let rowToTap = careersTable.cells.element(boundBy: 1)
            XCTAssertTrue(rowToTap.waitForExistence(timeout: 3), "Career row should exist")
            rowToTap.tap()
        } else {
            XCTAssertTrue(firstCareerCell.waitForExistence(timeout: 3), "Career row should exist")
            firstCareerCell.tap()
        }

        // 4) Verify detail screen
        let anyStaticText = app.staticTexts.element(boundBy: 0)
        XCTAssertTrue(anyStaticText.waitForExistence(timeout: 3), "Some detail text should appear")

        let scrollViews = app.scrollViews
        XCTAssertTrue(scrollViews.count > 0, "Expected a scroll view in CareerDetail")
    }
}
