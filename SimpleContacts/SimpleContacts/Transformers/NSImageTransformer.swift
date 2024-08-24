//
//  NSImageTransformer.swift
//  SimpleContacts
//
//  Created by Róbert Šumšala Jr. on 30/07/2024.
//

import Foundation
import AppKit

class NSImageTransformer: ValueTransformer {
    override func transformedValue(_ value: Any?) -> Any? {
        guard let image = value as? NSImage else {return nil}
        
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: image, requiringSecureCoding: true)
            return data
        } catch {
            return nil
        }
    }
    
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else {return nil}
        
        do {
            let image = try NSKeyedUnarchiver.unarchivedObject(ofClass: NSImage.self, from: data)
            return image
        } catch {
            return nil
        }
    }
}
