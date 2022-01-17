import Vapor
import Fluent

func routes(_ app: Application) throws {
    app.get { req -> String in
        return "Vapor Backend for GeekBrains GBShop project"
    }

    app.get("hello") { req -> String in
        return "Hello!"
    }
    
    let userController = UserController()
    let authController = AuthController()
    let productsController = ProductsController()
    let reviewsController = ReviewsController()
    let shoppingController = ShoppingController()
    
    app.post("register", use: userController.register)
    app.post("changeUserData", use: userController.changeUserData)
    app.post("login", use: authController.login)
    app.post("logout", use: authController.logout)

    app.post("getProductsList", use: productsController.getProductsList)
    app.post("getProductById", use: productsController.getProductById)
    app.get("getCategories", use: productsController.getCategories)
    app.get("getBrands", use: productsController.getBrands)
    app.post("getBrandCategories", use: productsController.getBrandCategories)
    app.post("getBrandById", use: productsController.getBrandById)
    app.post("getProductPhotos", use: productsController.getProductPhotos)
    
    app.post("getReviews", use: reviewsController.getReviews)
    app.post("addReview", use: reviewsController.addReview)
    app.post("removeReview", use: reviewsController.removeReview)
    app.post("getReviewPhotos", use: reviewsController.getReviewPhotos)
    
    app.post("addToCart", use: shoppingController.addToCart)
    app.post("removeFromCart", use: shoppingController.removeFromCart)
    app.post("payCart", use: shoppingController.payCart)
    app.post("getUserData", use: userController.getUserInfo)
}
