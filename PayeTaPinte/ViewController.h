//
//  ViewController.h
//  PayeTaPinte
//
//  Created by Maxime Berthelot [DAN-PARIS] on 27/05/2014.
//
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (weak, nonatomic) IBOutlet UIWebView *viewWeb;
@end
