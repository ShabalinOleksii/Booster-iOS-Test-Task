//
//  FileStorage.swift
//  BoosterTestTask
//
//  Created by Oleksii Shabalin on 8/11/22.
//

import Foundation

final class FileStorage {

    private init() { }

    static func write(data: Data, to fileName: String) {
        guard let path = getPath(for: fileName) else { return }

        do {
            try data.write(to: path)
        } catch {
            assertionFailure("File is not written")
        }
    }

    static func read(from fileName: String) -> Data? {
        guard let path = getPath(for: fileName) else { return nil }

        do {
            return try Data(contentsOf: path)
        } catch {
            assertionFailure("File is not read")
        }

        return nil
    }
}

private extension FileStorage {

    static func getPath(for fileName: String) -> URL? {
        guard
            let documentDirectory = FileManager.default.urls(for: .documentDirectory,
                                                             in: .userDomainMask).first
        else { return nil }

        let path = documentDirectory.appendingPathComponent(fileName)
        return path
    }
}
