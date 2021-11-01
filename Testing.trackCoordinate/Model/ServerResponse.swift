////
////  ServerResponse.swift
////  Testing.trackCoordinate
////
////  Created by Maksim on 08.07.2021.
////
//
//import Foundation
//
////GGeoJSON
////MKGeoJSONDecoder
////MKGeoJSONFeatures
////Geometry
//
//// This file was generated from JSON Schema using quicktype, do not modify it directly.
//// To parse the JSON, add this file to your project and do:
////
////   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)
//
import Foundation


// MARK: - Welcome

//
//// MARK: - Welcome
//struct GeoJSONResponse: Codable {
//    let type: String
//    let features: [Feature]
//}
//
//// MARK: - Feature
//struct Feature: Codable {
//    let type: String
//    let properties: Properties
//    let geometry: Geometry
//}
//
//// MARK: - Geometry
//struct Geometry: Codable {
//    let type: String
//    let coordinates: [[[[Double]]]]
//}
//
//// MARK: - Properties
//struct Properties: Codable {
//    let scalerank: Int
//    let featurecla: String
//    let labelrank: Int
//    let sovereignt, sovA3: String
//    let adm0DIF, level: Int
//    let type, admin, adm0A3: String
//    let geouDIF: Int
//    let geounit, guA3: String
//    let suDIF: Int
//    let subunit, suA3: String
//    let brkDiff: Int
//    let name, nameLong, brkA3, brkName: String
//    let brkGroup: JSONNull?
//    let abbrev, postal, formalEn: String
//    let formalFr, noteAdm0, noteBrk: JSONNull?
//    let nameSort: String
//    let nameAlt: JSONNull?
//    let mapcolor7, mapcolor8, mapcolor9, mapcolor13: Int
//    let popEst, gdpMdEst, popYear, lastcensus: Int
//    let gdpYear: Int
//    let economy, incomeGrp: String
//    let wikipedia: Int
//    let fips10_, isoA2, isoA3, isoN3: String
//    let unA3, wbA2, wbA3: String
//    let woeID, woeIDEh: Int
//    let woeNote, adm0A3Is, adm0A3Us: String
//    let adm0A3Un, adm0A3Wb: Int
//    let continent, regionUn, subregion, regionWb: String
//    let nameLen, longLen, abbrevLen, tiny: Int
//    let homepart: Int
//    let filename: String
//
//    enum CodingKeys: String, CodingKey {
//        case scalerank, featurecla, labelrank, sovereignt
//        case sovA3 = "sov_a3"
//        case adm0DIF = "adm0_dif"
//        case level, type, admin
//        case adm0A3 = "adm0_a3"
//        case geouDIF = "geou_dif"
//        case geounit
//        case guA3 = "gu_a3"
//        case suDIF = "su_dif"
//        case subunit
//        case suA3 = "su_a3"
//        case brkDiff = "brk_diff"
//        case name
//        case nameLong = "name_long"
//        case brkA3 = "brk_a3"
//        case brkName = "brk_name"
//        case brkGroup = "brk_group"
//        case abbrev, postal
//        case formalEn = "formal_en"
//        case formalFr = "formal_fr"
//        case noteAdm0 = "note_adm0"
//        case noteBrk = "note_brk"
//        case nameSort = "name_sort"
//        case nameAlt = "name_alt"
//        case mapcolor7, mapcolor8, mapcolor9, mapcolor13
//        case popEst = "pop_est"
//        case gdpMdEst = "gdp_md_est"
//        case popYear = "pop_year"
//        case lastcensus
//        case gdpYear = "gdp_year"
//        case economy
//        case incomeGrp = "income_grp"
//        case wikipedia
//        case fips10_ = "fips_10_"
//        case isoA2 = "iso_a2"
//        case isoA3 = "iso_a3"
//        case isoN3 = "iso_n3"
//        case unA3 = "un_a3"
//        case wbA2 = "wb_a2"
//        case wbA3 = "wb_a3"
//        case woeID = "woe_id"
//        case woeIDEh = "woe_id_eh"
//        case woeNote = "woe_note"
//        case adm0A3Is = "adm0_a3_is"
//        case adm0A3Us = "adm0_a3_us"
//        case adm0A3Un = "adm0_a3_un"
//        case adm0A3Wb = "adm0_a3_wb"
//        case continent
//        case regionUn = "region_un"
//        case subregion
//        case regionWb = "region_wb"
//        case nameLen = "name_len"
//        case longLen = "long_len"
//        case abbrevLen = "abbrev_len"
//        case tiny, homepart, filename
//    }
//}
//
//// MARK: - Encode/decode helpers
//
//class JSONNull: Codable, Hashable {
//
//    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
//        return true
//    }
//
//    public var hashValue: Int {
//        return 0
//    }
//
//    public init() {}
//
//    public required init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if !container.decodeNil() {
//            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
//        }
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        try container.encodeNil()
//    }
//}
//
