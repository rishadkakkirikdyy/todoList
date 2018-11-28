//
//  todoListTests.swift
//  todoListTests
//
//  Created by rishad k on 27/11/18.
//  Copyright © 2018 rishad k. All rights reserved.
//
import Foundation
import XCTest
@testable import todoList

class todoListTests: XCTestCase {
    
    override func setUp() {
        super.setUp()}
    
    override func tearDown() {
        super.tearDown()}
    func testExample() {}
    func testPerformanceExample() {
        self.measure {}}
    
    
    func testValidateTaskName()
    {
        let task=Tasks(name: "drive", checked: true, id: 1)
        XCTAssertFalse(task.name.count==0)
        
    }
    
    func testCheckTaskNameEmpty()
    {
        let task=Tasks(name: "test", checked: true, id: 1)
        XCTAssertEqual(task.validTaskName(), true)
        
    }
}
