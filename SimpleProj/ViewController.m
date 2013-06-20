//
//  ViewController.m
//  SimpleProj
//
//  Created by Poorna Krishnamoorthy on 6/19/13.
//  Copyright (c) 2013 Poorna Krishnamoorthy. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import "AppDelegate.h"
#import "BasicScanViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Menu";
    self.view.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"CarScan" style:UIBarButtonItemStyleBordered target:self action:@selector(showMenu)];
}

#pragma mark -
#pragma mark Button actions

- (void)showMenu
{
    SecondViewController *secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SecondVC"];
    RESideMenuItem *connectItem = [[RESideMenuItem alloc] initWithTitle:@"Car connect" action:^(RESideMenu *menu, RESideMenuItem *item) {
      
        [menu hide];
      //  SecondViewController *secondViewController = [[SecondViewController alloc] init];
        secondViewController.title = item.title;
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:secondViewController];
        [menu setRootViewController:navigationController];
    }];
    RESideMenuItem *homeItem = [[RESideMenuItem alloc] initWithTitle:@"Home" action:^(RESideMenu *menu, RESideMenuItem *item) {
        [menu hide];
     //   SecondViewController *secondViewController = [[SecondViewController alloc] init];
        secondViewController.title = item.title;
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:secondViewController];
        [menu setRootViewController:navigationController];
    }];
    RESideMenuItem *logoutItem = [[RESideMenuItem alloc] initWithTitle:@"Logout" action:^(RESideMenu *menu, RESideMenuItem *item) {
        [menu hide];
    //    SecondViewController *secondViewController = [[SecondViewController alloc] init];
        secondViewController.title = item.title;
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:secondViewController];
        [menu setRootViewController:navigationController];
    }];
         
    _sideMenu = [[RESideMenu alloc] initWithItems:@[connectItem, homeItem, logoutItem ]];
    _sideMenu.verticalOffset = IS_WIDESCREEN ? 110 : 76;
    _sideMenu.hideStatusBarArea = [AppDelegate OSVersion] < 7;
    [_sideMenu show];
}

@end
