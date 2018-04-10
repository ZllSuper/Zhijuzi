//
//  UserObj.m
//  AppProject
//
//  Created by Lala on 2017/10/24.
//  Copyright © 2017年 Meta-Insight. All rights reserved.
//

#import "UserObj.h"
#import "FMResultSet.h"

@implementation UserObj

- (instancetype)initWithFMResultSet:(FMResultSet *)set
{
    self = [super init];
    if (self) {
        _userID = [set stringForColumn:@"user_id"];
        _username = [set stringForColumn:@"username"];
        _password = [set stringForColumn:@"password"];
        _name = [set stringForColumn:@"name"];
        _name2 = [set stringForColumn:@"name2"];
        _linkman = [set stringForColumn:@"linkman"];
        _phone = [set stringForColumn:@"phone"];
        _per = [set doubleForColumn:@"per"];
        _province = [set stringForColumn:@"province"];
        _city = [set stringForColumn:@"city"];
        _district = [set stringForColumn:@"district"];
        _industry = [set stringForColumn:@"industry"];
        _industry2 = [set stringForColumn:@"industry2"];
        _province_name = [set stringForColumn:@"province_name"];
        _city_name = [set stringForColumn:@"city_name"];
        _district_name = [set stringForColumn:@"city_name"];
        _industry_name = [set stringForColumn:@"industry_name"];
        _industry2_name = [set stringForColumn:@"industry2_name"];
        _store_name = [set stringForColumn:@"store_name"];
        _address = [set stringForColumn:@"address"];
        _biz_type = [set stringForColumn:@"biz_type"];
        _bank = [set stringForColumn:@"bank"];
        _bank_code = [set stringForColumn:@"bank_code"];
        _bank_province = [set stringForColumn:@"bank_province"];
        _bank_city = [set stringForColumn:@"bank_city"];
        _bank_province_code = [set stringForColumn:@"bank_province_code"];
        _bank_city_code = [set stringForColumn:@"bank_city_code"];
        _bank_name = [set stringForColumn:@"bank_name"];
        _bank_name2 = [set stringForColumn:@"bank_name2"];
        _bank_name_code = [set stringForColumn:@"bank_name_code"];
        _bank_name2_code = [set stringForColumn:@"bank_name2_code"];
        _bank_phone = [set stringForColumn:@"bank_phone"];
        _bank_type = [set stringForColumn:@"bank_type"];
        _id_type = [set stringForColumn:@"id_type"];
        _id_name = [set stringForColumn:@"id_name"];
        _id_code = [set stringForColumn:@"id_code"];
        _license_code = [set stringForColumn:@"license_code"];
        _license_start = [set longForColumn:@"license_start"];
        _license_end = [set longForColumn:@"license_start"];
        _photo1 = [set stringForColumn:@"photo1"];
        _photo2 = [set stringForColumn:@"photo2"];
        _photo3 = [set stringForColumn:@"photo3"];
        _photo4 = [set stringForColumn:@"photo4"];
        _photo5 = [set stringForColumn:@"photo5"];
        _photo6 = [set stringForColumn:@"photo6"];
        _photo7 = [set stringForColumn:@"photo7"];
        _photo8 = [set stringForColumn:@"photo8"];
        _photo9 = [set stringForColumn:@"photo9"];
        _photo10 = [set stringForColumn:@"photo10"];
        _photo11 = [set stringForColumn:@"photo11"];
        _photo12 = [set stringForColumn:@"photo12"];
        _photo13 = [set stringForColumn:@"photo13"];
        _photo14 = [set stringForColumn:@"photo14"];
        _modify = [set stringForColumn:@"modify"];
        _admin = [set stringForColumn:@"admin"];
        _userStatus = [set intForColumn:@"userStatus"];
        _authenticStatus = [set intForColumn:@"authenticStatus"];
        _code = [set stringForColumn:@"code"];
        _lat = [set doubleForColumn:@"lat"];
        _lng = [set doubleForColumn:@"lng"];
    }
    return self;
}

