
@testable import Reciplease
import XCTest

final class CoreDataManagerTests: XCTestCase {

    // MARK: - Properties

    var coreDataStack: MockCoreDataStack!
    var coreDataManager: CoreDataManager!
    var serviceIngredientsFridge : ServiceIngredientsFridge!

    // MARK: - Tests Life Cycle

    override func setUp() {
        super.setUp()
        coreDataStack = MockCoreDataStack()
        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
        serviceIngredientsFridge = ServiceIngredientsFridge()
    }

    override func tearDown() {
        super.tearDown()
        coreDataManager = nil
        coreDataStack = nil
        serviceIngredientsFridge = nil
    }

    // MARK: - Tests

    func testAddFavoriteMethods_WhenAnEntityIsCreated_ThenShouldBeCorrectlySaved() {
        coreDataManager.createFavorite(label: "test", calories: "10", image: UIImage(named: "default")!, ingredients: ["ingredientsTest"], totalTime: "totalTime", yield: "yield", url: "url")
        XCTAssertTrue(!coreDataManager.favorite.isEmpty)
        XCTAssertTrue(coreDataManager.favorite.count == 1)
        XCTAssertTrue(coreDataManager.favorite.first?.label == "test")
    }

    func testDeleteFavoriteMethod_WhenAnEntityIsCreated_ThenShouldBeCorrectlyDeleted() {
        
        coreDataManager.createFavorite(label: "test", calories: "10", image: UIImage(named: "default")!, ingredients: ["ingredientsTest"], totalTime: "totalTime", yield: "yield", url: "url")
        
        coreDataManager.ifRecipeRegisteredThenDeleteFavorite(name: "test")
        
        XCTAssertTrue(coreDataManager.favorite.isEmpty)
    }
    
    func testRegisteredMethod_WhenAnEntityIsRegistered_ThenShouldBeReturnFalse() {
        coreDataManager.createFavorite(label: "test", calories: "10", image: UIImage(named: "default")!, ingredients: ["ingredientsTest"], totalTime: "totalTime", yield: "yield", url: "url")
        
        
        XCTAssertTrue(coreDataManager.isRecipeRegistered(name: "test"))
    }
    
    func testAddFridgeIngredientsMethod_WhenAnIngredientsIsAppend_ThenShouldArrayIsNotEmpty() {
        
    
        serviceIngredientsFridge.addIngredients(ingredients: "ingredient")
        
        XCTAssertFalse(serviceIngredientsFridge.ingredientsFridge.isEmpty)
        
    }
}
