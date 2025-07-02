------------
Introduction
------------

This repository includes two GAUSS files (.gss) and one STATA file (.do).

The GAUSS file entitled "Replication file - Frontier specifications" 
includes the codes used to get the parameter estimates of the paper 
"Latent class models with persistence in regime changes: A distributed lag analysis", 
coauthored by Luis Orea and Hervé Dapko. In this setting, the error term is e=v-u, where u>0. 

The GAUSS file entitled "eplication file - Non-frontier models" 
includes codes that allow estimating non-frontier models when inefficiency is irrelevant. 
The error term in this setting is e=v. 



@ ------------------------------------------------------------- @
@ --------------------------- File: --------------------------- @
@ -- 2025_07_02 - Replication file - Frontier specifications -- @
@ ------------------------------------------------------------- @

This GAUSS file includes the codes used to get the parameter estimates of the paper 
"Latent class models with persistence in regime changes: A distributed lag analysis", 
coauthored by Luis Orea and Hervé Dapko. In this setting, the error term is e=v-u, where u>0. 

@ ------------------------------------------------------------- @
@ ------------------------------------------------------------- @
@ ------------------------------------------------------------- @
@ --- CODES USED TO GET THE PARAMETER ESTIMATES OF THE PAPER -- @
@ -- "Latent class models with persistence in regime changes" - @
@ ---------------" A distributed lag analysis " --------------- @
@ ------------------------------------------------------------- @
@ ------------- Authors: Luis Orea and Hervé Dapko ------------ @
@ ------------------------------------------------------------- @
@ ------------------------------------------------------------- @
@ ------------------------------------------------------------- @

@ --------------- SUMMARY OF TASKS & REMARKS ------------------ @
@                                                               @
@ This script file carries out the following TASKS:             @
@                                                               @
@ TASK 1: READING the dataset.                                  @
@ TASK 2: Examination of the structure of the panel dataset.    @
@ TASK 3: Selection of variables for the production model.      @
@ TASK 4: Estimation of basic OLS and ML models.                @
@ TASK 5: ESTIMATION OF FRONTIER MODELS (I).                    @
@   - Standard 1-class heteroscedastic SF model LCM             @
@   - Standard 2-class frontier LCM                             @
@   - 2-class DL-LCM with exogenous lambda (not in the paper)   @
@   - 2-class DL-LCM with endogenous but homoscedastic lambda   @
@   - 2-class DL-LCM with endogenous but heteroscedastic lambda @
@ TASK 6: ESTIMATION OF FRONTIER MODELS (II).                   @
@   - Simplifed codes for the 2-class frontier DL-LCM model     @
@   - 3-class frontier DL-LCM                                   @
@ ------------------------------------------------------------- @


@ ------------------------------------------------------------- @
@ --------------------------- File: --------------------------- @
@ --- 2025_06_19 - Replication file - Non-frontier models ----- @
@ ------------------------------------------------------------- @

This GAUSS file includes codes that allow estimating non-frontier models 
when inefficiency is irrelevant. The error term in this setting is e=v. 

@ ------------------------------------------------------------- @
@ ------------------------------------------------------------- @
@ ----------- COMPLEMENTARY MATERIAL OF THE PAPER ------------- @
@ -- "Latent class models with persistence in regime changes" - @
@ ---------------" A distributed lag analysis " --------------- @
@ ------------------------------------------------------------- @
@ ----------------------- June 20, 2025 ----------------------- @
@ ------------- Authors: Luis Orea and Hervé Dapko ------------ @
@ ------------------------------------------------------------- @
@ ------------------------------------------------------------- @
@   To extend the appealing of our DL-LCM, we also              @
@   provide codes to estimate non-frontier models (up to a      @
@   model with 4 classes) where the noise term is distributed   @
@   as a normal. A hedonic milk price equation is used to       @
@   illustrate these models.                                    @
@ ------------------------------------------------------------- @
@ --------------------- SUMMARY OF TASKS ---------------------- @
@ TASK 1: READING the dataset.                                  @
@ TASK 2: Examination of the structure of the panel dataset.    @
@ TASK 3: Selection of variables for the milk price equation.   @
@ TASK 4: Estimation of basic OLS and ML models.                @
@ TASK 5: ESTIMATION OF NON-FRONTIER MODELS.                    @
@         (only for illustration purposes)                      @
@   - Standard 2-class LCM                                      @
@   - 2-class DL-LCM with exogenous lambda                      @
@   - 2-class DL-LCM with endogenous lambda                     @
@   - 3-class DL-LCM with endogenous lambda                     @
@   - 4-class DL-LCM with endogenous lambda                     @
@ ------------------------------------------------------------- @
@ ------------------------------------------------------------- @


@ ------------------------------------------------------------- @
@ --------------------------- File: --------------------------- @
@ ------------- 2025_05_22 - Replication of figures ----------- @
@ ------------------------------------------------------------- @

This STATA "do" reproduces all figures and several tables included in the paper 
"Latent class models with persistence in regime changes: A distributed lag analysis", 
coauthored by Luis Orea and Hervé Dapko.
More concretely, it reproduces:
Figure 1. Distributions of farm size and lambda. . 
Figure 2. Volatility of the RP ratios and degree of persistence
Appendix 2. Temporal evolution of estimated and simulated RP ratios
Appendix 3. Temporal evolution of estimated RP ratios (using standard and DL specifications of our LCM) 