- (void)configWithUserEditFMResultSet:(FMResultSet *)set
{
    NSString *name = [set stringForColumn:@"name"];
    NSString *name2 = [set stringForColumn:@"name2"];
    NSString *linkman = [set stringForColumn:@"linkman"];
    NSString *phone = [set stringForColumn:@"phone"];
    float per = [set doubleForColumn:@"per"];
    NSString *province = [set stringForColumn:@"province"];
    NSString *city = [set stringForColumn:@"city"];
    NSString *district = [set stringForColumn:@"district"];
    NSString *industry = [set stringForColumn:@"industry"];
    NSString *industry2 = [set stringForColumn:@"industry2"];
    NSString *province_name = [set stringForColumn:@"province_name"];
    NSString *city_name = [set stringForColumn:@"city_name"];
    NSString *district_name = [set stringForColumn:@"city_name"];
    NSString *industry_name = [set stringForColumn:@"industry_name"];
    NSString *industry2_name = [set stringForColumn:@"industry2_name"];
    NSString *store_name = [set stringForColumn:@"store_name"];
    NSString *address = [set stringForColumn:@"address"];
    NSString *biz_type = [set stringForColumn:@"biz_type"];
    NSString *bank = [set stringForColumn:@"bank"];
    NSString *bank_code = [set stringForColumn:@"bank_code"];
    NSString *bank_province = [set stringForColumn:@"bank_province"];
    NSString *bank_city = [set stringForColumn:@"bank_city"];
    NSString *bank_province_code = [set stringForColumn:@"bank_province_code"];
    NSString *bank_city_code = [set stringForColumn:@"bank_city_code"];
    NSString *bank_name = [set stringForColumn:@"bank_name"];
    NSString *bank_name2 = [set stringForColumn:@"bank_name2"];
    NSString *bank_name_code = [set stringForColumn:@"bank_name_code"];
    NSString *bank_name2_code = [set stringForColumn:@"bank_name2_code"];
    NSString *bank_phone = [set stringForColumn:@"bank_phone"];
    NSString *bank_type = [set stringForColumn:@"bank_type"];
    NSString *id_type = [set stringForColumn:@"id_type"];
    NSString *id_name = [set stringForColumn:@"id_name"];
    NSString *id_code = [set stringForColumn:@"id_code"];
    NSString *license_code = [set stringForColumn:@"license_code"];
    long license_start = [set longForColumn:@"license_start"];
    long license_end = [set longForColumn:@"license_start"];
    NSString *photo1 = [set stringForColumn:@"photo1"];
    NSString *photo2 = [set stringForColumn:@"photo2"];
    NSString *photo3 = [set stringForColumn:@"photo3"];
    NSString *photo4 = [set stringForColumn:@"photo4"];
    NSString *photo5 = [set stringForColumn:@"photo5"];
    NSString *photo6 = [set stringForColumn:@"photo6"];
    NSString *photo7 = [set stringForColumn:@"photo7"];
    NSString *photo8 = [set stringForColumn:@"photo8"];
    NSString *photo9 = [set stringForColumn:@"photo9"];
    NSString *photo10 = [set stringForColumn:@"photo10"];
    NSString *photo11 = [set stringForColumn:@"photo11"];
    NSString *photo12 = [set stringForColumn:@"photo12"];
    NSString *photo13 = [set stringForColumn:@"photo13"];
    NSString *photo14 = [set stringForColumn:@"photo14"];
    NSString *code = [set stringForColumn:@"code"];
    double lat = [set doubleForColumn:@"lat"];
    double lng = [set doubleForColumn:@"lng"];
    
    if (STRING_NIL_CHECK(name)) {
        _name = name;
    }
    if (STRING_NIL_CHECK(name2)) {
        _name2 = name2;
    }
    if (STRING_NIL_CHECK(linkman)) {
        _linkman = linkman;
    }
    if (STRING_NIL_CHECK(phone)) {
        _phone = phone;
    }
    if (per) {
        _per = per;
    }
    if (STRING_NIL_CHECK(province)) {
        _province = province;
    }
    if (STRING_NIL_CHECK(city)) {
        _city = city;
    }
    if (STRING_NIL_CHECK(district)) {
        _district = district;
    }
    if (STRING_NIL_CHECK(industry)) {
        _industry = industry;
    }
    if (STRING_NIL_CHECK(industry2)) {
        _industry2 = industry2;
    }
    if (STRING_NIL_CHECK(province_name)) {
        _province_name = province_name;
    }
    if (STRING_NIL_CHECK(city_name)) {
        _city_name = city_name;
    }
    if (STRING_NIL_CHECK(district_name)) {
        _district_name = district_name;
    }
    if (STRING_NIL_CHECK(industry_name)) {
        _industry_name = industry_name;
    }
    if (STRING_NIL_CHECK(industry2_name)) {
        _industry2_name = industry2_name;
    }
    if (STRING_NIL_CHECK(store_name)) {
        _store_name = store_name;
    }
    if (STRING_NIL_CHECK(address)) {
        _address = address;
    }
    if (STRING_NIL_CHECK(biz_type)) {
        _biz_type = biz_type;
    }
    if (STRING_NIL_CHECK(bank)) {
        _bank = bank;
    }
    if (STRING_NIL_CHECK(bank_code)) {
        _bank_code = bank_code;
    }
    if (STRING_NIL_CHECK(bank_province)) {
        _bank_province = bank_province;
    }
    if (STRING_NIL_CHECK(bank_city)) {
        _bank_city = bank_city;
    }
    if (STRING_NIL_CHECK(bank_province_code)) {
        _bank_province_code = bank_province_code;
    }
    if (STRING_NIL_CHECK(bank_city_code)) {
        _bank_city_code = bank_city_code;
    }
    if (STRING_NIL_CHECK(bank_name)) {
        _bank_name = bank_name;
    }
    if (STRING_NIL_CHECK(bank_name2)) {
        _bank_name2 = bank_name2;
    }
    if (STRING_NIL_CHECK(bank_name_code)) {
        _bank_name_code = bank_name_code;
    }
    if (STRING_NIL_CHECK(bank_name2_code)) {
        _bank_name2_code = bank_name2_code;
    }
    if (STRING_NIL_CHECK(bank_phone)) {
        _bank_phone = bank_phone;
    }
    if (STRING_NIL_CHECK(bank_type)) {
        _bank_type = bank_type;
    }
    if (STRING_NIL_CHECK(id_type)) {
        _id_type = id_type;
    }
    if (STRING_NIL_CHECK(id_name)) {
        _id_name = id_name;
    }
    if (STRING_NIL_CHECK(id_code)) {
        _id_code = id_code;
    }
    if (STRING_NIL_CHECK(license_code)) {
        _license_code = license_code;
    }
    if (license_start) {
        _license_start = license_start;
    }
    if (license_end) {
        _license_end = license_end;
    }
    if (STRING_NIL_CHECK(photo1)) {
        _photo1 = photo1;
    }
    if (STRING_NIL_CHECK(photo2)) {
        _photo2 = photo2;
    }
    if (STRING_NIL_CHECK(photo3)) {
        _photo3 = photo3;
    }
    if (STRING_NIL_CHECK(photo4)) {
        _photo4 = photo4;
    }
    if (STRING_NIL_CHECK(photo5)) {
        _photo5 = photo5;
    }
    if (STRING_NIL_CHECK(photo6)) {
        _photo6 = photo6;
    }
    if (STRING_NIL_CHECK(photo7)) {
        _photo7 = photo7;
    }
    if (STRING_NIL_CHECK(photo8)) {
        _photo8 = photo8;
    }
    if (STRING_NIL_CHECK(photo9)) {
        _photo9 = photo9;
    }
    if (STRING_NIL_CHECK(photo10)) {
        _photo10 = photo10;
    }
    if (STRING_NIL_CHECK(photo11)) {
        _photo11 = photo11;
    }
    if (STRING_NIL_CHECK(photo12)) {
        _photo12 = photo12;
    }
    if (STRING_NIL_CHECK(photo13)) {
        _photo13 = photo13;
    }
    if (STRING_NIL_CHECK(photo14)) {
        _photo14 = photo14;
    }
    if (STRING_NIL_CHECK(code)) {
        _code = code;
    }
    if (lat) {
        _lat = lat;
    }
    if (lng) {
        _lng = lng;
    }
}

