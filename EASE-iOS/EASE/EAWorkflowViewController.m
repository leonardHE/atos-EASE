//
//  ViewController.m
//  EASE
//
//  Created by Aladin TALEB on 03/02/2015.
//  Copyright (c) 2015 Aladin TALEB. All rights reserved.
//

#import "EAWorkflowViewController.h"

#import "MBPullDownController.h"

@interface EAWorkflowViewController ()





@end

@implementation EAWorkflowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.navigationItem.title = @"Workflow";

    ((EACollectionViewWorkflowLayout*)self.collectionView.collectionViewLayout).delegate = self;
    

    self.collectionView.contentInset = UIEdgeInsetsMake(0, 72, 0, 10);
    self.collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 67, 0, 0);
    self.dateScrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);

    
   
    
    self.dateScrollView = [[EAWorkflowDateScrollView alloc] initWithFrame:CGRectMake(self.collectionView.contentOffset.x, 0, 67, self.collectionView.frame.size.height)];
    
    
    [self.collectionView addSubview:self.dateScrollView];
    
    self.dateScrollView.color = self.workflow.color;
}

-(void)setWorkflow:(EAWorkflow *)workflow
{
    _workflow = workflow;
    
    if (self.isViewLoaded)
    {
        [self.collectionView reloadData];
        self.dateScrollView.color = self.workflow.color;

    }
    
    

}

-(void)viewDidAppear:(BOOL)animated
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (!self.workflow)
        return 0;
    return self.workflow.tasks.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    EAWorkflowTaskCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
   
    cell.task = self.workflow.tasks[indexPath.row];
    cell.color = self.workflow.color;
    
    return cell;
    
}

#pragma mark - EACollectionViewWorkflowLayoutDelegate

-(EADateInterval*)collectionView:(UICollectionView *)collectionView workflowLayout:(EACollectionViewWorkflowLayout *)workflowLayout askForDateIntervalOfTaskAtIndexPath:(NSIndexPath *)indexPath
{
    return ((EATask*)self.workflow.tasks[indexPath.row]).dateInterval;
}


-(void)collectionView:(UICollectionView *)collectionView didUpdateAnchorsForWorkflowLayout:(EACollectionViewWorkflowLayout *)workflowLayout
{
    if (self.workflow)
    {
        [self.dateScrollView updateScrollViewWithTimeAnchorsDate:workflowLayout.timeAnchorsDate andTimeAnchorsY:workflowLayout.timeAnchorsY];
        [self scrollViewDidScroll:self.collectionView];
    }
    
}

#pragma mark - UICollectionViewDelegate


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
 
    self.dateScrollView.frame = CGRectMake(scrollView.contentOffset.x, -10, 67, MAX(self.collectionView.contentSize.height, self.collectionView.frame.size.height)+20);
    self.dateScrollView.contentOffset = CGPointMake(0, -10);
    
    
    
    
    EAWorkflowInfosViewController *infosViewController = self.pullDownController.backController;
    
    CGFloat topOffset = self.pullDownController.closedTopOffset;
    
    CGFloat offsetY = MAX( 0.5*(self.collectionView.contentOffset.y+topOffset-64)-32, -64);
    

    
    infosViewController.scrollView.contentOffset = CGPointMake(0, offsetY);
    
    UIImageView *imageView = infosViewController.imageView;
    
    CGFloat bottomYofImage = imageView.frame.origin.y+imageView.frame.size.height;
    
    CGFloat topYofImage = offsetY;
    CGFloat heightOfImage = MAX(bottomYofImage-topYofImage, 0);
    
   
    
}


@end
