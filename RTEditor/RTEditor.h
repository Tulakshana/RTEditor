//
//  RTEditor.h
//  RTEditor
//
//  Created by Tulakshana on 14/06/2012.
//  Copyright (c) 2012 Eugein. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTEditor : UIViewController<UIWebViewDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>{
    IBOutlet UIWebView *wView;
    NSString *webText;
    UIView *customAccView1;
    
    UIView *cameraProgressHolder;
    UIActivityIndicatorView *cameraProgress;
    
    NSString *selection;
}

- (IBAction)done:(id)sender;
- (IBAction)undo:(id)sender;
- (IBAction)redo:(id)sender;

- (IBAction)boldAction:(id)sender;
- (IBAction)italicAction:(id)sender;
- (IBAction)underlineAction:(id)sender;
- (IBAction)olAction:(id)sender;
- (IBAction)ulAction:(id)sender;
- (IBAction)imgAction:(id)sender;

@end
