//
//  ViewController.m
//  BlogApp
//
//  Created by Muhammad Saud Anwar on 21/04/2022.
//

#import "BlogViewController.h"
@interface BlogViewController ()

@end

@implementation BlogViewController

NSString *cellId = @"Cell";
NSMutableArray *blogArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    UINib *nib = [UINib nibWithNibName:@"BlogTableViewCell" bundle:nil];
    [[self tableView] registerNib:nib forCellReuseIdentifier:cellId];
    [self getBlogData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BlogTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[BlogTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    NSDictionary *blogDict = [blogArray objectAtIndex:indexPath.row];
    NSMutableString *imgUrl = [NSMutableString stringWithString:[blogDict objectForKey:@"image"]];
    [imgUrl insertString:@"fit-in/60x0/filters:autojpg()/" atIndex:26];
    cell.titleLbl.text = [NSString stringWithFormat:@"Title : %@",[blogDict objectForKey:@"title"]];
    cell.descLbl.text = [NSString stringWithFormat:@"Description : %@",[blogDict objectForKey:@"description"]];
    cell.authorLbl.text = [NSString stringWithFormat:@"Author : %@",[blogDict objectForKey:@"author"]];
    cell.dateLbl.text = [NSString stringWithFormat:@"Date : %@",[blogDict objectForKey:@"article_date"]];
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:imgUrl]];
        if ( data == nil )
            return;
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.imgView.image = [UIImage imageWithData: data];
        });
    });
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return blogArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90.0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:
(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *blogDict = [blogArray objectAtIndex:indexPath.row];
    NSString *strUrl = [blogDict objectForKey:@"link"];
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    BlogDetailsViewController* controller = [storyboard instantiateViewControllerWithIdentifier:@"BlogDetailsViewController"];
    controller.url = strUrl;
    [self presentViewController:controller animated:true completion:nil];
}

- (void) getBlogData
{
    NSError *error;
    NSString *url_string = [NSString stringWithFormat: @"https://hiring.ltvops.com/articles/index.mobile-ios.json"];
    NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:url_string]];
    NSMutableArray *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    NSDictionary *dictionary = [[NSDictionary alloc] init];
    dictionary = [json mutableCopy];
    
    NSError *jsonError;
    
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
    if(jsonObject !=nil){
        
        if(![[jsonObject objectForKey:@"#data"] isEqual:@""]){
            blogArray = [jsonObject objectForKey:@"articles"];
        }
    }
}

@end

