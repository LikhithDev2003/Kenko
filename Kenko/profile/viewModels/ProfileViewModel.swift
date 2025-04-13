//
//  ProfileViewModel.swift
//  Kenko
//
//  Created by apple on 12/04/25.
//


import Foundation
import CoreData

class ProfileViewModel: ObservableObject {
    @Published var user: UserEntity?

    init() {
        fetchUser()
    }

    func fetchUser() {
        let context = CoreDataManager.shared.context
        let request: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        request.fetchLimit = 1
        
        do {
            self.user = try context.fetch(request).first
        } catch {
            print("❌ Failed to fetch user: \(error)")
        }
    }
}
