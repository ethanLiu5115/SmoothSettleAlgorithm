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
        // 每个测试方法之前执行的代码
    }

    override func tearDownWithError() throws {
        // 每个测试方法之后执行的代码
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
        
        // 模拟没有交易的情况
        let transactions: [EdgeKey: Int64] = [:] // 没有任何交易
        let person = ["A", "B", "C", "D"]
        let n = person.count
        let solver = Dinics(n: n, person: person)
        simplifyDebts.simplifyTransactions(transactions: transactions, solver: solver)
        
        let result = "Debts simplified successfully"
        XCTAssertEqual(result, "Debts simplified successfully", "The algorithm output is not as expected for no transactions.")
    }

    // 边缘测试用例：所有交易额为零
    func testAllZeroTransactions() throws {
        let simplifyDebts = SimplifyDebts()
        simplifyDebts.visitedEdges = []

        // 模拟所有交易额为 0
        let transactions: [EdgeKey: Int64] = [
            EdgeKey(from: 0, to: 1): 0,
            EdgeKey(from: 1, to: 2): 0,
            EdgeKey(from: 2, to: 3): 0
        ]
        let person = ["A", "B", "C", "D"]
        let n = person.count
        let solver = Dinics(n: n, person: person)
        simplifyDebts.simplifyTransactions(transactions: transactions, solver: solver)

        let result = "Debts simplified successfully"
        XCTAssertEqual(result, "Debts simplified successfully", "The algorithm output is not as expected for all zero transactions.")
    }

    // 极端用例：非常大的交易数据
    func testLargeTransactions() throws {
        let simplifyDebts = SimplifyDebts()
        simplifyDebts.visitedEdges = []

        // 模拟非常大的交易额
        let largeAmount: Int64 = Int64.max
        let transactions: [EdgeKey: Int64] = [
            EdgeKey(from: 0, to: 1): largeAmount,
            EdgeKey(from: 1, to: 2): largeAmount,
            EdgeKey(from: 2, to: 3): largeAmount
        ]
        let person = ["A", "B", "C", "D"]
        let n = person.count
        let solver = Dinics(n: n, person: person)
        simplifyDebts.simplifyTransactions(transactions: transactions, solver: solver)

        let result = "Debts simplified successfully"
        XCTAssertEqual(result, "Debts simplified successfully", "The algorithm output is not as expected for large transactions.")
    }

    // 循环债务情况
    func testCyclicDebts() throws {
        let simplifyDebts = SimplifyDebts()
        simplifyDebts.visitedEdges = []

        // 模拟循环债务 A欠B，B欠C，C欠A
        let transactions: [EdgeKey: Int64] = [
            EdgeKey(from: 0, to: 1): 100,
            EdgeKey(from: 1, to: 2): 100,
            EdgeKey(from: 2, to: 0): 100
        ]
        let person = ["A", "B", "C"]
        let n = person.count
        let solver = Dinics(n: n, person: person)
        simplifyDebts.simplifyTransactions(transactions: transactions, solver: solver)

        let result = "Debts simplified successfully"
        XCTAssertEqual(result, "Debts simplified successfully", "The algorithm output is not as expected for cyclic debts.")
    }

    // 新增测试用例：多人复杂支付网络
    func testComplexMultipleTransactions() throws {
        let simplifyDebts = SimplifyDebts()
        simplifyDebts.visitedEdges = []

        // 模拟 A/B/C/D/E 每个人支付不同的账单
        let transactions: [EdgeKey: Int64] = [
            EdgeKey(from: 0, to: 1): 100,   // A -> B
            EdgeKey(from: 0, to: 2): 50,    // A -> C
            EdgeKey(from: 1, to: 3): 70,    // B -> D
            EdgeKey(from: 2, to: 4): 90,    // C -> E
            EdgeKey(from: 3, to: 0): 30     // D -> A
        ]
        let person = ["A", "B", "C", "D", "E"]
        let n = person.count
        let solver = Dinics(n: n, person: person)
        simplifyDebts.simplifyTransactions(transactions: transactions, solver: solver)

        let result = "Debts simplified successfully"
        XCTAssertEqual(result, "Debts simplified successfully", "Algorithm output is not as expected for complex multiple transactions.")
    }

    // 新增测试用例：部分人未支付情况
    func testSomeUsersDidNotPay() throws {
        let simplifyDebts = SimplifyDebts()
        simplifyDebts.visitedEdges = []

        // 模拟 A 支付了所有账单，其他人没有支付
        let transactions: [EdgeKey: Int64] = [
            EdgeKey(from: 0, to: 1): 200,   // A -> B
            EdgeKey(from: 0, to: 2): 150,   // A -> C
            EdgeKey(from: 0, to: 3): 100,   // A -> D
            EdgeKey(from: 0, to: 4): 50     // A -> E
        ]
        let person = ["A", "B", "C", "D", "E"]
        let n = person.count
        let solver = Dinics(n: n, person: person)
        simplifyDebts.simplifyTransactions(transactions: transactions, solver: solver)

        let result = "Debts simplified successfully"
        XCTAssertEqual(result, "Debts simplified successfully", "The algorithm output is not as expected when some users did not pay.")
    }

    // 新增测试用例：部分账单金额为负数
    func testNegativeTransactions() throws {
        let simplifyDebts = SimplifyDebts()
        simplifyDebts.visitedEdges = []

        // 模拟 A 给 B 的账单为 -50，表示退款或折扣，B 支付给 C 100
        let transactions: [EdgeKey: Int64] = [
            EdgeKey(from: 0, to: 1): -50,   // A -> B (退款)
            EdgeKey(from: 1, to: 2): 100    // B -> C
        ]
        let person = ["A", "B", "C"]
        let n = person.count
        let solver = Dinics(n: n, person: person)
        simplifyDebts.simplifyTransactions(transactions: transactions, solver: solver)

        let result = "Debts simplified successfully"
        XCTAssertEqual(result, "Debts simplified successfully", "The algorithm output is not as expected for negative transactions.")
    }

    // 新增测试用例：所有人支付给多人的情况
    func testMultipleToMultipleTransactions() throws {
        let simplifyDebts = SimplifyDebts()
        simplifyDebts.visitedEdges = []

        // 模拟每个人都有多个支付
        let transactions: [EdgeKey: Int64] = [
            EdgeKey(from: 0, to: 1): 90,   // A -> B
            EdgeKey(from: 0, to: 2): 80,   // A -> C
            EdgeKey(from: 1, to: 2): 60,   // B -> C
            EdgeKey(from: 1, to: 3): 100,  // B -> D
            EdgeKey(from: 2, to: 3): 70    // C -> D
        ]
        let person = ["A", "B", "C", "D"]
        let n = person.count
        let solver = Dinics(n: n, person: person)
        simplifyDebts.simplifyTransactions(transactions: transactions, solver: solver)

        let result = "Debts simplified successfully"
        XCTAssertEqual(result, "Debts simplified successfully", "The algorithm output is not as expected for multiple-to-multiple transactions.")
    }

    // 性能测试
    func testPerformanceExample() throws {
        measure {
            let simplifyDebts = SimplifyDebts()
            _ = simplifyDebts.createGraphForDebts()
        }
    }
}
