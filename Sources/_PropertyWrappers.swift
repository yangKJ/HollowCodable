//
//  PropertyWrappers.swift
//  HollowCodable
//
//  Created by Condy on 2024/6/1.
//

import Foundation

// MARK: - Date

/// If you want to use it like this: `@DateCoding<Hollow.DateFormat.yyyy, Hollow.Since1970.milliseconds>`
public typealias DateCoding<D: HollowValueProvider, E: HollowValueProvider> = AnyBacked<DateValue<D,E>>
public typealias DateDecoding<D: HollowValueProvider> = AnyBackedDecoding<DateValue<D,D>>
public typealias DateEncoding<E: HollowValueProvider> = AnyBackedEncoding<DateValue<E,E>>

/// If you want to use it like this: `@DateFormatCoding<Hollow.DateFormat.yyyy_mm_dd>`
public typealias DateFormatCoding<T: HollowValueProvider>   = AnyBacked<DateValue<T,T>>
public typealias DateFormatDecoding<D: HollowValueProvider> = AnyBackedDecoding<DateValue<D,D>>
public typealias DateFormatEncoding<E: HollowValueProvider> = AnyBackedEncoding<DateValue<E,E>>

public typealias DateFormatterCoding<D: HollowValueProvider, E: HollowValueProvider> = AnyBacked<DateValue<D,E>>

/// If you want to use it like this: `@Since1970DateCoding<Hollow.Since1970.milliseconds>`
public typealias Since1970DateCoding<D: HollowValueProvider, E: HollowValueProvider> = AnyBacked<DateValue<D,E>>
public typealias Since1970DateDecoding<D: HollowValueProvider> = AnyBackedDecoding<DateValue<D,D>>
public typealias Since1970DateEncoding<E: HollowValueProvider> = AnyBackedEncoding<DateValue<E,E>>

public typealias SecondsSince1970DateCoding   = Since1970DateCoding<Hollow.Since1970.seconds,Hollow.Since1970.seconds>
public typealias SecondsSince1970DateDecoding = Since1970DateDecoding<Hollow.Since1970.seconds>
public typealias SecondsSince1970DateEncoding = Since1970DateEncoding<Hollow.Since1970.seconds>

public typealias MilliSecondsSince1970DateCoding   = Since1970DateCoding<Hollow.Since1970.milliseconds,Hollow.Since1970.milliseconds>
public typealias MilliSecondsSince1970DateDecoding = Since1970DateDecoding<Hollow.Since1970.milliseconds>
public typealias MilliSecondsSince1970DateEncoding = Since1970DateEncoding<Hollow.Since1970.milliseconds>

public typealias ISO8601DateCoding  = DateFormatCoding<Hollow.DateFormat.ISO8601Date>
public typealias ISO8601DateDeoding = DateFormatDecoding<Hollow.DateFormat.ISO8601Date>
public typealias ISO8601DateEnoding = DateFormatEncoding<Hollow.DateFormat.ISO8601Date>

// MARK: - NSDecimalNumber

public typealias DecimalNumberCoding   = AnyBacked<DecimalNumberValue>
public typealias DecimalNumberDecoding = AnyBackedDecoding<DecimalNumberValue>
public typealias DecimalNumberEncoding = AnyBackedEncoding<DecimalNumberValue>

// MARK: - Color

public typealias HexColorHasAlphaCoding   = AnyBacked<HexColor<Hollow.HasBoolean.yes>>
public typealias HexColorHasAlphaDecoding = AnyBackedDecoding<HexColor<Hollow.HasBoolean.yes>>
public typealias HexColorHasAlphaEncoding = AnyBackedEncoding<HexColor<Hollow.HasBoolean.yes>>

public typealias RGBColorCoding   = AnyBacked<RGB>
public typealias RGBColorDecoding = AnyBackedDecoding<RGB>
public typealias RGBColorEncoding = AnyBackedEncoding<RGB>

public typealias RGBAColorCoding   = AnyBacked<RGBA>
public typealias RGBAColorDecoding = AnyBackedDecoding<RGBA>
public typealias RGBAColorEncoding = AnyBackedEncoding<RGBA>

/// When coding the color hex value hasn't alpha.
public typealias HexColorCoding   = AnyBacked<HexColor<Hollow.HasBoolean.no>>
public typealias HexColorDecoding = AnyBackedDecoding<HexColor<Hollow.HasBoolean.no>>
public typealias HexColorEncoding = AnyBackedEncoding<HexColor<Hollow.HasBoolean.no>>

// MARK: - Bool

public typealias BoolCoding   = AnyBacked<BooleanValue<Hollow.HasBoolean.no>>
public typealias BoolDecoding = AnyBackedDecoding<BooleanValue<Hollow.HasBoolean.no>>
public typealias BoolEncoding = AnyBackedEncoding<BooleanValue<Hollow.HasBoolean.no>>

public typealias FalseBoolCoding   = DefaultBacked<BooleanValue<Hollow.HasBoolean.no>>
public typealias FalseBoolDecoding = DefaultBackedDecoding<BooleanValue<Hollow.HasBoolean.no>>
public typealias FalseBoolEncoding = DefaultBackedEncoding<BooleanValue<Hollow.HasBoolean.no>>

public typealias TrueBoolCoding   = DefaultBacked<BooleanValue<Hollow.HasBoolean.yes>>
public typealias TrueBoolDecoding = DefaultBackedDecoding<BooleanValue<Hollow.HasBoolean.yes>>
public typealias TrueBoolEncoding = DefaultBackedEncoding<BooleanValue<Hollow.HasBoolean.yes>>

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

public typealias Base64Coding   = AnyBacked<Base64Data>
public typealias Base64Decoding = AnyBackedDecoding<Base64Data>
public typealias Base64Encoding = AnyBackedEncoding<Base64Data>
