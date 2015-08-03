//
//  ViewController.m
//  iBooksPDF

//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSURL *url = [[NSBundle mainBundle]
                  URLForResource: @"iPhoneintro" withExtension:@"pdf"];
  //  NSURL *targetURL = [NSURL URLWithString:@"http://developer.apple.com/iphone/library/documentation/UIKit/Reference/UIWebView_Class/UIWebView_Class.pdf"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];

}

#pragma  mark- WEBVIEW DELEGATE
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if(!webView.isLoading)
    {
        [self performSelector:@selector(traverseInWebViewWithPage) withObject:nil afterDelay:0.1];
    }
}
-(void)traverseInWebViewWithPage
{
    //Get total pages in PDF File ----------- PDF File name here ---------------
    NSString *strPDFFilePath = [[NSBundle mainBundle] pathForResource:@"iPhoneintro" ofType:@"pdf"];
    NSInteger totalPDFPages = [self getTotalPDFPages:strPDFFilePath];
    
    //Get total PDF pages height in webView
    CGFloat totalPDFHeight = webView.scrollView.contentSize.height;
    NSLog ( @"total pdf height: %f", totalPDFHeight);
    
    //Calculate page height of single PDF page in webView
    NSInteger horizontalPaddingBetweenPages = 10*(totalPDFPages+1);
    CGFloat pageHeight = (totalPDFHeight-horizontalPaddingBetweenPages)/(CGFloat)totalPDFPages;
    NSLog ( @"pdf page height: %f", pageHeight);
    
    //scroll to specific page --------------- here your page number -----------
    NSInteger specificPageNo = 9;
    if(specificPageNo <= totalPDFPages)
    {
        //calculate offset point in webView
        CGPoint offsetPoint = CGPointMake(0, (10*(specificPageNo-1))+(pageHeight*(specificPageNo-1)));
        //set offset in webView
        [webView.scrollView setContentOffset:offsetPoint];
    }
}
-(NSInteger)getTotalPDFPages:(NSString *)strPDFFilePath
{
    NSURL *pdfUrl = [NSURL fileURLWithPath:strPDFFilePath];
    CGPDFDocumentRef document = CGPDFDocumentCreateWithURL((CFURLRef)pdfUrl);
    size_t pageCount = CGPDFDocumentGetNumberOfPages(document);
    return pageCount;
}
#pragma  mark- IBAction
- (IBAction)goPdf:(id)sender {
    
    NSURL *url = [[NSBundle mainBundle]
                    URLForResource: @"iPhoneintro" withExtension:@"pdf"];
    
    self.docController = [UIDocumentInteractionController interactionControllerWithURL:url];

    self.docController.delegate = self;
    
    BOOL isValid = [self.docController presentOpenInMenuFromRect:CGRectZero inView:self.view animated:YES];
    if (!isValid) {
        UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"Sorry !!" message:@"Unable to open file in this device." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [aler show];
    }
    NSLog(@"Is valid %d",isValid);
    
}
#pragma  mark- UIDocumentInteractionController DELEGATE
- (void)documentInteractionController:(UIDocumentInteractionController *)controller willBeginSendingToApplication:(NSString *)application{
    
    NSLog(@"willBeginSendingToApplication");
}

- (void)documentInteractionController:(UIDocumentInteractionController *)controller didEndSendingToApplication:(NSString *)application{
    NSLog(@"didEndSendingToApplication");
    
}

- (void)documentInteractionControllerDidDismissOpenInMenu:(UIDocumentInteractionController *)controller{
    NSLog(@"documentInteractionControllerDidDismissOpenInMenu");

}
@end
