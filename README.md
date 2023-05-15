# IFNMeth
Use methylation array (EPIC) data to check if your samples have been treated with IFNβ

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
3. ```results <- DaysFromTreatment(Example_Data_Matrix)```
4. The return value is a named vector with a number of days for each sample representing estimated days since first treatment.
5. 
   
