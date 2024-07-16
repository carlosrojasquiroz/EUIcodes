#--------------------------------------------------------------------------------------------------------------------------
# Self-fulfilling debt crises in commodity-exporting economies
# (Empirical analysis)
#--------------------------------------------------------------------------------------------------------------------------
# In this script, I run some regressions on the variation of sovereign bond yields between the date of the issuance and the
# reopening date. I take advantage of a typical characteristic of sovereign bond markets, which is the reissuance of bonds.
# Given the Government is issuing the same bond in different dates, my hypothesis considers this difference is explained
# by different expectations on commodity prices across dates, conditional on the size and maturity of the bond. This idea
# is taken from the paper of Bigio, Nuno, and Passadore (2023). Sample contains information about Brazil and Colombia, 
# two typical commodity (oil) exporters. I assume both are price takers.
#--------------------------------------------------------------------------------------------------------------------------
rm(list=ls())
if(!require(tidyverse))install.packages("tidyverse"); library(tidyverse)
if(!require(readxl))install.packages("readxl"); library(readxl)
if(!require(stargazer))install.packages("stargazer"); library(stargazer)
if(!require(broom))install.packages("broom"); library(broom)
if(!require(estimatr))install.packages("estimatr"); library(estimatr)
#--------------------------------------------------------------------------------------------------------------------------
rm(list = ls())
df <- read_excel("C:/Users/crojasqu/Desktop/DataBase19052023.xlsx",
                 sheet = "ReOpData")
#--------------------------------------------------------------------------------------------------------------------------
# First experiment: Regression on the difference between the sovereign bond yield at the issuance and reopening dates and 
# the variation in the futures oil price between both dates. The estimand is conditioned to size and maturity of the bond,
# and also on the observed variation in spot oil price. I include dummy variables for country (only in the case of taking
# all the sample as a whole), currency and month of issuance. 
#--------------------------------------------------------------------------------------------------------------------------
df$Y <- df$Dyield
#--------------------------------------------------------------------------------------------------------------------------
# Regression for all the sample
#--------------------------------------------------------------------------------------------------------------------------
df$EpOil <- df$DP12
Eq12A0 <- lm(Y~ EpOil + DP0 + B_GDP + Maturity + factor(Country),
           data=df)
Eq12A1 <- lm(Y~ EpOil + DP0 + B_GDP + Maturity + factor(Months) + factor(Country),
             data=df)
Eq12A2 <- lm(Y~ EpOil + DP0 + B_GDP + Maturity + factor(Currency) + factor(Months) + factor(Country),
             data=df)
df$EpOil <- df$DP24
Eq24A0 <- lm(Y~ EpOil + DP0 + B_GDP + Maturity + factor(Country),
             data=df)
Eq24A1 <- lm(Y~ EpOil + DP0 + B_GDP + Maturity + factor(Months) + factor(Country),
             data=df)
Eq24A2 <- lm(Y~ EpOil + DP0 + B_GDP + Maturity + factor(Currency) + factor(Months) + factor(Country),
             data=df)
df$EpOil <- df$DP36
Eq36A0 <- lm(Y~ EpOil + DP0 + B_GDP + Maturity + factor(Country),
             data=df)
Eq36A1 <- lm(Y~ EpOil + DP0 + B_GDP + Maturity + factor(Months) + factor(Country),
             data=df)
Eq36A2 <- lm(Y~ EpOil + DP0 + B_GDP + Maturity + factor(Currency) + factor(Months) + factor(Country),
             data=df)
# Latex table
tableALL <- stargazer(Eq12A0,Eq24A0,Eq36A0,
                      title ="Reopening bonds and commodity price expectations - Model 0",
                      align = TRUE,
                      header = FALSE,
                      se = starprep(Eq12A0,Eq24A0,Eq36A0,
                                    se_type = "stata"))
tableALL <- stargazer(Eq12A1,Eq24A1,Eq36A1,
                      title ="Reopening bonds and commodity price expectations - Model 1",
                      align = TRUE,
                      header = FALSE,
                      se = starprep(Eq12A1,Eq24A1,Eq36A1,
                                    se_type = "stata"))
tableALL <- stargazer(Eq12A2,Eq24A2,Eq36A2,
                      title ="Reopening bonds and commodity price expectations - Model 2",
                      align = TRUE,
                      header = FALSE,
                      se = starprep(Eq12A2,Eq24A2,Eq36A2,
                                    se_type = "stata"))
