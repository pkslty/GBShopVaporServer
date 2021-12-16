//
//  ShoppingController.swift
//  
//
//  Created by Denis Kuzmin on 16.12.2021.
//

import Vapor

class ShoppingController {
    func addToCart(_ req: Request) throws -> EventLoopFuture<CommonResponse> {
        guard let body = try? req.content.decode(AddToCartRequest.self) else {
            throw Abort(.badRequest)
        }
        print(body)
        
        let cartItems = Cart.query(on: req.db).all()
        let result: EventLoopFuture<CommonResponse> = cartItems.map { (items: [Cart]) -> CommonResponse in
            let filtered = items.filter { $0.userId == body.userId && $0.productId == body.productId }
            guard filtered.count < 2 else {
                return CommonResponse(result: 0,
                                      userMessage: nil,
                                      errorMessage: "Error adding to Cart")
            }
            if filtered.count == 1 {
                filtered[0].quantity += body.quantity
                let _ = filtered[0].update(on: req.db)
            } else {
                let item = Cart(id: items.count + 1,
                                productId: body.productId,
                                userId: body.userId,
                                quantity: body.quantity)
                let _ = item.create(on: req.db)
            }
            let response = CommonResponse(result: 1,
                                              userMessage: "Succesfully add to cart",
                                              errorMessage: nil)
            print(response)
            return response
        }
        return result
    }
    
    func addReview(_ req: Request) throws -> EventLoopFuture<CommonResponse> {
        guard let body = try? req.content.decode(AddReviewRequest.self) else {
            throw Abort(.badRequest)
        }
        print(body)
        
        let allReviews = Review.query(on: req.db).all()
        let result: EventLoopFuture<CommonResponse> = allReviews.map { (reviews: [Review]) -> CommonResponse in
            let filtered = reviews.filter { $0.userId == body.userId }
            
            guard filtered.count == 0 else {
                return CommonResponse(result: 0,
                                      userMessage: nil,
                                      errorMessage: "User already post a review")
            }
            let review = Review(id: reviews.count + 1,
                                productId: body.productId,
                                userId: body.userId,
                                text: body.text,
                                rating: body.rating,
                                likes: 0)
            let _ = review.create(on: req.db)
            let response = CommonResponse(result: 1,
                                         userMessage: "Review is on moderation",
                                         errorMessage: nil)
            
            print(response)
            return response
        }
        
        
        return result
    }
    
    func removeReview(_ req: Request) throws -> EventLoopFuture<CommonResponse> {
        guard let body = try? req.content.decode(RemoveReviewRequest.self) else {
            throw Abort(.badRequest)
        }
        print(body)
        
        let allReviews = Review.query(on: req.db).all()
        let result: EventLoopFuture<CommonResponse> = allReviews.map { (reviews: [Review]) -> CommonResponse in
            let filtered = reviews.filter { $0.id == body.reviewId }
            
            guard filtered.count != 0 else {
                return CommonResponse(result: 0,
                                      userMessage: nil,
                                      errorMessage: "Wrong reviewId")
            }
            
            let _ = filtered[0].delete(on: req.db)
            let response = CommonResponse(result: 1,
                                         userMessage: "Review succesfully removed",
                                         errorMessage: nil)
            
            print(response)
            return response
        }
        
        
        return result
    }
}
