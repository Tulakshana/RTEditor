//
//  RTViewController.m
//  RTEditor
//
//  Created by Tulakshana on 12/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RTViewController.h"

#import "renderers.h"
#import "markdown.h"

@interface RTViewController ()

@end

@implementation RTViewController

- (void)dealloc{
    customAccView1 = nil;
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    webText = nil;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"RTEditor" ofType:@"html"];
    NSLog(@"%@",path);
    [wView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]]];
//    [wView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]]];
//    webText = @"<html><head>    </head><body><div contentEditable = 'TRUE' id = 'editor' style='position:absolute;left:5px;top:5px; width:315px;height:103px;overflow:auto;'>test</div></body></html>";
//    [wView loadHTMLString:webText baseURL:nil];
    
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
    

    [wView.scrollView setScrollEnabled:FALSE];
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



- (IBAction)done:(id)sender{

    NSString *myText = [wView stringByEvaluatingJavaScriptFromString:@"document.body.innerHTML"];
    NSLog(@"full html %@",myText);
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"RTEditor" message:myText delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
    [alert show];
    [alert release];
}


#pragma mark - UIWebView Delegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSLog(@"webView shouldStartLoadingWithRequest");
    return TRUE;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    if (webText != nil) {
        NSLog(@"%@",webText);
        [wView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementById('editor').innerHTML = '%@'",[self getHTMLString:webText]]];
    }

}

#pragma mark -

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
        UIButton *btnHideKeyboard = [[UIButton alloc]initWithFrame:CGRectMake(275, 0, 46, 35)];
        [btnHideKeyboard addTarget:self action:@selector(btnHideKeyBoardTapped) forControlEvents:UIControlEventTouchUpInside];
        [btnHideKeyboard setImage:[UIImage imageNamed:@"keyboardHide.png"] forState:UIControlStateNormal];
        [customAccView1 addSubview:btnHideKeyboard];
        [btnHideKeyboard release];
        
//        UIButton *btnHTML = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        [btnHTML setFrame:CGRectMake(229, 0, 46, 35)];
//        [btnHTML addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
//        [btnHTML setTitle:@"html" forState:UIControlStateNormal];
//        [customAccView1 addSubview:btnHTML];
        UIScrollView *btnScrollView = [[UIScrollView alloc]init];
        [btnScrollView setFrame:CGRectMake(0, 0, 275, 35)];
        [btnScrollView setContentSize:CGSizeMake(367, 35)];
        [btnScrollView setShowsHorizontalScrollIndicator:FALSE];
        
        UIButton *btnClear = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnClear setFrame:CGRectMake(321, 0, 46, 35)];
        [btnClear addTarget:self action:@selector(removeFormatting) forControlEvents:UIControlEventTouchUpInside];
        [btnClear setTitle:@"Tx" forState:UIControlStateNormal];
        [btnScrollView addSubview:btnClear];
        
        UIButton *btnUndo = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnUndo setFrame:CGRectMake(275, 0, 46, 35)];
        [btnUndo addTarget:self action:@selector(undo:) forControlEvents:UIControlEventTouchUpInside];
        [btnUndo setTitle:@"undo" forState:UIControlStateNormal];
        [btnScrollView addSubview:btnUndo];
        
        UIButton *btnRedo = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnRedo setFrame:CGRectMake(229, 0, 46, 35)];
        [btnRedo addTarget:self action:@selector(redo:) forControlEvents:UIControlEventTouchUpInside];
        [btnRedo setTitle:@"redo" forState:UIControlStateNormal];
        [btnScrollView addSubview:btnRedo];
        
        UIButton *btnBold = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnBold setFrame:CGRectMake(183, 0, 46, 35)];
        [btnBold addTarget:self action:@selector(boldAction:) forControlEvents:UIControlEventTouchUpInside];
        [btnBold setTitle:@"B" forState:UIControlStateNormal];
        [btnScrollView addSubview:btnBold];
        
        UIButton *btnItalic = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnItalic setFrame:CGRectMake(137, 0, 46, 35)];
        [btnItalic addTarget:self action:@selector(italicAction:) forControlEvents:UIControlEventTouchUpInside];
        [btnItalic setTitle:@"I" forState:UIControlStateNormal];
        [btnScrollView addSubview:btnItalic];
        
        UIButton *btnUnderline = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnUnderline setFrame:CGRectMake(91, 0, 46, 35)];
        [btnUnderline addTarget:self action:@selector(underlineAction:) forControlEvents:UIControlEventTouchUpInside];
        [btnUnderline setTitle:@"U" forState:UIControlStateNormal];
        [btnScrollView addSubview:btnUnderline];
        
        UIButton *btnUnOrderList = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnUnOrderList setFrame:CGRectMake(45, 0, 46, 35)];
        [btnUnOrderList addTarget:self action:@selector(ulAction:) forControlEvents:UIControlEventTouchUpInside];
        [btnUnOrderList setTitle:@"ul" forState:UIControlStateNormal];
        [btnScrollView addSubview:btnUnOrderList];
        
        UIButton *btnOrderList = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnOrderList setFrame:CGRectMake(0, 0, 45, 35)];
        [btnOrderList addTarget:self action:@selector(olAction:) forControlEvents:UIControlEventTouchUpInside];
        [btnOrderList setTitle:@"ol" forState:UIControlStateNormal];
        [btnScrollView addSubview:btnOrderList];

        [customAccView1 addSubview:btnScrollView];
        [btnScrollView release];
    }
    [keyboardWindow addSubview:customAccView1];

    if (webText != nil) {
        [wView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementById('editor').innerHTML = '%@'",webText]];

        [wView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.execCommand(setEndOfContenteditable(document.getElementById('editor')))"]];
    }

    
    [wView setFrame:CGRectMake(0, 0, 320, 200)];
    

}

- (void)btnHideKeyBoardTapped{
    NSLog(@"btnHideKeyBoardTapped");
    [customAccView1 removeFromSuperview];

    webText = nil;
    webText = [wView stringByEvaluatingJavaScriptFromString:@"document.getElementById('editor').innerHTML"];
    [webText retain];
    [wView reload];

    
    [wView setFrame:CGRectMake(0, 0, 320, 460)];
//    [self done:nil];
}


- (NSString *)getHTMLString:(NSString *)string{
    NSString *rawMarkdown = string;
    const char * prose = [rawMarkdown UTF8String];
    struct buf *ib, *ob;
    
    int length = rawMarkdown.length + 1;
    
    ib = bufnew(length);
    bufgrow(ib, length);
    memcpy(ib->data, prose, length);
    ib->size = length;
    
    ob = bufnew(64);
    markdown(ob, ib, &mkd_xhtml);
    
    NSString *shinyNewHTML = [NSString stringWithUTF8String: ob->data];
    shinyNewHTML = [shinyNewHTML stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
    NSLog(@"getHTMLString: %@", shinyNewHTML);
    
    bufrelease(ib);
    bufrelease(ob);
    
    return shinyNewHTML;
}

//- (void)paste:(id)sender
//{
//    UIPasteboard* pasteboard = [UIPasteboard generalPasteboard];
//    NSString* rawString = pasteboard.string;
//    NSLog(@"rawString %@",rawString);
//    NSString* formattedString =  rawString;// do something fun with rawString here
//    pasteboard.string = formattedString;
//    [super paste:sender];
//}

@end
