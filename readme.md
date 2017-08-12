# GUI Module for Small Area Estimation with Measurement Error
This is the GUI version of `saeme` package which contains all the features of `saeme` package with some additional features. The additional features include:
* Data management
* Results download

Installation
----
1. Preparation
	* Download the source code
	* Exctract to R project directory
2. Dependencies
	* Open R project
	* Install the following package
	    * shiny
    	    ```
    	    install.packages('shiny')
    	    ```
		* shinytheme
    	    ```
    	    install.packages('shinytheme')
    	    ```
		* DT
    	    ```
    	    install.packages('DT')
    	    ```
		* saeme
    	    ```
    	    devtools::install_github('aminfathullah/saeme')
    	    ```
        * plotly
    	    ```
    	    install.packages('plotly')
    	    ```
        * shinycssloaders
    	    ```
    	    install.packages('shinycssloaders')
    	    ```
3. Open Program
	* Open the R project
	* Execute program
	```
	shiny::runApp('fast-saeme-master', launch.browser = T)
	```

Usage
----
 1. Import data
 	* In `Data management`, click `browse`
 2. Select variables
 	* In `Small Area Estimation`, specify the following variables:
 		* Direct estimation
 		* MSE of direct estimation
 		* Auxiliary variables
 		* MSE of auxiliary variables
 3. Execute
 	* Click `calculate` button to execute.
 	* `Estimation` tab will show the estimation values of 
 		* beta coeficient
 		* y
 		* gamma, and
 		* MSE
 	* `Plot` tab will show the scatter plot between MSE from direct estimation and MSE from SAE with measurement error
 4. Download the results
 	* Choose the document type
 	* Click `downloads`

References
----
[1] Ybarra, L. M., & Lohr, S. L. (2008). Small area estimation when auxiliary information is measured with error. Biometrika, 919-931.