#--------------------------------------------------------------------------------------------------------------------------
# Brazil
#--------------------------------------------------------------------------------------------------------------------------
df$EpOil <- df$DP12
Eq12B0 <- lm(Y~ EpOil + DP0 + B_GDP + Maturity,
             data=subset(df,Country==1))
Eq12B1 <- lm(Y~ EpOil + DP0 + B_GDP + Maturity + factor(Months),
             data=subset(df,Country==1))
Eq12B2 <- lm(Y~ EpOil + DP0 + B_GDP + Maturity + factor(Currency) + factor(Months),
             data=subset(df,Country==1))
df$EpOil <- df$DP24
Eq24B0 <- lm(Y~ EpOil + DP0 + B_GDP + Maturity,
             data=subset(df,Country==1))
Eq24B1 <- lm(Y~ EpOil + DP0 + B_GDP + Maturity + factor(Months),
             data=subset(df,Country==1))
Eq24B2 <- lm(Y~ EpOil + DP0 + B_GDP + Maturity + factor(Currency) + factor(Months),
             data=subset(df,Country==1))
df$EpOil <- df$DP36
Eq36B0 <- lm(Y~ EpOil + DP0 + B_GDP + Maturity,
             data=subset(df,Country==1))
Eq36B1 <- lm(Y~ EpOil + DP0 + B_GDP + Maturity + factor(Months),
             data=subset(df,Country==1))
Eq36B2 <- lm(Y~ EpOil + DP0 + B_GDP + Maturity + factor(Currency) + factor(Months),
             data=subset(df,Country==1))
# Latex table
tableALL <- stargazer(Eq12B0,Eq24B0,Eq36B0,
                      title ="Reopening bonds and commodity price expectations - Model 0",
                      align = TRUE,
                      header = FALSE,
                      se = starprep(Eq12B0,Eq24B0,Eq36B0,
                                    se_type = "stata"))
tableALL <- stargazer(Eq12B1,Eq24B1,Eq36B1,
                      title ="Reopening bonds and commodity price expectations - Model 1",
                      align = TRUE,
                      header = FALSE,
                      se = starprep(Eq12B1,Eq24B1,Eq36B1,
                                    se_type = "stata"))
tableALL <- stargazer(Eq12B2,Eq24B2,Eq36B2,
                      title ="Reopening bonds and commodity price expectations - Model 2",
                      align = TRUE,
                      header = FALSE,
                      se = starprep(Eq12B2,Eq24B2,Eq36B2,
                                    se_type = "stata"))
#--------------------------------------------------------------------------------------------------------------------------
# Colombia
#--------------------------------------------------------------------------------------------------------------------------
df$EpOil <- df$DP12
Eq12C0 <- lm(Y~ EpOil + DP0 + B_GDP + Maturity,
             data=subset(df,Country==2))
Eq12C1 <- lm(Y~ EpOil + DP0 + B_GDP + Maturity + factor(Months),
             data=subset(df,Country==2))
Eq12C2 <- lm(Y~ EpOil + DP0 + B_GDP + Maturity + factor(Currency) + factor(Months),
             data=subset(df,Country==2))
df$EpOil <- df$DP24
Eq24C0 <- lm(Y~ EpOil + DP0 + B_GDP + Maturity,
             data=subset(df,Country==2))
Eq24C1 <- lm(Y~ EpOil + DP0 + B_GDP + Maturity + factor(Months),
             data=subset(df,Country==2))
Eq24C2 <- lm(Y~ EpOil + DP0 + B_GDP + Maturity + factor(Currency) + factor(Months),
             data=subset(df,Country==2))
df$EpOil <- df$DP36
Eq36C0 <- lm(Y~ EpOil + DP0 + B_GDP + Maturity,
             data=subset(df,Country==2))
Eq36C1 <- lm(Y~ EpOil + DP0 + B_GDP + Maturity + factor(Months),
             data=subset(df,Country==2))
Eq36C2 <- lm(Y~ EpOil + DP0 + B_GDP + Maturity + factor(Currency) + factor(Months),
             data=subset(df,Country==2))
