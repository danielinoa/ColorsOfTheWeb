//
//  PalettesViewController.m
//  ColorsOfTheWeb
//
//  Created by Daniel Inoa Llenas on 9/22/15.
//  Copyright © 2015 Daniel Inoa Llenas. All rights reserved.
//

#import "PalettesViewController.h"
#import "DetailPaletteViewController.h"
#import "AFNetworking.h"

@implementation PalettesViewController{
    NSMutableArray *palettesArray;
}

- (void)viewDidLoad{
    AFHTTPRequestOperationManager * manager = [[AFHTTPRequestOperationManager alloc] init];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager GET:@"http://www.colourlovers.com/api/palettes"
      parameters:@{@"format": @"json"}
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             palettesArray = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
             if(palettesArray && palettesArray.count > 0) [self.tableView reloadData];
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error);
         }
     ];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tableViewCell"];
    [cell.textLabel setText: [[palettesArray objectAtIndex:indexPath.row] objectForKey:@"title"]];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetailPaletteViewController *dpvc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailPaletteViewController"];
    dpvc.colorsArray = [[palettesArray objectAtIndex:indexPath.row] objectForKey:@"colors"];
    dpvc.paletteTitle = [[palettesArray objectAtIndex:indexPath.row] objectForKey:@"title"];
    [self.navigationController pushViewController:dpvc animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    return (palettesArray) ? palettesArray.count : 0;
}

@end
