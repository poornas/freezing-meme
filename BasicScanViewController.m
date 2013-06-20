//
//  BasicScanViewController.m
//  SimpleProj
//
//  Created by Poorna Krishnamoorthy on 6/19/13.
//  Copyright (c) 2013 Poorna Krishnamoorthy. All rights reserved.
//

#import "BasicScanViewController.h"
#import "FLLogging.h"
#import "FLECUSensor.h"

@interface BasicScanViewController(Private)
- (void) scan;
- (void) stopScan;
@end


#pragma mark -
@implementation BasicScanViewController

@synthesize statusLabel;
 
 
- (void) viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	//[self scan];
}

- (void) viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	[self stopScan];
}


  
- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


 
#pragma mark -
#pragma mark ScanToolDelegate Methods

- (void)scanDidStart:(FLScanTool*)scanTool {
	FLINFO(@"STARTED SCAN")
}

- (void)scanDidPause:(FLScanTool*)scanTool {
	FLINFO(@"PAUSED SCAN")
}

- (void)scanDidCancel:(FLScanTool*)scanTool {
	FLINFO(@"CANCELLED SCAN")
}

- (void)scanToolDidConnect:(FLScanTool*)scanTool {
	FLINFO(@"SCANTOOL CONNECTED")
}

- (void)scanToolDidDisconnect:(FLScanTool*)scanTool {
	FLINFO(@"SCANTOOL DISCONNECTED")
}


- (void)scanToolWillSleep:(FLScanTool*)scanTool {
	FLINFO(@"SCANTOOL SLEEP")
}

- (void)scanToolDidFailToInitialize:(FLScanTool*)scanTool {
	FLINFO(@"SCANTOOL INITIALIZATION FAILURE")
	FLDEBUG(@"scanTool.scanToolState: %@", scanTool.scanToolState)
	FLDEBUG(@"scanTool.supportedSensors count: %d", [scanTool.supportedSensors count])
}


- (void)scanToolDidInitialize:(FLScanTool*)scanTool {
	FLINFO(@"SCANTOOL INITIALIZATION COMPLETE")
	FLDEBUG(@"scanTool.scanToolState: %08X", scanTool.scanToolState)
	FLDEBUG(@"scanTool.supportedSensors count: %d", [scanTool.supportedSensors count])
	
	statusLabel.text			= @"Scanning...";
	
	[_scanTool setSensorScanTargets:[NSArray arrayWithObjects:
									 [NSNumber numberWithInt:0x0C], // Engine RPM
									 [NSNumber numberWithInt:0x0D], // Vehicle Speed
									 nil]];
	
	scanToolNameLabel.text	= _scanTool.scanToolName;
}


- (void)scanTool:(FLScanTool*)scanTool didSendCommand:(FLScanToolCommand*)command {
	FLINFO(@"DID SEND COMMAND")
}


- (void)scanTool:(FLScanTool*)scanTool didReceiveResponse:(NSArray*)responses {
	FLINFO(@"DID RECEIVE RESPONSE")
	
	FLECUSensor* sensor	=	nil;
	
	for (FLScanToolResponse* response in responses) {
		
		sensor			= [FLECUSensor sensorForPID:response.pid];
		[sensor setCurrentResponse:response];
		
		if (response.pid == 0x0C) {
			// Update RPM Display
			rpmLabel.text	= [NSString stringWithFormat:@"%@ %@", [sensor valueStringForMeasurement1:NO], [sensor imperialUnitString]];
			[rpmLabel setNeedsDisplay];
		}
		else if(response.pid == 0x0D) {
			// Update Speed Display
			speedLabel.text	= [NSString stringWithFormat:@"%@ %@", [sensor valueStringForMeasurement1:NO], [sensor imperialUnitString]];
			[speedLabel setNeedsDisplay];
		}
	}
	
}


- (void)scanTool:(FLScanTool*)scanTool didReceiveVoltage:(NSString*)voltage {
	FLTRACE_ENTRY
}


- (void)scanTool:(FLScanTool*)scanTool didTimeoutOnCommand:(FLScanToolCommand*)command {
	FLINFO(@"DID TIMEOUT")
}


- (void)scanTool:(FLScanTool*)scanTool didReceiveError:(NSError*)error {
	FLINFO(@"DID RECEIVE ERROR")
	FLNSERROR(error)
}

#pragma mark -
#pragma mark Private Methods

- (void) scan {
	
	statusLabel.text			= @"Initializing...";
	
	
	_scanTool					= [FLScanTool scanToolForDeviceType:kScanToolDeviceTypeELM327];
	
	_scanTool.useLocation		= YES;
	_scanTool.delegate			= self;
	
	if(_scanTool.isWifiScanTool ) {
		// These are the settings for the PLX Kiwi WiFI, your Scan Tool may
		// require different.
		[_scanTool setHost:@"192.168.0.10"];
		[_scanTool setPort:35000];
	}
	
	[_scanTool startScan];
}

- (void) stopScan {
	if(_scanTool.isWifiScanTool) {
		[_scanTool cancelScan];
	}
	
	_scanTool.sensorScanTargets		= nil;
	_scanTool.delegate				= nil;
}

@end