# Latex table
tableALL <- stargazer(Eq12C0,Eq24C0,Eq36C0,
                      title ="Reopening bonds and commodity price expectations - Model 0",
                      align = TRUE,
                      header = FALSE,
                      se = starprep(Eq12C0,Eq24C0,Eq36C0,
                                    se_type = "stata"))
tableALL <- stargazer(Eq12C1,Eq24C1,Eq36C1,
                      title ="Reopening bonds and commodity price expectations - Model 1",
                      align = TRUE,
                      header = FALSE,
                      se = starprep(Eq12C1,Eq24C1,Eq36C1,
                                    se_type = "stata"))
tableALL <- stargazer(Eq12C2,Eq24C2,Eq36C2,
                      title ="Reopening bonds and commodity price expectations - Model 2",
                      align = TRUE,
                      header = FALSE,
                      se = starprep(Eq12C2,Eq24C2,Eq36C2,
                                    se_type = "stata"))
#--------------------------------------------------------------------------------------------------------------------------
# Second experiment: Regression on the difference between the mark-up on bond price and the variation in the futures oil  
# price between both dates. The markup is computed as in BNP (2023). I expect a positive value of this parameter, such that
# if markets expect an increase in commodity price, they are willing to buy the bond at higher price.  
#--------------------------------------------------------------------------------------------------------------------------
df$Y <- df$Dprice
#--------------------------------------------------------------------------------------------------------------------------
# Regression for all the sample
#--------------------------------------------------------------------------------------------------------------------------
df$EpOil <- df$DP12
Eq12A0 <- lm(Y~ EpOil + B_GDP + Maturity + factor(Country),
             data=df)
Eq12A1 <- lm(Y~ EpOil + B_GDP + Maturity + factor(Months) + factor(Country),
             data=df)
Eq12A2 <- lm(Y~ EpOil + B_GDP + Maturity + factor(Currency) + factor(Months) + factor(Country),
             data=df)
df$EpOil <- df$DP24
Eq24A0 <- lm(Y~ EpOil + B_GDP + Maturity + factor(Country),
             data=df)
Eq24A1 <- lm(Y~ EpOil + B_GDP + Maturity + factor(Months) + factor(Country),
             data=df)
Eq24A2 <- lm(Y~ EpOil + B_GDP + Maturity + factor(Currency) + factor(Months) + factor(Country),
             data=df)
df$EpOil <- df$DP36
Eq36A0 <- lm(Y~ EpOil + B_GDP + Maturity + factor(Country),
             data=df)
Eq36A1 <- lm(Y~ EpOil + B_GDP + Maturity + factor(Months) + factor(Country),
             data=df)
Eq36A2 <- lm(Y~ EpOil + B_GDP + Maturity + factor(Currency) + factor(Months) + factor(Country),
             data=df)
# Latex table
tableALL <- stargazer(Eq12A0,Eq24A0,Eq36A0,
                      title ="Reopening bonds and commodity price expectations - Model 0",
                      align = TRUE,
                      header = FALSE,
                      se = starprep(Eq12A0,Eq24A0,Eq36A0,
                                    se_type = "stata"))
tableALL <- stargazer(Eq12A1,Eq24A1,Eq36A1,
                      title ="Reopening bonds and commodity price expectations - Model 1",
                      align = TRUE,
                      header = FALSE,
                      se = starprep(Eq12A1,Eq24A1,Eq36A1,
                                    se_type = "stata"))
tableALL <- stargazer(Eq12A2,Eq24A2,Eq36A2,
                      title ="Reopening bonds and commodity price expectations - Model 2",
                      align = TRUE,
                      header = FALSE,
                      se = starprep(Eq12A2,Eq24A2,Eq36A2,
                                    se_type = "stata"))
#--------------------------------------------------------------------------------------------------------------------------
# Brazil
#--------------------------------------------------------------------------------------------------------------------------
df$EpOil <- df$DP12
Eq12B0 <- lm(Y~ EpOil + DP0 + B_GDP + Maturity,
             data=subset(df,Country==1))
Eq12B1 <- lm(Y~ EpOil + DP0 + B_GDP + Maturity + factor(Months),
             data=subset(df,Country==1))
Eq12B2 <- lm(Y~ EpOil + DP0 + B_GDP + Maturity + factor(Currency) + factor(Months),
             data=subset(df,Country==1))
df$EpOil <- df$DP24
Eq24B0 <- lm(Y~ EpOil + DP0 + B_GDP + Maturity,
             data=subset(df,Country==1))
