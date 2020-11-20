//
//  MyInfoListViewModal.swift
//  MeInfoGram
//
//  Created by Moban Michael on 20/11/2020.
//

import Foundation
import RxCocoa
import RxSwift

class MyInfoListViewModal {
    
    var myInfoList          = PublishRelay<([MyInfo])>()
    private let disposeBag  = DisposeBag()
    
    
    func getSecureDataList() {
        let list1 = Item.init(type: .Info, category: .OnlineShopping, headerTitle: "Amazon")
        let list2 = Item.init(type: .Info, category: .OnlineShopping, headerTitle: "Sainsburys")
        let list = [list1, list2]
        let myInfoList1 = MyInfo.init(item: list, category: .OnlineShopping)
        
        let list3 = Item.init(type: .Info, category: .Bank, headerTitle: "Hdfc")
        let list4 = Item.init(type: .Info, category: .Bank, headerTitle: "Hsbc")
        let list5 = [list3, list4]
        let myInfoList2 = MyInfo.init(item: list5, category: .Bank)
        
        let myInfoList = [myInfoList1, myInfoList2]
        self.myInfoList.accept(myInfoList)
        
//        hospitalDataManager.getAllHospitalList().subscribe { (event) in
//
//            if let hospitals = event.element {
//
//                let sortedList = hospitals.0.sorted {
//                    $0.OrganisationName < $1.OrganisationName
//                }
//                self.hospitalList.accept((sortedList,hospitals.1))
//            }
//        }.disposed(by: self.disposeBag)
    }
}
