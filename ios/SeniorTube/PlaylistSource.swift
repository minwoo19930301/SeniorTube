import Foundation

enum PlaylistSourceError: Error {
    case noCatalog
}

enum PlaylistSourceBuilder {
    /// Returns only the fields the player needs:
    /// {"playlistId":"..."} or {"videos":["id", ...]}.
    static func makeSourceJSON(catalogData: Data, regionCode: String?) throws -> String {
        let catalog = try JSONDecoder().decode(PlaylistCatalog.self, from: catalogData)
        guard let entry = pickEntry(
            countries: catalog.countries,
            preferred: regionCode?.uppercased(),
            fallback: catalog.defaultCountry.uppercased()
        ) else {
            throw PlaylistSourceError.noCatalog
        }

        let source: [String: Any]
        let playlistID = entry.playlistID?
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        if !playlistID.isEmpty {
            source = ["playlistId": playlistID]
        } else {
            source = ["videos": (entry.videos ?? []).map(\.id).shuffled()]
        }

        let data = try JSONSerialization.data(
            withJSONObject: source,
            options: [.sortedKeys]
        )
        return String(decoding: data, as: UTF8.self)
    }

    private static func pickEntry(
        countries: [String: CountryPlaylist],
        preferred: String?,
        fallback: String
    ) -> CountryPlaylist? {
        if let preferred,
           let entry = countries[preferred],
           entry.hasPlayableContent {
            return entry
        }
        if let entry = countries[fallback], entry.hasPlayableContent {
            return entry
        }
        return countries
            .sorted { $0.key < $1.key }
            .first(where: { $0.value.hasPlayableContent })?
            .value
    }
}

private struct PlaylistCatalog: Decodable {
    let defaultCountry: String
    let countries: [String: CountryPlaylist]

    enum CodingKeys: String, CodingKey {
        case defaultCountry = "default_country"
        case countries
    }
}

private struct CountryPlaylist: Decodable {
    let playlistID: String?
    let videos: [PlaylistVideo]?

    var hasPlayableContent: Bool {
        let hasPlaylist = !(playlistID?
            .trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true)
        return hasPlaylist || !(videos?.isEmpty ?? true)
    }

    enum CodingKeys: String, CodingKey {
        case playlistID = "playlist_id"
        case videos
    }
}

private struct PlaylistVideo: Decodable {
    let id: String
}
