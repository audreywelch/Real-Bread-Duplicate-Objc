//
//  ALWBakeriesTableViewController.m
//  real-bread-duplicate-objc-test
//
//  Created by Audrey Welch on 6/6/20.
//  Copyright © 2020 Audrey Welch. All rights reserved.
//

#import "ALWBakeriesTableViewController.h"
#import "ALWBakeryController.h"
#import "ALWBakeryTableViewCell.h"
#import "ALWDetailViewController.h"

@interface ALWBakeriesTableViewController () <UISearchBarDelegate>

@property (nonatomic, readonly) ALWBakeryController *bakeryController;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation ALWBakeriesTableViewController {
    
    // IVars
    NSMutableArray *filteredBakeries; // This should be an internal property, not a bare ivar.
    BOOL isFiltered; // Likely should also be a property, but if it *is* an ivar, should be prefixed with an underscore (_isFiltered).
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Instantiate bakery controller and fetch the bakeries
    // Use property accessor here, ie. self.bakeryController = ...;, as well as on the next line.
    _bakeryController = [[ALWBakeryController alloc] init];
    [_bakeryController fetchBakeriesWithCompletionBlock:^(NSArray<ALWBakery *> * _Nullable bakeries, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error fetching quakes: %@", error);
            return;
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
        // Otherwise, we have a list of bakeries
        NSLog(@"Bakeries: %ld", bakeries.count);
        
        //self.bakeryController.bakeries = bakeries;
        
    }];
    
    isFiltered = false;

    // Good. Your other option would be fine too. Neither is more correct than the other, just different ways of doing the same thing.
    [[self searchBar] setDelegate:self]; //ANOTHER OPTION: self.searchBar.delegate = self;
}

// Lazy Property (getter)
//- (ALWBakeryController *)bakeryController {
//    // if true, initialize it
//    if (!_bakeryController) { // if _tipController != nil
//        _bakeryController = [[ALWBakeryController alloc] init];
//    }
//
//    // return instance variable/object
//    return _bakeryController;
//}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (isFiltered) {
        return filteredBakeries.count;
    }
    
    return [self.bakeryController numberOfBakeries];
    // Nothing wrong with the below. Not necessarily any reason to expose a separate numberOfBakeries property
    //return self.bakeryController.bakeries.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ALWBakeryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bakeryCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    if (isFiltered) {
        
        ALWBakery *bakery = filteredBakeries[indexPath.row];
        cell.bakery = bakery;
        
    } else {

        // Need to fix this warning. It's happening because -bakeryAt: takes an int, not an NSInteger like it should
        ALWBakery *bakery = [self.bakeryController bakeryAt:indexPath.row];
        cell.bakery = bakery;
    }
 
    // Cell sets itself up
    [cell updateViews];
    
    return cell;
}

// Tell the delegate that the user changed the search text
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if (searchText.length == 0) {
        isFiltered = false;

        // Tell first responder to resign its first responder status
        [self.searchBar endEditing:YES];
    } else {
        isFiltered = true;

        filteredBakeries = [[NSMutableArray alloc] init];

        for (ALWBakery *bakery in self.bakeryController.bakeries) {

            // Returns location and length of first occurrence of a match in characters or NSNotFound
            NSRange range = [bakery.name rangeOfString:searchText options:NSCaseInsensitiveSearch];

            if (range.location != NSNotFound) {
                [filteredBakeries addObject:bakery];
            }
        }

    }

    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // Get the new view controller using [segue destinationViewController].
    if ([segue.identifier isEqual:@"showDetailView"]) {
        ALWDetailViewController *vc = segue.destinationViewController;
        
        NSIndexPath *selectedRow = self.tableView.indexPathForSelectedRow;

        // If what returns nil?
        // If this returns nil, I want to do this
        NSInteger row = selectedRow.row;

        // I'd write the below with a ternary. Saves lots of lines of code.
        // vc.bakery = isFiltered ? filteredBakeries[row] : self.bakeryController.bakeries[row];

        // Pass the selected object to the new view controller.
        if (isFiltered) {

            // No reason not to do the below in a single line.
            ALWBakery *bakery = [filteredBakeries objectAtIndex:row];
            vc.bakery = bakery;
            
        } else {
            
            ALWBakery *bakery = [self.bakeryController.bakeries objectAtIndex:row];
            vc.bakery = bakery;
        }
        
        vc.bakeryController = self.bakeryController;
        
    }
}




@end
