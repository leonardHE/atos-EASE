//
//  EAWorkflowInfosViewController.m
//  EASE
//
//  Created by Aladin TALEB on 09/02/2015.
//  Copyright (c) 2015 Aladin TALEB. All rights reserved.
//

#import "EAWorkflowInfosViewController.h"
#import "MBPullDownController.h"


@interface EAWorkflowInfosViewController ()

@end

@implementation EAWorkflowInfosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.imageView.clipsToBounds = true;
    
    
    self.separatorView.layer.masksToBounds = false;
    self.separatorView.layer.shadowRadius = 2;
    self.separatorView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.separatorView.layer.shadowOpacity = 0.2;
    self.separatorView.layer.shadowOffset = CGSizeMake(0, 1);
    
    self.infosCollectionView.layer.masksToBounds = false;
    self.infosCollectionView.layer.shadowRadius = 2;
    self.infosCollectionView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.infosCollectionView.layer.shadowOpacity = 0.2;
    self.infosCollectionView.layer.shadowOffset = CGSizeMake(0,-1);
    
    
    UIEdgeInsets contentInset = UIEdgeInsetsMake(0, 0, self.pullDownController.openBottomOffset+6, 0);
    UIEdgeInsets scrollInset = UIEdgeInsetsMake(0, 0, self.pullDownController.openBottomOffset+10, 0);

    self.agentsTableView.contentInset = contentInset;
    self.agentsTableView.scrollIndicatorInsets = scrollInset;

    self.ingredientsTableView.contentInset = contentInset;
    self.ingredientsTableView.scrollIndicatorInsets = scrollInset;
    
    
    
    self.workflow = _workflow;


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setWorkflow:(EAWorkflow *)workflow
{
    
    _workflow = workflow;
    
    if (self.isViewLoaded)
    {
        self.view.backgroundColor = [UIColor colorWithWhite:255/255.0 alpha:1.0];
        
        self.imageView.image = workflow.image;
    
        self.titleLabel.text = workflow.title;
        self.titleLabel.textColor = workflow.color;
        
        self.agentsNumberLabel.textColor = workflow.color;
        self.ingredientsNumberLabel.textColor = workflow.color;
    
        self.infosCollectionView.backgroundColor = [workflow.color colorWithAlphaComponent:0.8];
    
        
        self.ingredientsTableView.backgroundColor = [UIColor colorWithWhite:255/255.0 alpha:1.0];
        self.agentsTableView.backgroundColor = [UIColor colorWithWhite:255/255.0 alpha:1.0];
        
        NSMutableAttributedString *ingredientsString = [[NSMutableAttributedString alloc] initWithString:@"2/3" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Thin" size:17]}];
        
        [ingredientsString appendAttributedString:[[NSAttributedString alloc] initWithString:@" Ingrédients" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:13]}]];
        
        
        
        NSMutableAttributedString *agentsString = [[NSMutableAttributedString alloc] initWithString:@"1/2" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Thin" size:17]}];
        
        [agentsString appendAttributedString:[[NSAttributedString alloc] initWithString:@" Users  " attributes:@{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:13]}]];
        
        [agentsString appendAttributedString:[[NSAttributedString alloc] initWithString:@" 6/7" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Thin" size:17]}]];
        
        [agentsString appendAttributedString:[[NSAttributedString alloc] initWithString:@" Agents" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:13]}]];
        
        self.ingredientsNumberLabel.attributedText = ingredientsString;
        self.agentsNumberLabel.attributedText = agentsString;
        
        
        [self.imageView setImageWithProgressIndicatorAndURL:self.workflow.imageURL];

        
    }

}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = 0;
    if (tableView == self.ingredientsTableView)
    {
        return 10;
    }
    else if (tableView == self.agentsTableView)
    {
        return 10;

    }
    
    return rows;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    if (tableView == self.ingredientsTableView)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"IngredientsCell"];
        cell.textLabel.text = [NSString stringWithFormat:@"Ingredient %d", indexPath.row+1];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Quantité %d", indexPath.row+1];

        
        
        cell.tintColor = self.workflow.color;
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        

    }
    else if (tableView == self.agentsTableView)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"AgentsCell"];
        
        cell.textLabel.text = [NSString stringWithFormat:@"Agent %d", indexPath.row+1];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Agent Info %d", indexPath.row+1];
        cell.tintColor = self.workflow.color;
        cell.accessoryType = UITableViewCellAccessoryCheckmark;

    }
    return cell;
}

#pragma mark - UITableViewDelegate

#pragma mark - UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 5;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"InfoCell" forIndexPath:indexPath];
    
    
    UIImageView *image = [cell viewWithTag:2];
    image.image = [UIImage imageNamed:@"Hour"];
    
    UILabel *label = [cell viewWithTag:1];
    label.textColor = [UIColor whiteColor];
    
    label.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    
    
    return cell;
}

#pragma mark - UICollectionViewDelegate


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
