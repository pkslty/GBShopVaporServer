//
//  File.swift
//  
//
//  Created by Denis Kuzmin on 12.12.2021.
//

import Vapor
import Foundation

class GoodsController {
    func getGoodById(_ req: Request) throws -> EventLoopFuture<GoodByIdResponse> {
        guard let body = try? req.content.decode(GoodByIdRequest.self) else {
            throw Abort(.badRequest)
        }
        print(body)
        
        let goods = Product.query(on: req.db).all()
        let result: EventLoopFuture<GoodByIdResponse> = goods.map { (goods: [Product]) -> GoodByIdResponse in
            let filtered = goods.filter { $0.id == body.productId }

            guard filtered.count == 1 else {
                return GoodByIdResponse(result: 0, productName: nil, price: nil, description: nil, errorMessage: "No such product")
            }
            let response = GoodByIdResponse(result: 1,
                                            productName: filtered[0].productName,
                                            price: filtered[0].price,
                                            description: filtered[0].productDescription,
                                            errorMessage: nil)
            
            print(response)
            return response
        }
        
        
        return result
    }
    
    func getGoodsList(_ req: Request) throws -> EventLoopFuture<GoodsListResponse> {
        guard let body = try? req.content.decode(GoodsListRequest.self) else {
            throw Abort(.badRequest)
        }
        print(body)
        
        let goods = Product.query(on: req.db).all()
        let result: EventLoopFuture<GoodsListResponse> = goods.map { (goods: [Product]) -> GoodsListResponse in
            let filtered = goods.filter { $0.categoryId == body.categoryId }
                .map { GoodsListItem(productId: $0.id!, productName: $0.productName, price: $0.price) }
            guard filtered.count > 0 else {
                return GoodsListResponse(result: 0, pageNumber: nil, products: nil, errorMessage: "No goods with such category Id")
            }
            let response = GoodsListResponse(result: 1,
                                         pageNumber: 1,
                                         products: filtered,
                                         errorMessage: nil)
            
            print(response)
            return response
        }
        
        
        return result
    }
    
}
