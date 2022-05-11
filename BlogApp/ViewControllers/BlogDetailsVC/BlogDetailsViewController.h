//
//  BlogDetailsViewController.h
//  BlogApp
//
//  Created by Muhammad Saud Anwar on 11/05/2022.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface BlogDetailsViewController : UIViewController
@property (strong, nonatomic) IBOutlet WKWebView *webView;
@property (strong, nonatomic) NSString *url;

@end

NS_ASSUME_NONNULL_END
