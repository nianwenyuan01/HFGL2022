//
//  Persistence.swift
//  HFGL2022
//
//  Created by nwy on 2022/12/3.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for i in 0..<10 {
            let a = RenYuan(context: viewContext)
            a.xingMing = "人员姓名\(i)"
            a.id = UUID()
            a.baoXianRiQi = Date.parse("2022-11-09")
            a.baoXianShiChang = 2
            let b = WuZi(context: viewContext)
            b.mingCheng = "物资\(i)"
            b.id = UUID()
            let c = WuZiLeiBie(context: viewContext)
            b.id = UUID()
            c.mingCheng = "类别\(i)"
            let d = XiangMu(context: viewContext)
            d.mingCheng = "项目部\(i)"
            d.id = UUID()
            let e = ZhiWu(context: viewContext)
            e.mingCheng = "职务\(i)"
            e.id = UUID()
            let f = Tel(context: viewContext)
            f.haoMa = "1332842285\(i)"
            f.id = UUID()
            let g = LiuShui(context: viewContext)
            g.id = UUID()
            g.beiZhu = "流水备注\(i)"
            
            
            
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentCloudKitContainer

    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "HFGL2022")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}




