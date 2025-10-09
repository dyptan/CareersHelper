import XCTest

final class CareersTestsUI: XCTestCase {

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
    }

    func testNavigatesToCareerDetail() {
        let app = XCUIApplication()
        app.launch()

//        // 1) Select persona: Tools
//        let personaRow = app.otherElements["PersonaRow_Tools"]
//        XCTAssertTrue(personaRow.waitForExistence(timeout: 5), "PersonaRow_Tools not found")
//        personaRow.tapIfHittableOrScroll(in: app, timeout: 5)
//
//        // 2) Select category: Technology
//        let categoryRow = app.otherElements["CategoryRow_Technology"]
//        XCTAssertTrue(categoryRow.waitForExistence(timeout: 5), "CategoryRow_Technology not found")
//        categoryRow.tapIfHittableOrScroll(in: app, timeout: 5)
//
//        // 3) Tap career: Software Engineer
//        // Career rows are inside the list with identifier "CareersList"
//        let careersList = app.tables["CareersList"]
//        XCTAssertTrue(careersList.waitForExistence(timeout: 5), "CareersList not found")
//
//        let careerRow = app.otherElements["CareerRow_Software Engineer"]
//        // Give it a chance to appear after category selection
//        XCTAssertTrue(careerRow.waitForExistence(timeout: 5), "CareerRow_Software Engineer not found")
//        careerRow.tapIfHittableOrScroll(in: app, timeout: 5)

        // 4) Assert the detail is visible:
        // Prefer the stable identifier set on the destination root.
        let detailRoot = app.otherElements["CareerDetailRoot"]
        XCTAssertTrue(detailRoot.waitForExistence(timeout: 5), "CareerDetail did not appear")

        // Optional: also assert the known section title exists.
        let detailSectionTitle = app.staticTexts["What is this job?"]
        XCTAssertTrue(detailSectionTitle.waitForExistence(timeout: 5), "Detail section title not found")

        // Optional: a navigation bar should be present (title equals career.id).
        XCTAssertTrue(app.navigationBars.firstMatch.exists, "Navigation bar not present on detail screen")
    }
}

//private extension XCUIElement {
//    func tapIfHittable(timeout: TimeInterval) {
//        let exists = waitForExistence(timeout: timeout)
//        if exists && isHittable {
//            tap()
//        }
//    }
//
//    func tapIfHittableOrScroll(in app: XCUIApplication, timeout: TimeInterval) {
//        if waitForExistence(timeout: timeout), isHittable {
//            tap()
//            return
//        }
//        // Try to scroll within any table or scroll view to bring into view.
//        let scrollContainers = app.scrollViews.allElementsBoundByIndex + app.tables.allElementsBoundByIndex
//        for container in scrollContainers {
//            if container.exists {
//                // Try a couple of swipes to reveal the element
//                for _ in 0..<3 {
//                    if self.exists && self.isHittable { break }
//                    container.swipeUp()
//                }
//                if self.exists && self.isHittable {
//                    self.tap()
//                    return
//                }
//                for _ in 0..<2 {
//                    if self.exists && self.isHittable { break }
//                    container.swipeDown()
//                }
//                if self.exists && self.isHittable {
//                    self.tap()
//                    return
//                }
//            }
//        }
//        // Fall back to a direct tapIfHittable attempt
//        tapIfHittable(timeout: timeout)
//    }
//}
