//
//  PropertyWrappers.swift
//  HollowCodable
//
//  Created by Condy on 2024/6/1.
//

import Foundation

// MARK: - Date

/// If you want to use it like this: `@DateCoding<Hollow.DateFormat.yyyy, Hollow.Timestamp.secondsSince1970>`
public typealias DateCoding<D: DateConverter, E: DateConverter> = AnyBacked<DateValue<D,E>>
public typealias DateDecoding<D: DateConverter> = AnyBackedDecoding<DateValue<D,D>>
public typealias DateEncoding<E: DateConverter> = AnyBackedEncoding<DateValue<E,E>>

public typealias DateFormatterCoding<D: DateConverter, E: DateConverter> = DateCoding<D,E>

/// If you want to use it like this: `@DateFormatCoding<Hollow.DateFormat.yyyy_mm_dd>`
public typealias DateFormatCoding<T: DateConverter>   = AnyBacked<DateValue<T,T>>
public typealias DateFormatDecoding<D: DateConverter> = AnyBackedDecoding<DateValue<D,D>>
public typealias DateFormatEncoding<E: DateConverter> = AnyBackedEncoding<DateValue<E,E>>

/// If you want to use it like this: `@TimestampDateCoding<Hollow.Timestamp.millisecondsSince1970>`
public typealias TimestampDateCoding<D: DateConverter, E: DateConverter> = AnyBacked<DateValue<D,E>>
public typealias TimestampDateDecoding<D: DateConverter> = AnyBackedDecoding<DateValue<D,D>>
public typealias TimestampDateEncoding<E: DateConverter> = AnyBackedEncoding<DateValue<E,E>>

public typealias Since1970DateCoding<T: DateConverter> = TimestampDateCoding<T,T>

public typealias SecondsSince1970DateCoding   = TimestampDateCoding<Hollow.Timestamp.secondsSince1970, Hollow.Timestamp.secondsSince1970>
public typealias SecondsSince1970DateDecoding = TimestampDateDecoding<Hollow.Timestamp.secondsSince1970>
public typealias SecondsSince1970DateEncoding = TimestampDateEncoding<Hollow.Timestamp.secondsSince1970>

public typealias MilliSecondsSince1970DateCoding   = TimestampDateCoding<Hollow.Timestamp.millisecondsSince1970, Hollow.Timestamp.millisecondsSince1970>
public typealias MilliSecondsSince1970DateDecoding = TimestampDateDecoding<Hollow.Timestamp.millisecondsSince1970>
public typealias MilliSecondsSince1970DateEncoding = TimestampDateEncoding<Hollow.Timestamp.millisecondsSince1970>

public typealias ISO8601DateCoding  = DateFormatCoding<Hollow.DateFormat.ISO8601Date>
public typealias ISO8601DateDeoding = DateFormatDecoding<Hollow.DateFormat.ISO8601Date>
public typealias ISO8601DateEnoding = DateFormatEncoding<Hollow.DateFormat.ISO8601Date>

public typealias RFC2822DateCoding  = DateFormatCoding<Hollow.DateFormat.RFC2822Date>
public typealias RFC2822DateDeoding = DateFormatDecoding<Hollow.DateFormat.RFC2822Date>
public typealias RFC2822DateEnoding = DateFormatEncoding<Hollow.DateFormat.RFC2822Date>

public typealias RFC3339DateCoding  = DateFormatCoding<Hollow.DateFormat.RFC3339Date>
public typealias RFC3339DateDeoding = DateFormatDecoding<Hollow.DateFormat.RFC3339Date>
public typealias RFC3339DateEnoding = DateFormatEncoding<Hollow.DateFormat.RFC3339Date>

// MARK: - NSDecimalNumber

public typealias DecimalNumberCoding   = AnyBacked<DecimalNumberValue>
public typealias DecimalNumberDecoding = AnyBackedDecoding<DecimalNumberValue>
public typealias DecimalNumberEncoding = AnyBackedEncoding<DecimalNumberValue>

// MARK: - Color

