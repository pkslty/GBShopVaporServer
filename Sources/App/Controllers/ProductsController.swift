//
//  File.swift
//  
//
//  Created by Denis Kuzmin on 12.12.2021.
//

import Vapor
import Fluent

class ProductsController {
    func getProductById(_ req: Request) throws -> EventLoopFuture<ProductByIdResponse> {
        guard let body = try? req.content.decode(RecordByIdRequest.self) else {
            throw Abort(.badRequest)
        }
        print(body)
        
        let goods = Product.query(on: req.db).all()
        let result: EventLoopFuture<ProductByIdResponse> = goods.map { (goods: [Product]) -> ProductByIdResponse in
            let filtered = goods.filter { $0.id == body.id }

            guard filtered.count == 1 else {
                return ProductByIdResponse(result: 0, productName: nil, price: nil, description: nil, errorMessage: "No such product")
            }
            let response = ProductByIdResponse(result: 1,
                                            productName: filtered[0].productName,
                                            price: filtered[0].price,
                                            description: filtered[0].productDescription,
                                            errorMessage: nil)
            
            print(response)
            return response
        }
        
        
        return result
    }
    
    func getBrandById(_ req: Request) throws -> EventLoopFuture<BrandByIdResponse> {
        guard let body = try? req.content.decode(RecordByIdRequest.self) else {
            throw Abort(.badRequest)
        }
        print(body)
        
        return Brand.query(on: req.db)
            .filter(\.$id == body.id)
            .all()
            .map { (brands: [Brand]) -> BrandByIdResponse in
                guard brands.count == 1 else {
                    return BrandByIdResponse(result: 0,
                                             brand: nil,
                                             errorMessage: "No such Brand")
                }
                return BrandByIdResponse(result: 1,
                                         brand: brands[0],
                                         errorMessage: nil)
            }
    }
    
    func getProductsList(_ req: Request) throws -> EventLoopFuture<ProductsListResponse> {
        guard let body = try? req.content.decode(ProductsListRequest.self) else {
            throw Abort(.badRequest)
        }
        print(body)
        
        let goods = Product.query(on: req.db).all()
        let result: EventLoopFuture<ProductsListResponse> = goods.map { (goods: [Product]) -> ProductsListResponse in
            let filtered = goods.filter { $0.categoryId == body.categoryId }
                //.map { ProductsListItem(productId: $0.id!, productName: $0.productName, price: $0.price) }
            guard filtered.count > 0 else {
                return ProductsListResponse(result: 0, pageNumber: nil, products: nil, errorMessage: "No goods with such category Id")
            }
            let response = ProductsListResponse(result: 1,
                                         pageNumber: 1,
                                         products: filtered,
                                         errorMessage: nil)
            
            print(response)
            return response
        }
        
        
        return result
    }
    
    func getCategories(_ req: Request) throws -> EventLoopFuture<GetListResponse<Category>> {

        return Category.query(on: req.db)
            .all()
            .map { (list: [Category]) -> GetListResponse in
            guard list.count > 0 else {
                return GetListResponse(result: 0,
                                       items: nil,
                                       errorMessage: "No items")
            }
            return GetListResponse(result: 1,
                                   items: list,
                                   errorMessage: nil)
        }
    }
    
    func getBrandCategories(_ req: Request) throws -> EventLoopFuture<GetListResponse<Category>> {
        guard let body = try? req.content.decode(GetBrandCategories.self) else {
            throw Abort(.badRequest)
        }
        print(body)
        
        return Product.query(on: req.db)
            .join(Category.self, on: \Product.$categoryId == \Category.$id)
            .filter(\.$brandId == body.id)
            .all()
            .map { (products: [Product]) -> GetListResponse in
            guard products.count > 0 else {
                return GetListResponse(result: 0,
                                       items: nil,
                                       errorMessage: "No items")
            }
            let categories = products.compactMap { (product) -> Category? in
                return try? product.joined(Category.self)
            }
            guard categories.count > 0 else {
                return GetListResponse(result: 0,
                                       items: nil,
                                       errorMessage: "No items")
            }
            
                
            return GetListResponse(result: 1,
                                   items: categories.unsortedUniqueElements(),
                                   errorMessage: nil)
        }
    }
    
    func getBrands(_ req: Request) throws -> EventLoopFuture<GetListResponse<Brand>> {

        return Brand.query(on: req.db)
            .all()
            .map { (list: [Brand]) -> GetListResponse in
            guard list.count > 0 else {
                return GetListResponse(result: 0,
                                       items: nil,
                                       errorMessage: "No items")
            }
            return GetListResponse(result: 1,
                                   items: list,
                                   errorMessage: nil)
        }
    }
    
    func getList<List: Model>(_ req: Request) throws -> EventLoopFuture<GetListResponse<List>> {

        return List.query(on: req.db)
            .all()
            .map { (list: [List]) -> GetListResponse in
            guard list.count > 0 else {
                return GetListResponse(result: 0,
                                       items: nil,
                                       errorMessage: "No items")
            }
            return GetListResponse(result: 1,
                                   items: list,
                                   errorMessage: nil)
        }
    }
    
    func getProductPhotos(_ req: Request) throws -> EventLoopFuture<PhotosResponse> {
        guard let body = try? req.content.decode(RecordByIdRequest.self) else {
            throw Abort(.badRequest)
        }
        print(body)
        
        return ProductPhoto.query(on: req.db)
            .filter(\.$productId == body.id)
            .all()
            .map { (photos: [ProductPhoto]) -> PhotosResponse in
                guard photos.count > 0 else {
                    return PhotosResponse(result: 0,
                                                 photos: nil,
                                                 errorMessage: "No photos")
                }
                let photosResponse = photos.map { PhotoResponse(urlString: $0.urlString)}
                return PhotosResponse(result: 1,
                                             photos: photosResponse,
                                             errorMessage: nil)
            }
    }
}
