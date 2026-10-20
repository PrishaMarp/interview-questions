//
//  InterviewQuestion.swift
//  Interview Questions
//

import Foundation
import os

enum Difficulty: Int, CaseIterable, Comparable {
    case warmup = 1
    case easy
    case medium
    case hard
    case expert

    var title: String {
        switch self {
        case .warmup: "Warm-up"
        case .easy: "Easy"
        case .medium: "Medium"
        case .hard: "Hard"
        case .expert: "Expert"
        }
    }

    static func < (lhs: Difficulty, rhs: Difficulty) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}

struct InterviewQuestion: Identifiable, Equatable {
    let id = UUID()
    let difficulty: Int
    let tier: Difficulty
    let prompt: String
}

enum QuestionBank {
    /// Ordered so each prompt is strictly harder than the one before it.
    static let all: [InterviewQuestion] = [
        InterviewQuestion(
            difficulty: 1,
            tier: .warmup,
            prompt: "What is the difference between a class and a struct?"
        ),
        InterviewQuestion(
            difficulty: 2,
            tier: .warmup,
            prompt: "What does it mean for an operation to run in constant time? Give one example."
        ),
        InterviewQuestion(
            difficulty: 3,
            tier: .warmup,
            prompt: "Why keep a project in version control if you are the only person writing it?"
        ),
        InterviewQuestion(
            difficulty: 4,
            tier: .easy,
            prompt: "When would you choose a linked list instead of an array?"
        ),
        InterviewQuestion(
            difficulty: 5,
            tier: .easy,
            prompt: "What is the difference between authentication and authorization?"
        ),
        InterviewQuestion(
            difficulty: 6,
            tier: .easy,
            prompt: "Explain a race condition, and name one way to prevent it."
        ),
        InterviewQuestion(
            difficulty: 7,
            tier: .medium,
            prompt: "How do you detect a cycle in a linked list without storing every node you have visited?"
        ),
        InterviewQuestion(
            difficulty: 8,
            tier: .medium,
            prompt: "A hash map lookup is usually constant time. When does looking up one key become much slower?"
        ),
        InterviewQuestion(
            difficulty: 9,
            tier: .medium,
            prompt: "Compare a process and a thread. When would you add a process instead of another thread?"
        ),
        InterviewQuestion(
            difficulty: 10,
            tier: .hard,
            prompt: "Design a rate limiter for an API that runs on several servers. Where do the counters live, and why?"
        ),
        InterviewQuestion(
            difficulty: 11,
            tier: .hard,
            prompt: "Adding a database index speeds up reads. Describe a case where that index makes the system slower overall."
        ),
        InterviewQuestion(
            difficulty: 12,
            tier: .hard,
            prompt: "What problem does consistent hashing solve when you add a node to a cache cluster?"
        ),
        InterviewQuestion(
            difficulty: 13,
            tier: .expert,
            prompt: "Design a URL shortener that still redirects users if one data center is unreachable. What do you replicate, and what can you afford to lose?"
        ),
        InterviewQuestion(
            difficulty: 14,
            tier: .expert,
            prompt: "After a deploy, p99 latency doubled but the average barely moved. How do you investigate?"
        ),
        InterviewQuestion(
            difficulty: 15,
            tier: .expert,
            prompt: "Two workers must not process the same job. Describe a distributed lock, and one failure that can still run the job twice."
        ),
    ]
}

struct QuestionLogEntry: Identifiable, Equatable {
    let id = UUID()
    let number: Int
    let appearedAt: Date
    let tier: String
    let difficulty: Int
    let prompt: String
}

enum QuestionLogFormat {
    static func text(entries: [QuestionLogEntry], generatedAt: Date) -> String {
        var lines = [
            "Interview Questions log",
            "Generated: \(stamp(generatedAt))",
            "Entries: \(entries.count)",
            "A line is written each time a question appears.",
            "",
        ]

        for entry in entries {
            lines.append(
                "Question \(entry.number) | \(stamp(entry.appearedAt)) | \(entry.tier) | difficulty \(entry.difficulty)"
            )
            lines.append(entry.prompt)
            lines.append("")
        }

        return lines.joined(separator: "\n")
    }

    static func stamp(_ date: Date) -> String {
        date.formatted(Date.ISO8601FormatStyle(includingFractionalSeconds: false))
    }
}

enum QuestionLogger {
    private static let logger = Logger(subsystem: "FlexLab.Interview-Questions", category: "QuestionLog")

    static func appeared(_ entry: QuestionLogEntry) {
        let number = entry.number
        let tier = entry.tier
        let difficulty = entry.difficulty
        let prompt = entry.prompt
        logger.info(
            "New question \(number, privacy: .public) appeared | \(tier, privacy: .public) | difficulty \(difficulty, privacy: .public) | \(prompt, privacy: .public)"
        )
    }
}