Eq24B1 <- lm(Y~ EpOil + DP0 + B_GDP + Maturity + factor(Months),
             data=subset(df,Country==1))
Eq24B2 <- lm(Y~ EpOil + DP0 + B_GDP + Maturity + factor(Currency) + factor(Months),
             data=subset(df,Country==1))
df$EpOil <- df$DP36
Eq36B0 <- lm(Y~ EpOil + DP0 + B_GDP + Maturity,
             data=subset(df,Country==1))
Eq36B1 <- lm(Y~ EpOil + DP0 + B_GDP + Maturity + factor(Months),
             data=subset(df,Country==1))
Eq36B2 <- lm(Y~ EpOil + DP0 + B_GDP + Maturity + factor(Currency) + factor(Months),
             data=subset(df,Country==1))
# Latex table
tableALL <- stargazer(Eq12B0,Eq24B0,Eq36B0,
                      title ="Reopening bonds and commodity price expectations - Model 0",
                      align = TRUE,
                      header = FALSE,
                      se = starprep(Eq12B0,Eq24B0,Eq36B0,
                                    se_type = "stata"))
tableALL <- stargazer(Eq12B1,Eq24B1,Eq36B1,
                      title ="Reopening bonds and commodity price expectations - Model 1",
                      align = TRUE,
                      header = FALSE,
                      se = starprep(Eq12B1,Eq24B1,Eq36B1,
                                    se_type = "stata"))
tableALL <- stargazer(Eq12B2,Eq24B2,Eq36B2,
                      title ="Reopening bonds and commodity price expectations - Model 2",
                      align = TRUE,
                      header = FALSE,
                      se = starprep(Eq12B2,Eq24B2,Eq36B2,
                                    se_type = "stata"))
#--------------------------------------------------------------------------------------------------------------------------
# Colombia
#--------------------------------------------------------------------------------------------------------------------------
df$EpOil <- df$DP12
Eq12C0 <- lm(Y~ EpOil + DP0 + B_GDP + Maturity,
             data=subset(df,Country==2))
Eq12C1 <- lm(Y~ EpOil + DP0 + B_GDP + Maturity + factor(Months),
             data=subset(df,Country==2))
Eq12C2 <- lm(Y~ EpOil + DP0 + B_GDP + Maturity + factor(Currency) + factor(Months),
             data=subset(df,Country==2))
df$EpOil <- df$DP24
Eq24C0 <- lm(Y~ EpOil + DP0 + B_GDP + Maturity,
             data=subset(df,Country==2))
Eq24C1 <- lm(Y~ EpOil + DP0 + B_GDP + Maturity + factor(Months),
             data=subset(df,Country==2))
Eq24C2 <- lm(Y~ EpOil + DP0 + B_GDP + Maturity + factor(Currency) + factor(Months),
             data=subset(df,Country==2))
df$EpOil <- df$DP36
Eq36C0 <- lm(Y~ EpOil + DP0 + B_GDP + Maturity,
             data=subset(df,Country==2))
Eq36C1 <- lm(Y~ EpOil + DP0 + B_GDP + Maturity + factor(Months),
             data=subset(df,Country==2))
Eq36C2 <- lm(Y~ EpOil + DP0 + B_GDP + Maturity + factor(Currency) + factor(Months),
             data=subset(df,Country==2))
# Latex table
tableALL <- stargazer(Eq12C0,Eq24C0,Eq36C0,
                      title ="Reopening bonds and commodity price expectations - Model 0",
                      align = TRUE,
                      header = FALSE,
                      se = starprep(Eq12C0,Eq24C0,Eq36C0,
                                    se_type = "stata"))
tableALL <- stargazer(Eq12C1,Eq24C1,Eq36C1,
                      title ="Reopening bonds and commodity price expectations - Model 1",
                      align = TRUE,
                      header = FALSE,
                      se = starprep(Eq12C1,Eq24C1,Eq36C1,
                                    se_type = "stata"))
tableALL <- stargazer(Eq12C2,Eq24C2,Eq36C2,
                      title ="Reopening bonds and commodity price expectations - Model 2",
                      align = TRUE,
                      header = FALSE,
                      se = starprep(Eq12C2,Eq24C2,Eq36C2,
                                    se_type = "stata"))
#--------------------------------------------------------------------------------------------------------------------------