- (id)initWithLoginApiData:(id)data
{
    self = [super init];
    if (self) {
        if (STRING_NIL_CHECK(data[@"$id"])) {
            _userID = data[@"$id"];
        }
        if (STRING_NIL_CHECK(data[@"name"])) {
            _name = data[@"name"];
        }
        if (STRING_NIL_CHECK(data[@"name2"])) {
            _name2 = data[@"name2"];
        }
        if (STRING_NIL_CHECK(data[@"linkman"])) {
            _linkman = data[@"linkman"];
        }
        if (STRING_NIL_CHECK(data[@"phone"])) {
            _phone = data[@"phone"];
        }
        if (NUMBER_NIL_CHECK(data[@"per"])) {
            _per = [data[@"per"] floatValue];
        }
        if (STRING_NIL_CHECK(data[@"province"])) {
            _province = data[@"province"];
        }
        if (STRING_NIL_CHECK(data[@"city"])) {
            _city = data[@"city"];
        }
        if (STRING_NIL_CHECK(data[@"district"])) {
            _district = data[@"district"];
        }
        if (STRING_NIL_CHECK(data[@"industry"])) {
            _industry = data[@"industry"];
        }
        if (STRING_NIL_CHECK(data[@"industry2"])) {
            _industry2 = data[@"industry2"];
        }
        if (STRING_NIL_CHECK(data[@"province_name"])) {
            _province_name = data[@"province_name"];
        }
        if (STRING_NIL_CHECK(data[@"city_name"])) {
            _city_name = data[@"city_name"];
        }
        if (STRING_NIL_CHECK(data[@"district_name"])) {
            _district_name = data[@"district_name"];
        }
        if (STRING_NIL_CHECK(data[@"industry_name"])) {
            _industry_name = data[@"industry_name"];
        }
        if (STRING_NIL_CHECK(data[@"industry2_name"])) {
            _industry2_name = data[@"industry2_name"];
        }
        if (STRING_NIL_CHECK(data[@"store_name"])) {
            _store_name = data[@"store_name"];
        }
        if (STRING_NIL_CHECK(data[@"address"])) {
            _address = data[@"address"];
        }
        if (STRING_NIL_CHECK(data[@"biz_type"])) {
            _biz_type = data[@"biz_type"];
        }
        if (STRING_NIL_CHECK(data[@"bank"])) {
            _bank = data[@"bank"];
        }
        if (STRING_NIL_CHECK(data[@"bank_code"])) {
            _bank_code = data[@"bank_code"];
        }
        if (STRING_NIL_CHECK(data[@"bank_province"])) {
            _bank_province = data[@"bank_province"];
        }
        if (STRING_NIL_CHECK(data[@"bank_city"])) {
            _bank_city = data[@"bank_city"];
        }
        if (STRING_NIL_CHECK(data[@"bank_name"])) {
            _bank_name = data[@"bank_name"];
        }
        if (STRING_NIL_CHECK(data[@"bank_name2"])) {
            _bank_name2 = data[@"bank_name2"];
        }
        if (STRING_NIL_CHECK(data[@"bank_phone"])) {
            _bank_phone = data[@"bank_phone"];
        }
        if (STRING_NIL_CHECK(data[@"bank_type"])) {
            _bank_type = data[@"bank_type"];
        }
        if (STRING_NIL_CHECK(data[@"id_type"])) {
            _id_type = data[@"id_type"];
        }
        if (STRING_NIL_CHECK(data[@"id_name"])) {
            _id_name = data[@"id_name"];
        }
        if (STRING_NIL_CHECK(data[@"id_code"])) {
            _id_code = data[@"id_code"];
        }
        if (STRING_NIL_CHECK(data[@"license_code"])) {
            _license_code = data[@"license_code"];
        }
        if (NUMBER_NIL_CHECK(data[@"license_start"])) {
            _license_start = [data[@"license_start"] longValue];
        }
        if (NUMBER_NIL_CHECK(data[@"license_end"])) {
            _license_end = [data[@"license_end"] longValue];
        }
        if (STRING_NIL_CHECK(data[@"photo1"])) {
            _photo1 = data[@"photo1"];
        }
        if (STRING_NIL_CHECK(data[@"photo2"])) {
            _photo2 = data[@"photo2"];
        }
        if (STRING_NIL_CHECK(data[@"photo3"])) {
            _photo3 = data[@"photo3"];
        }
        if (STRING_NIL_CHECK(data[@"photo4"])) {
            _photo4 = data[@"photo4"];
        }
        if (STRING_NIL_CHECK(data[@"photo5"])) {
            _photo5 = data[@"photo5"];
        }
        if (STRING_NIL_CHECK(data[@"photo6"])) {
            _photo6 = data[@"photo6"];
        }
        if (STRING_NIL_CHECK(data[@"photo7"])) {
            _photo7 = data[@"photo7"];
        }
        if (STRING_NIL_CHECK(data[@"photo8"])) {
            _photo8 = data[@"photo8"];
        }
        if (STRING_NIL_CHECK(data[@"photo9"])) {
            _photo9 = data[@"photo9"];
        }
        if (STRING_NIL_CHECK(data[@"photo10"])) {
            _photo10 = data[@"photo10"];
        }
        if (STRING_NIL_CHECK(data[@"photo11"])) {
            _photo11 = data[@"photo11"];
        }
        if (STRING_NIL_CHECK(data[@"photo12"])) {
            _photo12 = data[@"photo12"];
        }
        if (STRING_NIL_CHECK(data[@"photo13"])) {
            _photo13 = data[@"photo13"];
        }
        if (STRING_NIL_CHECK(data[@"photo14"])) {
            _photo14 = data[@"photo14"];
        }
        if (NUMBER_NIL_CHECK(data[@"modify"])) {
            _modify = [data[@"modify"] boolValue];
        }
        if (NUMBER_NIL_CHECK(data[@"admin"])) {
            _admin = [data[@"admin"] boolValue];
        }
        
        if (_admin == NO) {
            _userStatus = UserStatusLogin;
        }
        else {
            _userStatus = UserStatusForbidden;
        }
        
        if (NUMBER_NIL_CHECK(data[@"approve_status"])) {
            _authenticStatus = [data[@"approve_status"] intValue];
        }
        if (STRING_NIL_CHECK(data[@"code"])) {
            _code = data[@"code"];
        }
        if (NUMBER_NIL_CHECK(data[@"lat"])) {
            _lat = [data[@"lat"] doubleValue];
        }
        if (NUMBER_NIL_CHECK(data[@"lng"])) {
            _lng = [data[@"lng"] doubleValue];
        }
    }
    
    return self;
}

