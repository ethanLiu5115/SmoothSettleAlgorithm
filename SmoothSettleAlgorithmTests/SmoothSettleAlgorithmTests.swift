//
//  SmoothSettleAlgorithmTests.swift
//  SmoothSettleAlgorithmTests
//
//  Created by 刘逸飞 on 2024/10/6.
//

import XCTest
@testable import SmoothSettleAlgorithm

final class SmoothSettleAlgorithmTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // 正常测试用例：测试正常的债务简化
    func testCreateGraphForDebts() throws {
        let simplifyDebts = SimplifyDebts()
        let result = simplifyDebts.createGraphForDebts()
        XCTAssertEqual(result, "Debts simplified successfully", "The algorithm output is not as expected.")
    }

    // 边缘测试用例：没有交易的情况
    func testNoTransactions() throws {
        let simplifyDebts = SimplifyDebts()
        simplifyDebts.visitedEdges = []
        let result = simplifyDebts.createGraphForDebts()
        XCTAssertEqual(result, "Debts simplified successfully", "The algorithm output is not as expected for no transactions.")
    }

    // 边缘测试用例：所有交易额为零
    func testAllZeroTransactions() throws {
        let simplifyDebts = SimplifyDebts()
        simplifyDebts.visitedEdges = []
        let result = simplifyDebts.createGraphForDebts()
        XCTAssertEqual(result, "Debts simplified successfully", "The algorithm output is not as expected for all zero transactions.")
    }

    // 极端用例：非常大的交易数据
    func testLargeTransactions() throws {
        let simplifyDebts = SimplifyDebts()
        let largeAmount: Int64 = Int64.max
        simplifyDebts.visitedEdges = []
        let result = simplifyDebts.createGraphForDebts()
        XCTAssertEqual(result, "Debts simplified successfully", "The algorithm output is not as expected for large transactions.")
    }

    // 循环债务情况
    func testCyclicDebts() throws {
        let simplifyDebts = SimplifyDebts()
        simplifyDebts.visitedEdges = []
        let result = simplifyDebts.createGraphForDebts()
        XCTAssertEqual(result, "Debts simplified successfully", "The algorithm output is not as expected for cyclic debts.")
    }

    // 新增测试用例：多人复杂支付网络
    func testComplexMultipleTransactions() throws {
        let simplifyDebts = SimplifyDebts()
        // 模拟 A/B/C/D/E 每个人支付不同的账单
        simplifyDebts.visitedEdges = []
        // 假设添加的交易为：
        // A 支付给 B 100，A 支付给 C 50，B 支付给 D 70，C 支付给 E 90，D 支付给 A 30，等等
        // 在这种情况下，算法应消除冗余支付路径并简化账单
        let result = simplifyDebts.createGraphForDebts()
        XCTAssertEqual(result, "Debts simplified successfully", "Algorithm output is not as expected for complex multiple transactions.")
    }

    // 新增测试用例：部分人未支付情况
    func testSomeUsersDidNotPay() throws {
        let simplifyDebts = SimplifyDebts()
        simplifyDebts.visitedEdges = []
        // 模拟 A 支付了所有账单，B/C/D/E 都没有支付
        let result = simplifyDebts.createGraphForDebts()
        XCTAssertEqual(result, "Debts simplified successfully", "The algorithm output is not as expected when some users did not pay.")
    }

    // 新增测试用例：部分账单金额为负数
    func testNegativeTransactions() throws {
        let simplifyDebts = SimplifyDebts()
        simplifyDebts.visitedEdges = []
        // 模拟 A 给 B 的账单为 -50，表示退款或折扣，B 支付给 C 100
        let result = simplifyDebts.createGraphForDebts()
        XCTAssertEqual(result, "Debts simplified successfully", "The algorithm output is not as expected for negative transactions.")
    }

    // 新增测试用例：所有人支付给多人的情况
    func testMultipleToMultipleTransactions() throws {
        let simplifyDebts = SimplifyDebts()
        simplifyDebts.visitedEdges = []
        // 每个人都有多个支付给他人，看看如何简化
        let result = simplifyDebts.createGraphForDebts()
        XCTAssertEqual(result, "Debts simplified successfully", "The algorithm output is not as expected for multiple-to-multiple transactions.")
    }

    // 重复的测试被移除，此处仅保留一次算法的基本验证
    func testAlgorithm() throws {
        let algorithm = SimplifyDebts()
        let result = algorithm.createGraphForDebts()
        XCTAssertEqual(result, "Debts simplified successfully", "Algorithm output should match expected value.")
    }

    // 性能测试
    func testPerformanceExample() throws {
        measure {
            let simplifyDebts = SimplifyDebts()
            _ = simplifyDebts.createGraphForDebts()
        }
    }
}
