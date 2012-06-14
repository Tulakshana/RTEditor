//
//  RTEditor.m
//  RTEditor
//
//  Created by Tulakshana on 14/06/2012.
//  Copyright (c) 2012 Eugein. All rights reserved.
//

#import "RTEditor.h"

@interface RTEditor ()

@end

@implementation RTEditor- (void)dealloc{
    customAccView1 = nil;
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSString *path = [[NSBundle mainBundle] pathForResource:@"editor" ofType:@"html"];
    NSLog(@"%@",path);
    //    [wView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:path]]];
    //    [wView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]]];
    webText = @"<html><head>    </head><body><div contentEditable = 'TRUE' id = 'editor' style='position:absolute;left:5px;top:5px; width:315px;height:103px;overflow:auto;'>test</div></body></html>";
    [wView loadHTMLString:webText baseURL:nil];
    
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    UIMenuItem *boldText = [[UIMenuItem alloc] initWithTitle: @"B" action: @selector(boldText)];
    UIMenuItem *italicText = [[UIMenuItem alloc] initWithTitle: @"I" action: @selector(italicText)];
    UIMenuItem *underlineText = [[UIMenuItem alloc] initWithTitle:@"U" action:@selector(underlineText)];
    UIMenuItem *removeFormatting = [[UIMenuItem alloc] initWithTitle:@"Tx" action:@selector(removeFormatting)];
    UIMenuItem *uList = [[UIMenuItem alloc] initWithTitle:@"ul" action:@selector(uList)];
    UIMenuItem *oList = [[UIMenuItem alloc] initWithTitle:@"ol" action:@selector(oList)];
    [menuController setMenuItems: [NSArray arrayWithObjects:boldText, italicText,underlineText,removeFormatting,uList,oList, nil]];
    [uList release];
    [oList release];
    [italicText release];
    [boldText release];
    [underlineText release];
    [removeFormatting release];
    
    
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name: UIKeyboardWillShowNotification object:nil];
    
    customAccView1 = nil;
    
    cameraProgress = nil;
    cameraProgressHolder = nil;
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
//}

- (BOOL) canPerformAction:(SEL)action withSender:(id)sender
{
    
    if (action == @selector(boldText)) {
        return YES;
    } else if (action == @selector(italicText)) {
        return YES;
    }else if (action == @selector(underlineText)) {
        return YES;
    }else if (action == @selector(removeFormatting)) {
        return YES;
    }else if (action == @selector(uList)) {
        return YES;
    }else if (action == @selector(oList)) {
        return YES;
    }
    
    return NO;
}

//https://developer.mozilla.org/en/Rich-Text_Editing_in_Mozilla

