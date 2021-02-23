import Foundation
import PerfectSQLite

// Determine pathname of database
let currentDirectory = URL(fileURLWithPath: FileManager.default.currentDirectoryPath, isDirectory: true)
let targetPathname = currentDirectory.appendingPathComponent("chinook.db", isDirectory: true)
guard FileManager.default.fileExists(atPath: targetPathname.path) else {
    fatalError("Unable to find database file: \(targetPathname.path)")
}

do {
    let sqlite = try SQLite(targetPathname.path)
    defer {
        sqlite.close()
    }

    let statement = "SELECT * FROM albums"
    try sqlite.forEachRow(statement: statement) {(statement: SQLiteStmt, i:Int) -> () in
        print(statement.columnText(position: 1))
    }
} catch {
    fatalError(error.localizedDescription)
}
