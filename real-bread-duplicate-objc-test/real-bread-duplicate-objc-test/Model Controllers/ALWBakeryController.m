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

// You don't need to include this if you're not actually doing anything custom
// Override default NSObject initializer (don't need to re-declare in .h file)
- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (NSInteger)numberOfBakeries {

    // Don't access the instance variable directly. Just do return self.bakeries.count
    return _bakeries.count;
}

// See header file, but the argument should not be called indexPath, should just be index.
- (ALWBakery *)bakeryAt:(int)indexPath {
    // Not a big deal, but I'd use subscript syntax: self.bakeries[index]
    return [self.bakeries objectAtIndex: indexPath];
}

// Now that I see what this does, it should be private (ie. not declared in the .h).
// I'd name it -JSONDataFromBakeriesFile
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
    // This is fine, but I'd call it just plain error, for whatever that's worth. What you've got is *not* wrong or bad, though.
    NSError *jsonDecodingError = nil;
    // let decodedObjectDictionaries: [[String: String]] - firebase is array of dictionaries
    NSDictionary *decodedObjectDictionaries = [NSJSONSerialization JSONObjectWithData:dataFromFile options:0 error:&jsonDecodingError];

// You should never check the error itself for nil. Rather, you need to check the return value of the error-throwing method (decodedObjectDictionaries) in this case. It is perfectly valid for a method that did not fail to nevertheless return a non-nil error.
    if (jsonDecodingError != nil) {
        NSLog(@"Erorr decoding json: %@", jsonDecodingError);
        completionBlock(nil, jsonDecodingError);
        return;
    }

    // At this point, check to make sure we have an array of dictionaries
    // Good that you're doing this check.
    // I'd do if (![decodedObjectDictionaries isKindOfClass:[NSDictionary class]]) instead of the explicit comparison to NO.
    // Here it's not a big deal, but you *definitely* don't want to explicitly compared BOOLs with YES, as that can give you
    // false negatives.
    if ([decodedObjectDictionaries isKindOfClass:[NSDictionary class]] == NO) {
        NSLog(@"JSON result is not an dictionary");
        completionBlock(nil, nil);
        return;
    }
    
    NSMutableArray *bakeryResults = [[NSMutableArray alloc] init];
    
    // Loop through all of the dictionaries
    // This is hard to understand. Are the *keys* of decodedObjectDictionaries also dictionaries?
    // I'm guessing they're actually strings, so your loop object type should be NSString, and should
    // be called something else (key? identifier? whatever the keys actually are)
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