/// When coding the color hex value hasn't alpha.
public typealias HexColorCoding   = AnyBacked<HexColor<False>>
public typealias HexColorDecoding = AnyBackedDecoding<HexColor<False>>
public typealias HexColorEncoding = AnyBackedEncoding<HexColor<False>>

public typealias HexColorHasAlphaCoding   = AnyBacked<HexColor<True>>
public typealias HexColorHasAlphaDecoding = AnyBackedDecoding<HexColor<True>>
public typealias HexColorHasAlphaEncoding = AnyBackedEncoding<HexColor<True>>

public typealias RGBColorCoding   = AnyBacked<RGB>
public typealias RGBColorDecoding = AnyBackedDecoding<RGB>
public typealias RGBColorEncoding = AnyBackedEncoding<RGB>

public typealias RGBAColorCoding   = AnyBacked<RGBA>
public typealias RGBAColorDecoding = AnyBackedDecoding<RGBA>
public typealias RGBAColorEncoding = AnyBackedEncoding<RGBA>

// MARK: - Bool

public typealias BoolCoding   = AnyBacked<BooleanValue<False>>
public typealias BoolDecoding = AnyBackedDecoding<BooleanValue<False>>
public typealias BoolEncoding = AnyBackedEncoding<BooleanValue<False>>

public typealias FalseBoolCoding   = DefaultBacked<BooleanValue<False>>
public typealias FalseBoolDecoding = DefaultBackedDecoding<BooleanValue<False>>
public typealias FalseBoolEncoding = DefaultBackedEncoding<BooleanValue<False>>

public typealias TrueBoolCoding   = DefaultBacked<BooleanValue<True>>
public typealias TrueBoolDecoding = DefaultBackedDecoding<BooleanValue<True>>
public typealias TrueBoolEncoding = DefaultBackedEncoding<BooleanValue<True>>

// MARK: - CGRect

public typealias CGRectCoding   = AnyBacked<RectValue>
public typealias CGRectDecoding = AnyBackedDecoding<RectValue>
public typealias CGRectEncoding = AnyBackedEncoding<RectValue>

// MARK: - CGPoint

public typealias PointCoding   = AnyBacked<PointValue>
public typealias PointDecoding = AnyBackedDecoding<PointValue>
public typealias PointEncoding = AnyBackedEncoding<PointValue>

// MARK: - Enum

public typealias EnumCoding<T: RawRepresentable>   = AnyBacked<EnumValue<T>> where T.RawValue: Codable
public typealias EnumDecoding<T: RawRepresentable> = AnyBackedDecoding<EnumValue<T>> where T.RawValue: Codable
public typealias EnumEncoding<T: RawRepresentable> = AnyBackedEncoding<EnumValue<T>> where T.RawValue: Codable

/// It has a default value when it is nil, and it is the first enumeration value.
public typealias HasEnumCoding<T: RawRepresentable>   = DefaultBacked<EnumValue<T>> where T.RawValue: Codable, T: CaseIterable
public typealias HasEnumDecoding<T: RawRepresentable> = DefaultBackedDecoding<EnumValue<T>> where T.RawValue: Codable, T: CaseIterable
public typealias HasEnumEncoding<T: RawRepresentable> = DefaultBackedEncoding<EnumValue<T>> where T.RawValue: Codable, T: CaseIterable

// MARK: - Data

public typealias Base64Coding   = AnyBacked<DataValue<Hollow.Base64Data>>
public typealias Base64Decoding = AnyBackedDecoding<DataValue<Hollow.Base64Data>>
public typealias Base64Encoding = AnyBackedEncoding<DataValue<Hollow.Base64Data>>

// MARK: - Dictionary

/// Support any value property wrapper with dictionary.
public typealias DictionaryCoding   = AnyBacked<AnyDictionary>
public typealias DictionaryDecoding = AnyBackedDecoding<AnyDictionary>
public typealias DictionaryEncoding = AnyBackedEncoding<AnyDictionary>

// MARK: - Array

/// Support any value dictionary property wrapper with array.
public typealias ArrayCoding   = AnyBacked<AnyDictionaryArray>
public typealias ArrayDecoding = AnyBackedDecoding<AnyDictionaryArray>
public typealias ArrayEncoding = AnyBackedEncoding<AnyDictionaryArray>
