//
//  SecondViewController.m
//  SimpleProj
//
//  Created by Poorna Krishnamoorthy on 6/19/13.
//  Copyright (c) 2013 Poorna Krishnamoorthy. All rights reserved.
//

#import "SecondViewController.h"
#import "ViewController.h"
#import "AppDelegate.h"
#import "BasicScanViewController.h"
@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.902 green:0.859 blue:0.487 alpha:1.000];
    if ([self.title isEqual:@"Car connect"]) {
        BasicScanViewController *bsvc = [self.storyboard instantiateViewControllerWithIdentifier:@"BasicScanVC"];
        UILabel *statusLabel = [[UILabel alloc] init];
        [statusLabel setText:@"Initializing..."];
        statusLabel.backgroundColor = [UIColor redColor];
        statusLabel.textColor = [UIColor whiteColor];
        [bsvc setStatusLabel:statusLabel];
        
        [self.navigationController pushViewController:bsvc animated:NO];
    }
        
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStyleBordered target:self action:@selector(showMenu)];
}
#pragma mark -
#pragma mark Button actions

- (void)showMenu
{
    RESideMenuItem *homeItem = [[RESideMenuItem alloc] initWithTitle:@"Go Back" action:^(RESideMenu *menu, RESideMenuItem *item) {
        [menu hide];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
        [menu setRootViewController:navigationController];
    }];
    
    _sideMenu = [[RESideMenu alloc] initWithItems:@[homeItem]];
    _sideMenu.verticalOffset = IS_WIDESCREEN ? 250 : 230;
    _sideMenu.hideStatusBarArea = [AppDelegate OSVersion] < 7;
    [_sideMenu show];
}


@end
