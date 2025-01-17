import Foundation

extension KeyedDecodingContainer {
    func decode<T>(_ key: KeyedDecodingContainer.Key) throws -> T where T: Decodable {
        try decode(T.self, forKey: key)
    }

    func decodeIfPresent<T>(_ key: KeyedDecodingContainer.Key) throws -> T? where T: Decodable {
        try decodeIfPresent(T.self, forKey: key)
    }

    func decodeIntIfPresent(_ key: KeyedDecodingContainer.Key) throws -> UInt? {
        if let string: String = try? decodeIfPresent(key) {
            return UInt(string)
        } else if let bool: Bool = try decodeIfPresent(key) {
            // don't `try?` here in case key _does_ exist but isn't an expected type
            // ie. not a string/bool
            return bool ? 0 : 1
        } else {
            return nil
        }
    }

    func decodeIntBool(_ key: KeyedDecodingContainer.Key) throws -> Bool {
        guard let int = try decodeIntIfPresent(key) else {
            return false
        }
        return int == 1
    }

    func decodeIntBoolIfPresent(_ key: KeyedDecodingContainer.Key) throws -> Bool? {
        guard let int = try decodeIntIfPresent(key) else {
            return nil
        }
        return int == 1
    }
}
