//
//  ALWBakery.h
//  real-bread-duplicate-objc-test
//
//  Created by Audrey Welch on 6/6/20.
//  Copyright © 2020 Audrey Welch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ALWBakery : NSObject

@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly, copy) NSString *address;

@property (nonatomic, readonly, copy) NSString *placeID;
@property (nonatomic, readonly, copy) NSString *info;
@property (nonatomic, readonly, copy) NSString *phone;
@property (nonatomic, readonly, copy) NSString *website;
@property (nonatomic) CLLocationDegrees latitude;
@property (nonatomic) CLLocationDegrees longitude;
@property (nonatomic, readonly) CLLocation *location;
@property (nonatomic, readonly, copy) NSArray *hours;

@property (nonatomic, readonly, getter=isMilledInHouse) BOOL milledInHouse;
@property (nonatomic, readonly, getter=isOrganic) BOOL organic;
@property (nonatomic, readonly) BOOL sellsLoaves;
@property (nonatomic, readonly) BOOL servesFood;

@property (nonatomic, nullable, copy) NSArray<UIImage *> *photos;

- (instancetype)initWithName:(NSString *)name
                     address:(NSString *)address
                     placeID:(NSString *)placeID
                        info:(NSString *)info
                       phone:(NSString *)phone
                     website:(NSString *)website
                         latitude:(CLLocationDegrees)latitude
                         longitude:(CLLocationDegrees)longitude
                       hours:(NSArray *)hours
               milledInHouse:(BOOL)milledInHouse
                     organic:(BOOL)organic
                 sellsLoaves:(BOOL)sellsLoaves
                  servesFood:(BOOL)servesFood
                      photos:(NSArray<UIImage *> *)photos;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
