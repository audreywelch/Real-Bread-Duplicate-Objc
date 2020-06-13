//
//  ALWBakeryController.m
//  real-bread-duplicate-objc-test
//
//  Created by Audrey Welch on 6/6/20.
//  Copyright © 2020 Audrey Welch. All rights reserved.
//

#import "ALWBakeryController.h"
#import "ALWBakery.h"

NSString *baseURL = @"insert-firebase-url-here";

@implementation ALWBakeryController

// Override default NSObject initializer (don't need to re-declare in .h file)
- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (NSInteger)numberOfBakeries {
    
    return _bakeries.count;
}

- (ALWBakery *)bakeryAt:(int)indexPath {
    
    return [self.bakeries objectAtIndex: indexPath];
}

- (NSData *)JSONFromFile {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"bakeries" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return data;
}

- (void)fetchBakeriesWithCompletionBlock:(ALWBakeryCompletion)completionBlock {
    
    // Decode data from JSON File, rather than from Firebase
    NSData *dataFromFile = [self JSONFromFile];
    
    // NSError is used instead of do-catch blocks in obj-c
    // Give the message the error and the address of the error
    NSError *jsonDecodingError = nil;
    // let decodedObjectDictionaries: [[String: String]] - firebase is array of dictionaries
    NSDictionary *decodedObjectDictionaries = [NSJSONSerialization JSONObjectWithData:dataFromFile options:0 error:&jsonDecodingError];
    
    if (jsonDecodingError != nil) {
        NSLog(@"Erorr decoding json: %@", jsonDecodingError);
        completionBlock(nil, jsonDecodingError);
        return;
    }
        
    // At this point, check to make sure we have an array of dictionaries
    if ([decodedObjectDictionaries isKindOfClass:[NSDictionary class]] == NO) {
        NSLog(@"JSON result is not an dictionary");
        completionBlock(nil, nil);
        return;
    }
    
    NSMutableArray *bakeryResults = [[NSMutableArray alloc] init];
    
    // Loop through all of the dictionaries
    for (NSDictionary *dictionary in decodedObjectDictionaries) {
        
        // Use each placeID as the key to get inside the dictionary
        NSDictionary *bakeryResult = decodedObjectDictionaries[dictionary];
        //NSLog(@"bakery result: %@", bakeryResult);
        
        // Initialize bakery objects
        ALWBakery *bakery = [[ALWBakery alloc] initWithDictionary:bakeryResult];
        
        // Add them to the array
        if (bakery != nil) { [bakeryResults addObject:bakery]; }
    }

    // Assign data to stored array
    self.bakeries = bakeryResults;
    completionBlock(bakeryResults, nil);
    
    // THE FOLLOWING WAS USED FOR FETCHING JSON FROM FIREBASE
    // -------------------------------------------------------------
    
//    // Data task to fetch data
//    NSURL *url = [NSURL URLWithString:baseURL];
//
//    // Data task created from URL
//    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//
//        // Sanity check - move print statement inside the data task to know that we did invoke the data task
//        NSLog(@"url: %@", url);
//
//        // Check for an error
//        if (error != nil) {
//            NSLog(@"Error fetching bakery data: %@", error);
//            completionBlock(nil, error);
//            return;
//        }
//
//        // Check for absence of data, absence of error
//        if (!data) {
//            NSLog(@"No error, but missing data"); // FIXME: - Create an NSError to report here
//            completionBlock(nil, nil);
//            return;
//        }
//
//        // Decode data
//        //NSData *dataFromFile = [self JSONFromFile];
//
//        // NSError is used instead of do-catch blocks in obj-c
//        // Give the message the error and the address of the error
//        NSError *jsonDecodingError = nil;
//        // let decodedObjectDictionaries: [[String: String]] - firebase is array of dictionaries
//        NSDictionary *decodedObjectDictionaries = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonDecodingError];
//
//        if (jsonDecodingError != nil) {
//            NSLog(@"Erorr decoding json: %@", jsonDecodingError);
//            completionBlock(nil, jsonDecodingError);
//            return;
//        }
//
//        //NSLog(@"%@", decodedObjectDictionaries);
//
//        // At this point, check to make sure we have an array of dictionaries
//        if ([decodedObjectDictionaries isKindOfClass:[NSDictionary class]] == NO) {
//            NSLog(@"JSON result is not an dictionary");
//            completionBlock(nil, nil);
//            return;
//        }
//
//        //NSLog(@"decodedObjectDictionaries: %@", decodedObjectDictionaries);
//
//        NSMutableArray *bakeryResults = [[NSMutableArray alloc] init];
//
//        // Loop through all of the dictionaries
//        for (NSDictionary *dictionary in decodedObjectDictionaries) {
//
//            // Use each placeID as the key to get inside the dictionary
//            NSDictionary *bakeryResult = decodedObjectDictionaries[dictionary];
//            //NSLog(@"bakery result: %@", bakeryResult);
//
//            // Initialize bakery objects
//            ALWBakery *bakery = [[ALWBakery alloc] initWithDictionary:bakeryResult];
//
//            // Add them to the array
//            if (bakery != nil) { [bakeryResults addObject:bakery]; }
//        }
//
//        // Assign data to stored array
//        self.bakeries = bakeryResults;
//        completionBlock(bakeryResults, nil);
//
//    }];
//
//    [dataTask resume];
    
}


@end