- (void)boldText {
    
    //    NSString *selection = [wView stringByEvaluatingJavaScriptFromString:@"window.getSelection().toString()"];
    //    NSLog(@"selected text %@",selection);
    
    //    [wView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.execCommand('insertHTML', false, '%@')", [NSString stringWithFormat:@"<strong>%@</strong>",selection]]];
    [wView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.execCommand('bold', false,null)"]];
    
}

- (void)italicText {
    
    //    NSString *selection = [wView stringByEvaluatingJavaScriptFromString:@"window.getSelection().toString()"];
    //    NSLog(@"selected text %@",selection);
    
    //    [wView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.execCommand('insertHTML', false, '%@')", [NSString stringWithFormat:@"<i>%@</i>",selection]]];
    [wView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.execCommand('italic', false,null)"]];
    
    
}

- (void)underlineText {
    
    //    NSString *selection = [wView stringByEvaluatingJavaScriptFromString:@"window.getSelection().toString()"];
    //    NSLog(@"selected text %@",selection);
    
    //    [wView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.execCommand('insertHTML', false, '%@')", [NSString stringWithFormat:@"<u>%@</u>",selection]]];
    [wView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.execCommand('underline', false,null)"]];
    
    
}



- (void)removeFormatting {
    
    //    NSString *selection = [wView stringByEvaluatingJavaScriptFromString:@"clearBold()"];
    //    NSLog(@"selected text %@",selection);
    
    //    NSString *selection = [wView stringByEvaluatingJavaScriptFromString:@"window.getSelection().toString()"];
    //    NSLog(@"selected text %@",selection);
    
    [wView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.execCommand('removeFormat', false, null)"]];
}

- (void)uList{
    //    NSString *selection = [wView stringByEvaluatingJavaScriptFromString:@"window.getSelection().toString()"];
    //    NSLog(@"selected text %@",selection);
    
    [wView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.execCommand('insertUnorderedList', false, null)"]];
}

- (void)oList{
    //    NSString *selection = [wView stringByEvaluatingJavaScriptFromString:@"window.getSelection().toString()"];
    //    NSLog(@"selected text %@",selection);
    
    [wView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.execCommand('insertOrderedList', false, null)"]];
}

- (void)img:(NSString *)path{
    [wView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.execCommand('insertImage', false, '%@')",path]];
}

- (IBAction)undo:(id)sender{
    [wView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.execCommand('Undo', false, null)"]];
}

- (IBAction)redo:(id)sender{
    [wView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.execCommand('redo', false, null)"]];
}

- (IBAction)boldAction:(id)sender{
    [self boldText];
}

- (IBAction)italicAction:(id)sender{
    [self italicText];
}

- (IBAction)underlineAction:(id)sender{
    [self underlineText];
}

- (IBAction)olAction:(id)sender{
    [self oList];
}

- (IBAction)ulAction:(id)sender{
    [self uList];
}

- (IBAction)imgAction:(id)sender{
    [customAccView1 removeFromSuperview];
    
    selection = [wView stringByEvaluatingJavaScriptFromString:@"window.getSelection().toString()"];
    NSLog(@"selected text %@",selection);
    
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil
                                                       otherButtonTitles:@"Choose photo",@"Take photo",nil];
        popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        popupQuery.tag = 1;
        [popupQuery showInView:self.view];
        [popupQuery release];
    }else {
        UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil
                                                       otherButtonTitles:@"Choose photo",nil];
        popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        popupQuery.tag = 1;
        [popupQuery showInView:self.view];
        [popupQuery release];
    }
    //[self img];
}

- (IBAction)done:(id)sender{
    
    NSString *myText = [wView stringByEvaluatingJavaScriptFromString:@"document.body.innerHTML"];
    NSLog(@"full html %@",myText);
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"RTEditor" message:myText delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
    [alert show];
    [alert release];
}



- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSLog(@"webView shouldStartLoadingWithRequest");
    return TRUE;
}

- (void)keyboardWillShow:(NSNotification *)note {
    [self performSelector:@selector(removeBar) withObject:nil afterDelay:0];
}

- (void)removeBar {
    // Locate non-UIWindow.
    UIWindow *keyboardWindow = nil;
    for (UIWindow *testWindow in [[UIApplication sharedApplication] windows]) {
        if (![[testWindow class] isEqual:[UIWindow class]]) {
            keyboardWindow = testWindow;
            break;
        }
    }
    
    // Locate UIWebFormView.
    for (UIView *possibleFormView in [keyboardWindow subviews]) {       
        // iOS 5 sticks the UIWebFormView inside a UIPeripheralHostView.
        if ([[possibleFormView description] rangeOfString:@"UIPeripheralHostView"].location != NSNotFound) {
            for (UIView *subviewWhichIsPossibleFormView in [possibleFormView subviews]) {
                NSRange range = [[subviewWhichIsPossibleFormView description] rangeOfString:@"UIWebFormAccessory"];
                if (range.location != NSNotFound) {
                    [subviewWhichIsPossibleFormView removeFromSuperview];
                }
            }
        }
    }
    
    //add keyboardhide button
    if (customAccView1 == nil) {
        customAccView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 229, 320, 35)];
        UIButton *btnHideKeyboard = [[UIButton alloc]initWithFrame:CGRectMake(265, 0, 46, 35)];
        [btnHideKeyboard addTarget:self action:@selector(btnHideKeyBoardTapped) forControlEvents:UIControlEventTouchUpInside];
        [btnHideKeyboard setImage:[UIImage imageNamed:@"keyboardHide.png"] forState:UIControlStateNormal];
        [customAccView1 addSubview:btnHideKeyboard];
        [btnHideKeyboard release];
    }
    
    [keyboardWindow addSubview:customAccView1];
    
    
    
    
    
}

- (void)btnHideKeyBoardTapped{
    NSLog(@"btnHideKeyBoardTapped");
    [customAccView1 removeFromSuperview];
    webText = [wView stringByEvaluatingJavaScriptFromString:@"document.body.innerHTML"];
    [wView loadHTMLString:webText baseURL:nil];
}

#pragma mark
#pragma mark action sheet delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
	[self dismissModalViewControllerAnimated:YES];
    
    
    
    if (actionSheet.tag == 1) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            if (buttonIndex == 0) {
                [self galleryButtonTap];
            } else if (buttonIndex == 1) {
                [self cameraButtonTap];
            }
        }else {
            if (buttonIndex == 0) {
                [self galleryButtonTap];
            } 
        }
        
        
		
	}
}

