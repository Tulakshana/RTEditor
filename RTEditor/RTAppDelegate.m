//
//  RTAppDelegate.m
//  RTEditor
//
//  Created by Tulakshana on 12/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RTAppDelegate.h"

#import "RTViewController.h"

@implementation RTAppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;

- (void)dealloc
{
    [_window release];
    [_viewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.viewController = [[[RTViewController alloc] initWithNibName:@"RTViewController" bundle:nil] autorelease];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    
//    NSString *html = @"<span class='Apple-style-span' style='color: rgb(238, 238, 238); font-family: Arial, Helvetica, sans-serif; font-size: 12px; line-height: 17px; -webkit-tap-highlight-color: rgba(26, 26, 26, 0.296875); -webkit-composition-fill-color: rgba(175, 192, 227, 0.230469); -webkit-composition-frame-color: rgba(77, 128, 180, 0.230469); -webkit-text-size-adjust: auto; '>Welcome to EUGEIN, your partner in IT solutions. Thank you for your interest in us. We hope our site will give you an insight into what we do, who we are and how we use our knowledge and experience to ensure your company stands out from the crowd. We work with a range of companies small and large. We look forward to assisting you in your next project.</span><div><span class='Apple-style-span' style='color: rgb(238, 238, 238); font-family: Arial, Helvetica, sans-serif; font-size: 12px; line-height: 17px; -webkit-tap-highlight-color: rgba(26, 26, 26, 0.296875); -webkit-composition-fill-color: rgba(175, 192, 227, 0.230469); -webkit-composition-frame-color: rgba(77, 128, 180, 0.230469); -webkit-text-size-adjust: auto; '><br></span></div><span class='Apple-style-span' style='color: rgb(238, 238, 238); font-family: Arial, Helvetica, sans-serif; font-size: 12px; line-height: 17px; -webkit-tap-highlight-color: rgba(26, 26, 26, 0.296875); -webkit-composition-fill-color: rgba(175, 192, 227, 0.230469); -webkit-composition-frame-color: rgba(77, 128, 180, 0.230469); -webkit-text-size-adjust: auto; '>Welcome to EUGEIN, your partner in IT solutions. Thank you for your interest in us. We hope our site will give you an insight into what we do, who we are and how we use our knowledge and experience to ensure your company stands out from the crowd. We work with a range of companies small and large. We look forward to assisting you in your next project.</span>";
//    NSLog(@"%@",[self flattenHTML:html trimWhiteSpace:TRUE]);
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    UIPasteboard* pasteboard = [UIPasteboard generalPasteboard];
    NSString* rawString = pasteboard.string;
    NSLog(@"rawString %@",rawString);
    NSString* formattedString =  [NSString stringWithFormat:@"%@",[self flattenHTML:rawString trimWhiteSpace:FALSE]];// do something fun with rawString here
    pasteboard.string = formattedString;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (NSString *)flattenHTML:(NSString *)html trimWhiteSpace:(BOOL)trim {
    //http://mohrt.blogspot.com/2009/03/stripping-html-with-objective-ccocoa.html
    
    NSScanner *theScanner;
    NSString *text = nil;
    
    theScanner = [NSScanner scannerWithString:html];
    
    while ([theScanner isAtEnd] == NO) {
        
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
        
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        html = [html stringByReplacingOccurrencesOfString:
                [ NSString stringWithFormat:@"%@>", text]
                                               withString:@" "];
        
    } // while //
    
    // trim off whitespace
    return trim ? [html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] : html;
    
}

@end
