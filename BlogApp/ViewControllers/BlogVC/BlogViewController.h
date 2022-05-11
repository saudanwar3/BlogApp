//
//  ViewController.h
//  BlogApp
//
//  Created by Muhammad Saud Anwar on 21/04/2022.
//

#import <UIKit/UIKit.h>
#import "BlogTableViewCell.h"
#import "BlogDetailsViewController.h"

@interface BlogViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