- (void)cameraButtonTap{
    UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
    
    if (cameraProgressHolder == nil) {
        cameraProgressHolder = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(103, 190, 115, 101)];
        [imageView setImage:[UIImage imageNamed:@"loadingBack.png"]];
        [cameraProgressHolder addSubview:imageView];
        [imageView release];
    }
    if (cameraProgress == nil) {
        cameraProgress = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [cameraProgress setFrame:CGRectMake(136, 203, 50, 50)];
    }
    [cameraProgressHolder setHidden:TRUE];
    [cameraProgressHolder addSubview:cameraProgress];
    
    [pickerController.view addSubview:cameraProgressHolder];
    
    pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    pickerController.delegate = self;
    pickerController.allowsEditing = TRUE;
    
    
    
    [self.navigationController pushViewController:pickerController animated:TRUE];
    [pickerController release];
}

- (void)galleryButtonTap{
    UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
    if (cameraProgressHolder == nil) {
        cameraProgressHolder = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(103, 190, 115, 101)];
        [imageView setImage:[UIImage imageNamed:@"loadingBack.png"]];
        [cameraProgressHolder addSubview:imageView];
        [imageView release];
    }
    if (cameraProgress == nil) {
        cameraProgress = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [cameraProgress setFrame:CGRectMake(136, 203, 50, 50)];
    }
    [cameraProgressHolder setHidden:TRUE];
    [cameraProgressHolder addSubview:cameraProgress];
    
    [pickerController.view addSubview:cameraProgressHolder];
    
    pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pickerController.delegate = self;
    pickerController.allowsEditing=YES;
    [self.navigationController pushViewController:pickerController animated:TRUE];
    [pickerController release];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissModalViewControllerAnimated:TRUE];
    [cameraProgressHolder removeFromSuperview];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSThread *progressThread = [[NSThread alloc]initWithTarget:self selector:@selector(showCameraProgress) object:nil];
    [progressThread start];
    
    UIImage *selectedImage;
    selectedImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    
    
    
    
    if (selectedImage != nil) {
        
        
        
        NSString *imageId = [self getPrimaryKey];
        
        NSLog(@"imageId %@", imageId);
        
        //save original image
        NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        //		NSString *pngFilePath = [NSString stringWithFormat:@"%@/IMG_%d.jpg",docDir, (maxId + 1)];//images%d_.png
        //		NSData *data = [NSData dataWithData:UIImageJPEGRepresentation(selectedImage,1.0)];
        //		[data writeToFile:pngFilePath atomically:YES];
        NSString *pngFilePath;
        NSData *data;
        
        //save page 05 large image
        //		//resize the image
        float imgWidth = selectedImage.size.width;
        float imgHeight = selectedImage.size.height;
        float aspectRatio = selectedImage.size.width/selectedImage.size.height;
        
        
        
        if (imgWidth > 315) {
            imgWidth = 315;
        }
        imgHeight = imgWidth / aspectRatio;
        
        
        
        CGSize newSize = CGSizeMake(imgWidth, imgHeight);
        
        UIGraphicsBeginImageContext( newSize );// a CGSize that has the size you want
        [selectedImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
        UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        
        
        pngFilePath = [NSString stringWithFormat:@"%@/IMG_%@.jpg",docDir, imageId];
        data = [NSData dataWithData:UIImageJPEGRepresentation(resizedImage,1.0)];
        [data writeToFile:pngFilePath atomically:YES];
        
        
        NSLog(@"setImage after camera");
        [self img:pngFilePath];
        
    }
    
    
	
	[picker dismissModalViewControllerAnimated:YES];
    
    
    
    
    
    
    [progressThread release];
    [cameraProgress stopAnimating];
    [cameraProgressHolder removeFromSuperview];
    
    
}

- (NSString *) getPrimaryKey{
    
    
    
    NSDate *curDate = [[NSDate alloc]init];    
    
    NSTimeInterval inter = [curDate timeIntervalSince1970]; //return as double
    [curDate release];
    
    NSString *str = [NSString stringWithFormat:@"%f",inter];
    
    NSString *mutstr = [str stringByReplacingOccurrencesOfString:@"." withString:@"W"];
    
    return mutstr;
    
    
    
}

- (void)showCameraProgress{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
    [cameraProgressHolder setHidden:FALSE];
    [cameraProgress startAnimating];
    [pool drain];
}
@end
