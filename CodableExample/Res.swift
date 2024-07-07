//
//  Res.swift
//  CodableExample
//
//  Created by Condy on 2024/6/10.
//

import Foundation
import zlib

struct Res {
    struct GZip {}
    
    /// Read json data
    public static func jsonData(_ named: String) -> Data? {
        guard let path = ["json", "JSON", "Json"].compactMap({
            Bundle.main.path(forResource: named, ofType: $0)
        }).first else {
            return nil
        }
        let contentURL = URL(fileURLWithPath: path)
        return try? Data(contentsOf: contentURL)
    }
}

extension Data {
    
    func gunzipped() -> Data? {
        let data = Res.GZip.gzipUncompress(self)
        return data.isEmpty ? nil : data
    }
    
    func gzipped() -> Data? {
        let data = Res.GZip.gzipCompress(self)
        return data.isEmpty ? nil : data
    }
}

extension Res.GZip {
    
    /// Decompression stream size
    static let GZIP_STREAM_SIZE: Int32 = Int32(MemoryLayout<z_stream>.size)
    /// Decompression buffer size
    static let GZIP_BUF_LENGTH: Int = 512
    
    /// Whether to compress data for `GZip`
    public static func isGZipCompressed(_ data: Data) -> Bool {
        return data.starts(with: [0x1f, 0x8b])
    }
    
    public static func gzipCompress(_ data: Data) -> Data {
        guard data.count > 0 else {
            return data
        }
        var stream = z_stream()
        stream.avail_in = uInt(data.count)
        stream.total_out = 0
        data.withUnsafeBytes { (inputPointer: UnsafeRawBufferPointer) in
            stream.next_in = UnsafeMutablePointer<Bytef>(mutating: inputPointer.bindMemory(to: Bytef.self).baseAddress!)
                .advanced(by: Int(stream.total_in))
        }
        var status = deflateInit2_(&stream,
                                   Z_DEFAULT_COMPRESSION,
                                   Z_DEFLATED,
                                   MAX_WBITS + 16,
                                   MAX_MEM_LEVEL,
                                   Z_DEFAULT_STRATEGY,
                                   ZLIB_VERSION,
                                   GZIP_STREAM_SIZE)
        if status != Z_OK {
            return Data()
        }
        
        var compressedData = Data()
        while stream.avail_out == 0 {
            if Int(stream.total_out) >= compressedData.count {
                compressedData.count += GZIP_BUF_LENGTH
            }
            stream.avail_out = uInt(GZIP_BUF_LENGTH)
            compressedData.withUnsafeMutableBytes { (outputPointer: UnsafeMutableRawBufferPointer) in
                stream.next_out = outputPointer.bindMemory(to: Bytef.self).baseAddress!
                    .advanced(by: Int(stream.total_out))
            }
            status = deflate(&stream, Z_FINISH)
            if status != Z_OK && status != Z_STREAM_END {
                return Data()
            }
        }
        guard deflateEnd(&stream) == Z_OK else {
            return Data()
        }
        compressedData.count = Int(stream.total_out)
        return compressedData
    }
    
    public static func gzipUncompress(_ data: Data) -> Data {
        guard !data.isEmpty else {
            return Data()
        }
        guard isGZipCompressed(data) else {
            return data
        }
        var stream = z_stream()
        data.withUnsafeBytes { (inputPointer: UnsafeRawBufferPointer) in
            stream.next_in = UnsafeMutablePointer<Bytef>(mutating: inputPointer.bindMemory(to: Bytef.self).baseAddress!)
                .advanced(by: Int(stream.total_in))
        }
        stream.avail_in = uInt(data.count)
        stream.total_out = 0
        var status: Int32 = inflateInit2_(&stream, MAX_WBITS + 16, ZLIB_VERSION, GZIP_STREAM_SIZE)
        guard status == Z_OK else {
            return Data()
        }
        var decompressed = Data(capacity: data.count * 2)
        while stream.avail_out == 0 {
            stream.avail_out = uInt(GZIP_BUF_LENGTH)
            decompressed.count += GZIP_BUF_LENGTH
            decompressed.withUnsafeMutableBytes { (outputPointer: UnsafeMutableRawBufferPointer) in
                stream.next_out = outputPointer.bindMemory(to: Bytef.self).baseAddress!
                    .advanced(by: Int(stream.total_out))
            }
            status = inflate(&stream, Z_SYNC_FLUSH)
            if status != Z_OK && status != Z_STREAM_END {
                break
            }
        }
        if inflateEnd(&stream) != Z_OK {
            return Data()
        }
        decompressed.count = Int(stream.total_out)
        return decompressed
    }
}
