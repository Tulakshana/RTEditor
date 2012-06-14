//
//  RTViewController.h
//  RTEditor
//
//  Created by Tulakshana on 12/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTViewController : UIViewController <UIWebViewDelegate>{
    IBOutlet UIWebView *wView;
    NSString *webText;
    UIView *customAccView1;
    

}

- (IBAction)done:(id)sender;
- (IBAction)undo:(id)sender;
- (IBAction)redo:(id)sender;

- (IBAction)boldAction:(id)sender;
- (IBAction)italicAction:(id)sender;
- (IBAction)underlineAction:(id)sender;
- (IBAction)olAction:(id)sender;
- (IBAction)ulAction:(id)sender;


@end