- (void)updateWithgetBizInfoApiData:(id)data
{
    if (STRING_NIL_CHECK(data[@"$id"])) {
        _userID = data[@"$id"];
    }
    if (STRING_NIL_CHECK(data[@"name"])) {
        _name = data[@"name"];
    }
    if (STRING_NIL_CHECK(data[@"name2"])) {
        _name2 = data[@"name2"];
    }
    if (STRING_NIL_CHECK(data[@"linkman"])) {
        _linkman = data[@"linkman"];
    }
    if (STRING_NIL_CHECK(data[@"phone"])) {
        _phone = data[@"phone"];
    }
    if (NUMBER_NIL_CHECK(data[@"per"])) {
        _per = [data[@"per"] floatValue];
    }
    if (STRING_NIL_CHECK(data[@"province"])) {
        _province = data[@"province"];
    }
    if (STRING_NIL_CHECK(data[@"city"])) {
        _city = data[@"city"];
    }
    if (STRING_NIL_CHECK(data[@"district"])) {
        _district = data[@"district"];
    }
    if (STRING_NIL_CHECK(data[@"industry"])) {
        _industry = data[@"industry"];
    }
    if (STRING_NIL_CHECK(data[@"industry2"])) {
        _industry2 = data[@"industry2"];
    }
    if (STRING_NIL_CHECK(data[@"province_name"])) {
        _province_name = data[@"province_name"];
    }
    if (STRING_NIL_CHECK(data[@"city_name"])) {
        _city_name = data[@"city_name"];
    }
    if (STRING_NIL_CHECK(data[@"district_name"])) {
        _district_name = data[@"district_name"];
    }
    if (STRING_NIL_CHECK(data[@"industry_name"])) {
        _industry_name = data[@"industry_name"];
    }
    if (STRING_NIL_CHECK(data[@"industry2_name"])) {
        _industry2_name = data[@"industry2_name"];
    }
    if (STRING_NIL_CHECK(data[@"store_name"])) {
        _store_name = data[@"store_name"];
    }
    if (STRING_NIL_CHECK(data[@"address"])) {
        _address = data[@"address"];
    }
    if (STRING_NIL_CHECK(data[@"biz_type"])) {
        _biz_type = data[@"biz_type"];
    }
    if (STRING_NIL_CHECK(data[@"bank"])) {
        _bank = data[@"bank"];
    }
    if (STRING_NIL_CHECK(data[@"bank_code"])) {
        _bank_code = data[@"bank_code"];
    }
    if (STRING_NIL_CHECK(data[@"bank_province"])) {
        _bank_province = data[@"bank_province"];
    }
    if (STRING_NIL_CHECK(data[@"bank_city"])) {
        _bank_city = data[@"bank_city"];
    }
    if (STRING_NIL_CHECK(data[@"bank_name"])) {
        _bank_name = data[@"bank_name"];
    }
    if (STRING_NIL_CHECK(data[@"bank_name2"])) {
        _bank_name2 = data[@"bank_name2"];
    }
    if (STRING_NIL_CHECK(data[@"bank_phone"])) {
        _bank_phone = data[@"bank_phone"];
    }
    if (STRING_NIL_CHECK(data[@"bank_type"])) {
        _bank_type = data[@"bank_type"];
    }
    if (STRING_NIL_CHECK(data[@"id_type"])) {
        _id_type = data[@"id_type"];
    }
    if (STRING_NIL_CHECK(data[@"id_name"])) {
        _id_name = data[@"id_name"];
    }
    if (STRING_NIL_CHECK(data[@"id_code"])) {
        _id_code = data[@"id_code"];
    }
    if (STRING_NIL_CHECK(data[@"license_code"])) {
        _license_code = data[@"license_code"];
    }
    if (NUMBER_NIL_CHECK(data[@"license_start"])) {
        _license_start = [data[@"license_start"] longValue];
    }
    if (NUMBER_NIL_CHECK(data[@"license_end"])) {
        _license_end = [data[@"license_end"] longValue];
    }
    if (STRING_NIL_CHECK(data[@"photo1"])) {
        _photo1 = data[@"photo1"];
    }
    if (STRING_NIL_CHECK(data[@"photo2"])) {
        _photo2 = data[@"photo2"];
    }
    if (STRING_NIL_CHECK(data[@"photo3"])) {
        _photo3 = data[@"photo3"];
    }
    if (STRING_NIL_CHECK(data[@"photo4"])) {
        _photo4 = data[@"photo4"];
    }
    if (STRING_NIL_CHECK(data[@"photo5"])) {
        _photo5 = data[@"photo5"];
    }
    if (STRING_NIL_CHECK(data[@"photo6"])) {
        _photo6 = data[@"photo6"];
    }
    if (STRING_NIL_CHECK(data[@"photo7"])) {
        _photo7 = data[@"photo7"];
    }
    if (STRING_NIL_CHECK(data[@"photo8"])) {
        _photo8 = data[@"photo8"];
    }
    if (STRING_NIL_CHECK(data[@"photo9"])) {
        _photo9 = data[@"photo9"];
    }
    if (STRING_NIL_CHECK(data[@"photo10"])) {
        _photo10 = data[@"photo10"];
    }
    if (STRING_NIL_CHECK(data[@"photo11"])) {
        _photo11 = data[@"photo11"];
    }
    if (STRING_NIL_CHECK(data[@"photo12"])) {
        _photo12 = data[@"photo12"];
    }
    if (STRING_NIL_CHECK(data[@"photo13"])) {
        _photo13 = data[@"photo13"];
    }
    if (STRING_NIL_CHECK(data[@"photo14"])) {
        _photo14 = data[@"photo14"];
    }
    if (NUMBER_NIL_CHECK(data[@"modify"])) {
        _modify = [data[@"modify"] boolValue];
    }
    if (NUMBER_NIL_CHECK(data[@"admin"])) {
        _admin = [data[@"admin"] boolValue];
    }
    
    if (NUMBER_NIL_CHECK(data[@"approve_status"])) {
        _authenticStatus = [data[@"approve_status"] intValue];
    }
    if (STRING_NIL_CHECK(data[@"code"])) {
        _code = data[@"code"];
    }
    if (NUMBER_NIL_CHECK(data[@"lat"])) {
        _lat = [data[@"lat"] doubleValue];
    }
    if (NUMBER_NIL_CHECK(data[@"lng"])) {
        _lng = [data[@"lng"] doubleValue];
    }
}

