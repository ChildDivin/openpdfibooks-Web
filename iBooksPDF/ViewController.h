//
//  ViewController.h
//  iBooksPDF
//

//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIDocumentInteractionControllerDelegate>{
    IBOutlet UIWebView *webView;
}
@property (retain,nonatomic) UIDocumentInteractionController *docController;

- (IBAction)goPdf:(id)sender;

@end
