//
//  RHW+CoreDataProperties.swift
//  HFGL2022
//
//  Created by nwy on 2022/12/3.
//
//

import Foundation
import CoreData


extension RHW {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RHW> {
        return NSFetchRequest<RHW>(entityName: "RHW")
    }


}

extension RHW : Identifiable {

}
