//
//  NSEntityDescription+PrimaryKey.swift
//  Sync
//
//  Created by  imac on 3/12/2021.
//

import Foundation

extension NSEntityDescription {
	
	func sync_primaryKeyAttribute() -> NSAttributeDescription {
		var primaryKeyAttribute:NSAttributeDescription!
		
		for (key, attributeDescription) in self.propertiesByName {
			
			if attributeDescription.isCustomPrimaryKey {
				primaryKeyAttribute = attributeDescription as? NSAttributeDescription
				break
			}
			
			if (key == SyncDefaultLocalPrimaryKey) || (key == SyncDefaultLocalCompatiblePrimaryKey) {
				primaryKeyAttribute = attributeDescription as? NSAttributeDescription
			}
		}
		
		return primaryKeyAttribute
	}
	
	func sync_localPrimaryKey() -> String {
		
		if let key = Sync.getShouldUseLocalPrimaryKeyBy(entityName: self.name ?? "") {
			return key
		}
		
		let primaryAttribute:NSAttributeDescription! = self.sync_primaryKeyAttribute()
		let localKey:String! = primaryAttribute.name
		
		return localKey
	}
	
	func sync_remotePrimaryKey() -> String {
				
		if let key = Sync.getShouldUseLocalPrimaryKeyBy(entityName: self.name ?? "") {
			return key
		}
		
		let primaryKeyAttribute:NSAttributeDescription! = self.sync_primaryKeyAttribute()
		var remoteKey:String! = primaryKeyAttribute.customKey
			
		if (remoteKey == nil) {
			if (primaryKeyAttribute.name == SyncDefaultLocalPrimaryKey) || (primaryKeyAttribute.name == SyncDefaultLocalCompatiblePrimaryKey) {
				remoteKey = SyncDefaultRemotePrimaryKey
			} else {
				remoteKey = primaryKeyAttribute.name.hyp_snakeCase()
			}
			
		}
		
		return remoteKey
	}
	
}
