//
//  ALWBakery.m
//  real-bread-duplicate-objc-test
//
//  Created by Audrey Welch on 6/6/20.
//  Copyright © 2020 Audrey Welch. All rights reserved.
//

#import "ALWBakery.h"

@implementation ALWBakery

// Getters
- (CLLocation *)location {
    return [[CLLocation alloc] initWithLatitude:self.lat.doubleValue longitude:self.lng.doubleValue];
}

- (NSArray *)photos {
    return [NSArray arrayWithObjects:[UIImage imageNamed:@"bread1"], [UIImage imageNamed:@"bread2"], [UIImage imageNamed:@"bread3"], [UIImage imageNamed:@"bread4"], [UIImage imageNamed:@"bread5"], [UIImage imageNamed:@"bread6"], [UIImage imageNamed:@"bread7"], [UIImage imageNamed:@"bread8"], nil];
}

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
                      photos:(NSArray<UIImage *> *)photos {
    
    self = [super init];
    
    if (self) {
        _name = [name copy];
        _address = [address copy];
        _placeID = [placeID copy];
        _info = [info copy];
        _phone = [phone copy];
        _website = [website copy];
        _lat = lat;
        _lng = lng;
        _hours = [hours copy];
        _milledInHouse = milledInHouse;
        _organic = organic;
        _sellsLoaves = sellsLoaves;
        _servesFood = servesFood;
        _photos = [photos copy];
    }
    return self;
    
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    NSString *name = dictionary[@"name"];
    NSString *address = dictionary[@"formattedAddress"];
    NSString *placeID = dictionary[@"placeID"];
    NSString *info = dictionary[@"info"];
    NSString *phone = dictionary[@"internationalPhoneNumber"];
    NSString *website = dictionary[@"website"];
    NSNumber *lat = dictionary[@"lat"];
    NSNumber *lng = dictionary[@"lng"];
    NSArray *hours = dictionary[@"weekdayText"];
    BOOL milledInHouse = dictionary[@"milledInHouse"];
    BOOL organic = dictionary[@"organic"];
    BOOL sellsLoaves = dictionary[@"sellsLoaves"];
    BOOL servesFood = dictionary[@"servesFood"];
    
    //NSLog(@"bakery milledInHouse is: %@", milledInHouse ? @"YES" : @"NO");
    
    //NSArray *photos = dictionary[@"photos"];
    
    if (name && placeID && address) {

        // Can just return this directly, no need to assign to self.
        self = [self initWithName:name
                          address:address
                          placeID:placeID
                             info:info
                            phone:phone
                          website:website
                              lat:lat
                              lng:lng
                            hours:hours
                    milledInHouse:milledInHouse
                          organic:organic
                      sellsLoaves:sellsLoaves
                       servesFood:servesFood
                           photos:_photos];
    } else {
        // Return nil
        // I would check for this and return nil early, avoiding an else clause altogether. More like you'd do guard in Swift
        NSLog(@"Error: Invalid object, unable to parse, %@", dictionary);
        return nil;
    }
    
    return self;
}

// How I would write the above:
/*
- (instancetype)initWithDictionary:(NSDictionary *)dictionary {

    NSString *name = dictionary[@"name"];
    NSString *address = dictionary[@"formattedAddress"];
    NSString *placeID = dictionary[@"placeID"];
    NSString *info = dictionary[@"info"];
    NSString *phone = dictionary[@"internationalPhoneNumber"];
    NSString *website = dictionary[@"website"];
    NSNumber *lat = dictionary[@"lat"];
    NSNumber *lng = dictionary[@"lng"];
    NSArray *hours = dictionary[@"weekdayText"];
    BOOL milledInHouse = dictionary[@"milledInHouse"];
    BOOL organic = dictionary[@"organic"];
    BOOL sellsLoaves = dictionary[@"sellsLoaves"];
    BOOL servesFood = dictionary[@"servesFood"];

    //NSLog(@"bakery milledInHouse is: %@", milledInHouse ? @"YES" : @"NO");

    //NSArray *photos = dictionary[@"photos"];

    if (!name || !placeID || !address) {
        NSLog(@"Error: Invalid object, unable to parse, %@", dictionary);
        return nil;
    }

    return [self initWithName:name
                      address:address
                      placeID:placeID
                         info:info
                        phone:phone
                      website:website
                          lat:lat
                          lng:lng
                        hours:hours
                milledInHouse:milledInHouse
                      organic:organic
                  sellsLoaves:sellsLoaves
                   servesFood:servesFood
                       photos:_photos];
}
*/

@end
