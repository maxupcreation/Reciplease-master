
@testable import Reciplease
import XCTest

final class CoreDataManagerTests: XCTestCase {

    // MARK: - Properties

    var coreDataStack: MockCoreDataStack!
    var coreDataManager: CoreDataManager!

    // MARK: - Tests Life Cycle

    override func setUp() {
        super.setUp()
        coreDataStack = MockCoreDataStack()
        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
    }

    override func tearDown() {
        super.tearDown()
        coreDataManager = nil
        coreDataStack = nil
    }

    // MARK: - Tests

    func testAddTeskMethods_WhenAnEntityIsCreated_ThenShouldBeCorrectlySaved() {
        coreDataManager.createFavorite(label: "test", calories: "10", image: UIImage(named: "default")!, ingredients: ["ingredientsTest"], totalTime: "totalTime", yield: "yield", url: "url")
        XCTAssertTrue(!coreDataManager.favorite.isEmpty)
        XCTAssertTrue(coreDataManager.favorite.count == 1)
        XCTAssertTrue(coreDataManager.favorite.first?.label == "test")
    }

    func testDeleteAllTasksMethod_WhenAnEntityIsCreated_ThenShouldBeCorrectlyDeleted() {
        
        coreDataManager.createFavorite(label: "test", calories: "10", image: UIImage(named: "default")!, ingredients: ["ingredientsTest"], totalTime: "totalTime", yield: "yield", url: "url")
        
        coreDataManager.ifRecipeRegisteredThenDeleteFavorite(name: "test")
        
        XCTAssertTrue(coreDataManager.favorite.isEmpty)
    }
    
    func testRegisteredMethod_WhenAnEntityIsRegistered_ThenShouldBeReturnFalse() {
        coreDataManager.createFavorite(label: "test", calories: "10", image: UIImage(named: "default")!, ingredients: ["ingredientsTest"], totalTime: "totalTime", yield: "yield", url: "url")
        
        
        XCTAssertTrue(coreDataManager.isRecipeRegistered(name: "test"))
    }
    
    
    
    
}
