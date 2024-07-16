# Sectoral Productivity Losses from Sovereign Default Events: a simulation-based approach

This folder contains files for the replication of my Summer Report. This was a short quantitative project where I estimated parameters associated with default cost across sectors (tradable and nontradable GDP) for the typical case of Argentina. I defined tradable GDP as Manufacturing value-added (ISIC divisions 15-37) and nontradable GDP as Services value-added (ISIC divisions 45-99). Data is collected from [World Bank's dataset](https://data.worldbank.org). The report is the file `SummerReport_CarlosRojas.pdf`.

I describe the subfolders:

- 📁 **Asymmetric Costs**: it contains scripts and functions to estimate the parameters of default cost under the asssumption they differ across sectors. 
- 📁 **Symmetric Costs**: it contains scripts and functions to estimate the parameters of the default cost under the assumption they are the same in both tradable and nontradable sectors. 

### ⚠️ Caveat
Construction value-added was not considered because of its non-availability in the dataset. Its inclusion may affect the observation of the sensibility of nontradable GDP to sovereign default events for some countries. On the other hand, Construction sectoral dynamics could differ from Services strongly (especially in the aftermath of a sovereign debt crisis), which could be a reason for including that sector as an independent block with its own characteristics (parameters and constraints).

Using data from the Groningen Growth and Development Center 10 sectors (GGDC) database for a sample of Latin American countries, I confirmed the same conclusion about the sensitiviness of Manufacturing sector regarding Construction + Services sectors (a broader definition of nontradable GDP). For more information see below.  

## 🗂 Files

### Datasets
- `Argentina_DataSet.xlsx`: This file contains information on the Argentinean economy, like dates on financial crises, debt to GDP ratio, TFP, investment, net exports, real exchange rate, sovereign spreads, among others. 
- `CountriesDefault.xlsx`: Information of tradable and nontradable GDPs for the following defaulters (year of the sovereign default event in parenthesis): 
    -  🇦🇷 Argentina (2002)		
    -  🇨🇱 Chile (1983)		
    -  🇨🇷 Costa Rica (1981)		
    -  🇪🇨 Ecuador (1999)		
    -  🇬🇩 Grenada (2004)		
    -  🇬🇷 Greece (2012)		
    -  🇲🇽 Mexico (1982)		
    -  🇵🇰 Pakistan (1999)		
    -  🇵🇪 Peru (1984)		
    -  🇹🇷 Turkey (2001)		
    -  🇺🇾 Uruguay (2003)		
    -  🇺🇦 Ukraine (2015)
    
- `CountriesDefault_Robustness.xlsx`: Information of tradable (Manufacturing) and nontradable (Construction + Services) GDPs for the following defaulters (year of the sovereign default event in parenthesis):      
    -  🇦🇷 Argentina (2002)		
    -  🇨🇱 Chile (1983)		
    -  🇨🇷 Costa Rica (1981)			
    -  🇲🇽 Mexico (1982)			
    -  🇵🇪 Peru (1984)		

Notice that the conclusion on tradable GDP as a more sensitive sector to sovereign default events holds with this new dataset.   
    
### Scripts and functions
- `CountriesDefault.m`: It replicates Figure 1. To work with this script, you need the function `figureCyc.m`.
- `EmpiricalEvidence.m`: This function estimates the effect of financial crises on Argentinean sectoral GDP. It follows the methodology from Gourinchas and Obstfeld (2012) which will be used in the Indirect Inference approach. Moreover, it computes main moments for the Simulated Method of Moments, and estimates the Argentinean TFP process by OLS. Finally, it replicates Figure 2. To run this function you need functions `Obstfeld_Gourinchas.m` and `visualize.m` (both functions in folder **Asymmetric Costs**).
