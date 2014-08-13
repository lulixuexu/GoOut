//
//  GOLeftSlideViewController.m
//  GoOut
//
//  Created by Liang GUO on 7/22/14.
//  Copyright (c) 2014 bst. All rights reserved.
//

#import "GOLeftSlideViewController.h"
#import "UIViewController+MMDrawerController.h"

@interface GOLeftSlideViewController ()
@property (nonatomic,strong)UITableView* tableView;
@property (nonatomic,strong)NSArray* menuArray;

@property (nonatomic,strong)NSMutableArray* tableCell;
@end

@implementation GOLeftSlideViewController
#pragma mark -- Initiation
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)initTableView
{
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    [_tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [self.view addSubview:_tableView];
}
- (void)initTableCell
{
    [self loadingDateFromPlist];
    
    _tableCell = [[NSMutableArray alloc]init];
    
    for (int i = 0; i<[_menuArray count]; i++) {
        UITableViewCell* cell = [[UITableViewCell alloc]init];
        
        //icon for menu
        NSString* imageName = [[_menuArray objectAtIndex:i]objectForKey:@"menu_icon"];
        UIImageView* view = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
        view.frame =CGRectMake(15, 15, 20, 20);
        view.backgroundColor = [UIColor clearColor];
        [cell addSubview:view];
        
        //title for menu
        UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, 140, 50)];
        label.text = [[_menuArray objectAtIndex:i]objectForKey:@"menu_name"];
        label.textAlignment = NSTextAlignmentLeft;
        [label setFont:[UIFont fontWithName: @"Helvetica"   size : 16.0 ]];
        label.backgroundColor = [UIColor clearColor];
        [cell addSubview:label];
        
        [_tableCell addObject:cell];
    }
}
- (void)loadingDateFromPlist
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:MENULILST_PLIST ofType:@"plist"];
    NSArray *plistArray = [[NSArray alloc] initWithContentsOfFile:plistPath];
    _menuArray = plistArray;
    
}
#pragma mark -- UITableView DataSource Delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
      return _tableCell[indexPath.row];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_tableCell count];
}
#pragma mark -- UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSString* className = [_menuArray[indexPath.row]objectForKey:@"menu_controller"];
    UIViewController* ctrl = [[NSClassFromString(className)alloc]init];
    
    [self.mm_drawerController
     setCenterViewController:ctrl
     withCloseAnimation:YES
     completion:nil];
}
#pragma mark -- life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initTableView];
    [self initTableCell];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
