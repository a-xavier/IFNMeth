# IFNMeth  
Use methylation array (EPIC) data to check if your samples have been treated with IFNβ.
Currently only works on whole blood. Needs the following cpgs: cg01028142, cg24678928, cg13452062, cg08888522, cg05552874, cg06188083, cg26312951, cg26505274, cg22930808, cg06981309 and cg10549986.
  
### How to install  
  
If ```devtools``` is already installed.  
```install_github("a-xavier/IFNMeth")```  
  
Otherwise install ```devtools``` first:  
```install.packages("devtools")```  

### Usage 
IFNMeth currently includes 2 functions:  
  
1. Predict if the sample  have been treated with IFNbeta:  
   ```results <- isTreated(Example_Data_Matrix, threshold = -0.42)```  
   Where Example_Data_Matrix is a beta-value matrix from EPIC methylation arrays (normalised) and threshold is the cuttof for the methylation treatment score.  
   The return value is a dataframe with the methylation treatment score and the IFNbeta treatment status  
2. If you know the sample has been treated with IFNbeta, guesstimate the number of days since first treatment:  
   ```results <- DaysFromTreatment(Example_Data_Matrix)```  
   The return value is a named vector with a number of days for each sample representing estimated days since first treatment.  
   
### Reference
Xavier, A., M. P. Campagna, V. Maltby, T. Kilpatrick, B. Taylor, H. Butzkueven, A.-L. Ponsonby, R. Scott, V. Jokubaitis, R. Lea & J. Lechner-Scott (2023) Interferon Beta treatment is a potent and targeted epigenetic modifier in multiple sclerosis. Frontiers in Immunology, 14.
![image](https://github.com/a-xavier/IFNMeth/assets/43228621/cebdc0e3-6b97-4e78-ae41-b9e931672cd6)

   
   
