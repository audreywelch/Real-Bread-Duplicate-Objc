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

@property (nonatomic) ALWBakeryController *bakeryController;
@property (nonatomic, copy) NSMutableArray *filteredBakeries;
@property (nonatomic, getter=isFiltered) BOOL filtered;

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation ALWBakeriesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Instantiate bakery controller and fetch the bakeries
    self.bakeryController = [[ALWBakeryController alloc] init];
    [self.bakeryController fetchBakeriesWithCompletionBlock:^(NSArray<ALWBakery *> * _Nullable bakeries, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error fetching quakes: %@", error);
            return;
        } else {
            self.bakeryController.bakeries = bakeries;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
        // Otherwise, we have a list of bakeries
        NSLog(@"Bakeries: %ld", bakeries.count);
    }];
    
    _filtered = false;

    [[self searchBar] setDelegate:self];
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

    if (_filtered) {
        return _filteredBakeries.count;
    }
    
    return [self.bakeryController numberOfBakeries];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ALWBakeryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bakeryCell" forIndexPath:indexPath];
    
    if (_filtered) {
        
        ALWBakery *bakery = _filteredBakeries[indexPath.row];
        cell.bakery = bakery;
        
    } else {

        ALWBakery *bakery = [self.bakeryController bakeryAtIndex:indexPath.row];
        cell.bakery = bakery;
    }
    
    return cell;
}

// Tell the delegate that the user changed the search text
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if (searchText.length == 0) {
        _filtered = false;

        // Tell first responder to resign its first responder status
        [self.searchBar endEditing:YES];
    } else {
        _filtered = true;

        _filteredBakeries = [[NSMutableArray alloc] init];

        for (ALWBakery *bakery in self.bakeryController.bakeries) {

            // Returns location and length of first occurrence of a match in characters or NSNotFound
            NSRange range = [bakery.name rangeOfString:searchText options:NSCaseInsensitiveSearch];

            if (range.location != NSNotFound) {
                [_filteredBakeries addObject:bakery];
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

        NSInteger row = selectedRow.row;
        
        // Pass the selected object to the new view controller.
        vc.bakery = _filtered ? _filteredBakeries[row] : self.bakeryController.bakeries[row];
        
        vc.bakeryController = self.bakeryController;
    }
}

@end
