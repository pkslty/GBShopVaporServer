//
//  ReviewsController.swift
//  
//
//  Created by Denis Kuzmin on 15.12.2021.
//

import Vapor
import Fluent
import Foundation

class ReviewsController {
    func getReviews(_ req: Request) throws -> EventLoopFuture<GetReviewsResponse> {
        guard let body = try? req.content.decode(GetReviewsRequest.self) else {
            throw Abort(.badRequest)
        }
        print(body)
        
        let reviews = Review.query(on: req.db).all()
        let result: EventLoopFuture<GetReviewsResponse> = reviews.map { (reviews: [Review]) -> GetReviewsResponse in
            let filtered = reviews.filter { $0.productId == body.productId }
            
            let response = GetReviewsResponse(result: 1,
                                              reviews: filtered,
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
            let review = Review(id: UUID(),
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
    
    func getReviewPhotos(_ req: Request) throws -> EventLoopFuture<PhotosResponse> {
        guard let body = try? req.content.decode(GetReviewPhotosRequest.self) else {
            throw Abort(.badRequest)
        }
        print(body)
        
        return ReviewPhoto.query(on: req.db)
            .filter(\.$reviewId == body.id)
            .all()
            .map { (photos: [ReviewPhoto]) -> PhotosResponse in
                guard photos.count > 0 else {
                    return PhotosResponse(result: 0,
                                          photos: nil,
                                          errorMessage: "No photos")
                }
                let photosResponse = photos.map {PhotoResponse(urlString: $0.urlString)}
                return PhotosResponse(result: 1,
                                      photos: photosResponse,
                                      errorMessage: nil)
            }
    }
}
