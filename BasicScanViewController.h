//
//  BasicScanViewController.h
//  SimpleProj
//
//  Created by Poorna Krishnamoorthy on 6/19/13.
//  Copyright (c) 2013 Poorna Krishnamoorthy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLScanTool.h"


@interface BasicScanViewController : UIViewController <FLScanToolDelegate> {
	FLScanTool*			_scanTool;
	
	
	UILabel*			statusLabel;
	UILabel*			scanToolNameLabel;
	UILabel*			rpmLabel;
	UILabel*			speedLabel;
}

@property (nonatomic, retain) IBOutlet UILabel* statusLabel;
@property (nonatomic, retain) IBOutlet UILabel* scanToolNameLabel;
@property (nonatomic, retain) IBOutlet UILabel* rpmLabel;
@property (nonatomic, retain) IBOutlet UILabel* speedLabel;

@end