- (NSMutableDictionary *)userInfoDict
{
    NSMutableDictionary *infoDict = [NSMutableDictionary dictionary];
    
    if (self.userID) {
        infoDict[@"$id"] = self.userID;
    }
    if (self.name) {
        infoDict[@"name"] = self.name;
    }
    if (self.name2) {
        infoDict[@"name2"] = self.name2;
    }
    if (self.linkman) {
        infoDict[@"linkman"] = self.linkman;
    }
    if (self.phone) {
        infoDict[@"phone"] = self.phone;
    }
    if (self.per) {
        infoDict[@"per"] = @(self.per);
    }
    if (self.province) {
        infoDict[@"province"] = self.province;
    }
    if (self.city) {
        infoDict[@"city"] = self.city;
    }
    if (self.district) {
        infoDict[@"district"] = self.district;
    }
    if (self.industry) {
        infoDict[@"industry"] = self.industry;
    }
    if (self.industry2) {
        infoDict[@"industry2"] = self.industry2;
    }
    if (self.province_name) {
        infoDict[@"province_name"] = self.province_name;
    }
    if (self.city_name) {
        infoDict[@"city_name"] = self.city_name;
    }
    if (self.district_name) {
        infoDict[@"district_name"] = self.district_name;
    }
    if (self.industry_name) {
        infoDict[@"industry_name"] = self.industry_name;
    }
    if (self.industry2_name) {
        infoDict[@"industry2_name"] = self.industry2_name;
    }
    if (self.store_name) {
        infoDict[@"store_name"] = self.store_name;
    }
    if (self.address) {
        infoDict[@"address"] = self.address;
    }
    if (self.biz_type) {
        infoDict[@"biz_type"] = self.biz_type;
    }
    if (self.bank) {
        infoDict[@"bank"] = self.bank;
    }
    if (self.bank_code) {
        infoDict[@"bank_code"] = self.bank_code;
    }
    if (self.bank_province) {
        infoDict[@"bank_province"] = self.bank_province;
    }
    if (self.bank_city) {
        infoDict[@"bank_city"] = self.bank_city;
    }
    if (self.bank_province_code) {
        infoDict[@"bank_province_code"] = self.bank_province_code;
    }
    if (self.bank_city_code) {
        infoDict[@"bank_city_code"] = self.bank_city_code;
    }
    if (self.bank_name) {
        infoDict[@"bank_name"] = self.bank_name;
    }
    if (self.bank_name2) {
        infoDict[@"bank_name2"] = self.bank_name2;
    }
    if (self.bank_name_code) {
        infoDict[@"bank_name_code"] = self.bank_name_code;
    }
    if (self.bank_name2_code) {
        infoDict[@"bank_name2_code"] = self.bank_name2_code;
    }
    if (self.bank_phone) {
        infoDict[@"bank_phone"] = self.bank_phone;
    }
    if (self.bank_type) {
        infoDict[@"bank_type"] = self.bank_type;
        if ([self.bank_type isEqualToString:@"PUBLIC"]) {
            infoDict[@"bank_type_name"] = NSLocalizedString(@"资料-账号类型-对公",nil);
        }
        else if ([self.bank_type isEqualToString:@"PRIVATE"]) {
            infoDict[@"bank_type_name"] = NSLocalizedString(@"资料-账号类型-对私",nil);
        }
    }
    if (self.id_type) {
        infoDict[@"id_type"] = self.id_type;
    }
    if (self.id_name) {
        infoDict[@"id_name"] = self.id_name;
    }
    if (self.id_code) {
        infoDict[@"id_code"] = self.id_code;

    }
    if (self.license_code) {
        infoDict[@"license_code"] = self.license_code;
    }
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    if (self.license_start) {
        infoDict[@"license_start"] = @(self.license_start);
        infoDict[@"license_start_date"] =[fmt stringFromDate:[NSDate dateWithTimeIntervalSince1970:self.license_start/1000]];
    }
    if (self.license_end) {
        infoDict[@"license_end"] = @(self.license_end);
        infoDict[@"license_end_date"] =[fmt stringFromDate:[NSDate dateWithTimeIntervalSince1970:self.license_end/1000]];
    }
    if (self.photo1) {
        infoDict[@"photo1"] = self.photo1;
    }
    if (self.photo2) {
        infoDict[@"photo2"] = self.photo2;
    }
    if (self.photo3) {
        infoDict[@"photo3"] = self.photo3;
    }
    if (self.photo5) {
        infoDict[@"photo5"] = self.photo5;
    }
    if (self.photo6) {
        infoDict[@"photo6"] = self.photo6;
    }
    if (self.photo7) {
        infoDict[@"photo7"] = self.photo7;
    }
    if (self.photo8) {
        infoDict[@"photo8"] = self.photo8;
    }
    if (self.photo9) {
        infoDict[@"photo9"] = self.photo9;
    }
    if (self.photo10) {
        infoDict[@"photo10"] = self.photo10;
    }
    if (self.photo11) {
        infoDict[@"photo11"] = self.photo11;
    }
    if (self.photo12) {
        infoDict[@"photo12"] = self.photo12;
    }
    if (self.photo13) {
        infoDict[@"photo13"] = self.photo13;
    }
    if (self.photo14) {
        infoDict[@"photo14"] = self.photo14;
    }
    if (self.code) {
        infoDict[@"code"] = self.code;
    }
    if (self.lat) {
        infoDict[@"lat"] = @(self.lat);
    }
    if (self.lng ) {
        infoDict[@"lng"] = @(self.lng);
    }
    
    return infoDict;
}

@end
