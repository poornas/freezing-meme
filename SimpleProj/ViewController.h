//
//  ViewController.h
//  SimpleProj
//
//  Created by Poorna Krishnamoorthy on 6/19/13.
//  Copyright (c) 2013 Poorna Krishnamoorthy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"

#define IS_WIDESCREEN ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

@interface ViewController : UIViewController

@property (strong, readonly, nonatomic) RESideMenu *sideMenu;

@end
