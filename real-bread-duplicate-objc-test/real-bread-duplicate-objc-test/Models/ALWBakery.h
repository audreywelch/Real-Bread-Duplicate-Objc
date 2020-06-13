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
@property (nonatomic) NSNumber *lat; // Spell this all the way out (latitude). Does this need to be an NSNumber, or could it be a double or CLLocationDegrees?
@property (nonatomic) NSNumber *lng; // Spell this all the way out (longitude). Does this need to be an NSNumber, or could it be a double or CLLocationDegrees?
@property (nonatomic) CLLocation *location; // This should probably be readonly? Looks like it's always just computed from latitude and longitude
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
                         lat:(NSNumber *)lat
                         lng:(NSNumber *)lng
                       hours:(NSArray *)hours
               milledInHouse:(BOOL)milledInHouse
                     organic:(BOOL)organic
                 sellsLoaves:(BOOL)sellsLoaves
                  servesFood:(BOOL)servesFood
                      photos:(NSArray<UIImage *> *)photos;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
