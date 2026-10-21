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
            prompt: "Tell me about yourself."
        ),
        InterviewQuestion(
            difficulty: 2,
            tier: .warmup,
            prompt: "What are your strengths?"
        ),
        InterviewQuestion(
            difficulty: 3,
            tier: .warmup,
            prompt: "What are your weaknesses?"
        ),
        InterviewQuestion(
            difficulty: 4,
            tier: .easy,
            prompt: "How much do you want to earn?"
        ),
        InterviewQuestion(
            difficulty: 5,
            tier: .easy,
            prompt: "Why do you want this job?"
        ),
        InterviewQuestion(
            difficulty: 6,
            tier: .easy,
            prompt: "Why should we hire you?"
        ),
        InterviewQuestion(
            difficulty: 7,
            tier: .medium,
            prompt: "Where do you see yourself in five years?"
        ),
        InterviewQuestion(
            difficulty: 8,
            tier: .medium,
            prompt: "Tell me about a time you worked through a disagreement with a teammate."
        ),
        InterviewQuestion(
            difficulty: 9,
            tier: .medium,
            prompt: "Describe a time you missed a deadline. What did you do?"
        ),
        InterviewQuestion(
            difficulty: 10,
            tier: .hard,
            prompt: "Tell me about a time you failed. What did you learn?"
        ),
        InterviewQuestion(
            difficulty: 11,
            tier: .hard,
            prompt: "Describe a time you disagreed with your manager. How did you handle it?"
        ),
        InterviewQuestion(
            difficulty: 12,
            tier: .hard,
            prompt: "Tell me about a time you had to persuade someone who did not agree with you."
        ),
        InterviewQuestion(
            difficulty: 13,
            tier: .expert,
            prompt: "Tell me about a time you had to make a decision without all the information you wanted."
        ),
        InterviewQuestion(
            difficulty: 14,
            tier: .expert,
            prompt: "Describe a time you made an unpopular decision. How did you bring people with you?"
        ),
        InterviewQuestion(
            difficulty: 15,
            tier: .expert,
            prompt: "What is a belief you changed your mind about at work, and what changed it?"
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
            "Interview Questions",
            "Generated: \(stamp(generatedAt))",
            "Questions: \(entries.count)",
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

    static func roundStarted(questionCount: Int) {
        logger.info("Round started | \(questionCount, privacy: .public) questions")
    }

    static func appeared(_ entry: QuestionLogEntry) {
        let number = entry.number
        let tier = entry.tier
        let difficulty = entry.difficulty
        let prompt = entry.prompt
        logger.info(
            "Question \(number, privacy: .public) appeared | \(tier, privacy: .public) | difficulty \(difficulty, privacy: .public) | \(prompt, privacy: .public)"
        )
    }

    static func roundFinished(questionCount: Int) {
        logger.info("Round finished | \(questionCount, privacy: .public) questions")
    }
}
