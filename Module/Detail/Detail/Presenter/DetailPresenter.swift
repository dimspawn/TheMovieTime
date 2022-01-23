//
//  DetailPresenter.swift
//  Detail
//
//  Created by Dimas Wicaksono on 06/01/22.
//

import Core
import Combine
import SwiftUI
import MovieDomain

public class DetailPresenter<
    GetDetailUseCase: UseCase,
    IsFavoriteUseCase: UseCase,
    AddFavoriteUseCase: UseCase,
    DeleteFavorietUseCase: UseCase>: ObservableObject
where
    GetDetailUseCase.Request == Int,
    GetDetailUseCase.Response == DetailModel,
    IsFavoriteUseCase.Request == Int,
    IsFavoriteUseCase.Response == Bool,
    AddFavoriteUseCase.Request == DetailModel,
    AddFavoriteUseCase.Response == Bool,
    DeleteFavorietUseCase.Request == DetailModel,
    DeleteFavorietUseCase.Response == Bool{
    private var cancellables: Set<AnyCancellable> = []
    private let _movieId: Int
    private let _getDetailUseCase: GetDetailUseCase
    private let _isFavoriteUseCase: IsFavoriteUseCase
    private let _addFavoriteUseCase: AddFavoriteUseCase
    private let _deleteFavoriteUseCase: DeleteFavorietUseCase
    
    @Published public var detail: DetailModel?
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    @Published public var isFavorite: Bool = false
    
    public init(
        id: Int,
        getDetailUseCase: GetDetailUseCase,
        isFavoriteUseCase: IsFavoriteUseCase,
        addFavoriteUseCase: AddFavoriteUseCase,
        deleteFavoriteUseCase: DeleteFavorietUseCase
    ) {
        _movieId = id
        _getDetailUseCase = getDetailUseCase
        _isFavoriteUseCase = isFavoriteUseCase
        _addFavoriteUseCase = addFavoriteUseCase
        _deleteFavoriteUseCase = deleteFavoriteUseCase
    }
    
    public func getDetail() {
        isLoading = true
        _getDetailUseCase.execute(request: _movieId)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.isError = true
                    self.isLoading = false
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { detail in
                self.detail = detail
            })
            .store(in: &cancellables)
    }
        
    public func checkIsFavorite() {
        _isFavoriteUseCase.execute(request: _movieId)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { isFav in
                self.isFavorite = isFav
            })
            .store(in: &cancellables)
    }
        
    public func favoriteToggle(){
        guard let detail = detail else { fatalError() }
        if self.isFavorite {
            _deleteFavoriteUseCase.execute(request: detail)
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .failure:
                        self.errorMessage = String(describing: completion)
                    case .finished:
                        self.isLoading = false
                    }
                }, receiveValue: { defavorited in
                    if defavorited { self.isFavorite = false }
                }).store(in: &cancellables)
        } else {
            _addFavoriteUseCase.execute(request: detail)
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .failure:
                        self.errorMessage = String(describing: completion)
                    case .finished:
                        self.isLoading = false
                    }
                }, receiveValue: { favorited in
                    if favorited { self.isFavorite = true }
                }).store(in: &cancellables)
        }
    }
}
