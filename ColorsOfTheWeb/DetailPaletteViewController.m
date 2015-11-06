//
//  DetailPaletteViewController.m
//  ColorsOfTheWeb
//
//  Created by Daniel Inoa Llenas on 9/22/15.
//  Copyright © 2015 Daniel Inoa Llenas. All rights reserved.
//

#import "DetailPaletteViewController.h"
#import "HexColors.h"

@implementation DetailPaletteViewController

@synthesize colorsArray, paletteTitle;

- (void) viewDidLoad{
    self.title = paletteTitle;
    [self generateMosaicOn:self.view with:colorsArray];
}

- (void) generateMosaicOn: (UIView*)view with:(NSMutableArray *) hexColorArray{
    float x = 0;
    float y = 0;
    float w = view.frame.size.width;
    float h = view.frame.size.height;
    BOOL alt =  arc4random_uniform(2);
    CGRect viewRect;
    if (hexColorArray.count > 0) {
        for (int i=0; i<hexColorArray.count - 1; i++) {
            if(alt){
                viewRect = CGRectMake(x, y, w, h/2);
                h = h/2;
                y += h;
            } else {
                viewRect = CGRectMake(x, y, w/2, h);
                w = w/2;
                x += w;
            }
            //alt = arc4random_uniform(2); // or alternated with: alt = !alt;
            alt = !alt;
            UIView *newView = [[UIView alloc] initWithFrame:viewRect];
            [newView setBackgroundColor:[UIColor colorWithHexString:[hexColorArray objectAtIndex:i]]];
            [view addSubview:newView];
        }
        viewRect = CGRectMake(x, y, w, h);
        UIView *newView = [[UIView alloc] initWithFrame:viewRect];
        [newView setBackgroundColor:[UIColor colorWithHexString:[hexColorArray objectAtIndex:hexColorArray.count - 1]]];
        [view addSubview:newView];
    }
}

@end










