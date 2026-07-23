import Foundation

private func decodedSource(
    catalogData: Data,
    regionCode: String
) throws -> [String: Any] {
    let source = try PlaylistSourceBuilder.makeSourceJSON(
        catalogData: catalogData,
        regionCode: regionCode
    )
    let data = try XCTUnwrap(source.data(using: .utf8))
    return try XCTUnwrap(
        JSONSerialization.jsonObject(with: data) as? [String: Any]
    )
}

private func XCTUnwrap<T>(
    _ value: T?,
    file: StaticString = #filePath,
    line: UInt = #line
) throws -> T {
    guard let value else {
        throw SmokeFailure(message: "Unexpected nil", file: file, line: line)
    }
    return value
}

private func expect(
    _ condition: @autoclosure () -> Bool,
    _ message: String,
    file: StaticString = #filePath,
    line: UInt = #line
) throws {
    guard condition() else {
        throw SmokeFailure(message: message, file: file, line: line)
    }
}

private struct SmokeFailure: Error, CustomStringConvertible {
    let message: String
    let file: StaticString
    let line: UInt

    var description: String {
        "\(file):\(line): \(message)"
    }
}

do {
    guard CommandLine.arguments.count == 2 else {
        throw SmokeFailure(
            message: "Pass the shared playlists.json path",
            file: #filePath,
            line: #line
        )
    }

    let catalogData = try Data(
        contentsOf: URL(fileURLWithPath: CommandLine.arguments[1])
    )

    let korea = try decodedSource(catalogData: catalogData, regionCode: "KR")
    try expect(
        korea["playlistId"] as? String == "PLZnMDtb3O2oc",
        "Korea should use the maintained Korean playlist"
    )

    let emptyCanada = try decodedSource(
        catalogData: catalogData,
        regionCode: "CA"
    )
    try expect(
        emptyCanada["playlistId"] as? String == "PLAy33xDBBXnw",
        "A configured country with no playable source should use the default"
    )

    let unknownCountry = try decodedSource(
        catalogData: catalogData,
        regionCode: "XX"
    )
    try expect(
        unknownCountry["playlistId"] as? String == "PLAy33xDBBXnw",
        "An unknown country should use the default"
    )

    let bundledCatalog = Data(
        """
        {
          "default_country": "US",
          "countries": {
            "US": {
              "playlist_id": "",
              "videos": [{"id": "one"}, {"id": "two"}]
            }
          }
        }
        """.utf8
    )
    let bundled = try decodedSource(
        catalogData: bundledCatalog,
        regionCode: "US"
    )
    let IDs = Set((bundled["videos"] as? [String]) ?? [])
    try expect(
        IDs == Set(["one", "two"]),
        "Bundled video IDs should be preserved while their order is shuffled"
    )

    print("Playlist source smoke tests passed.")
} catch {
    fputs("Smoke test failed: \(error)\n", stderr)
    exit(1)
}
