//
//  LoginViewModel.swift
//  UILayouts-TheMovieDB
//
//  Created by Mwai Banda on 8/25/22.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel {
    var email = PublishSubject<String>()
    var password  = PublishSubject<String>()
    
    lazy var isValidInput: Observable<Bool> = {
        return Observable
            .combineLatest(email.asObserver(), password.asObserver())
            .startWith(("",""))
            .map { email, password in
                return !email.isEmpty && !password.isEmpty
            }.startWith(false)
    }()
}
