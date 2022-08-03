# Katagraphos - Store records with Excel Spreadsheets in GitHub 

Katagraphos is a PowerShell RESTful API microservice that facilitates writes and reads of Excel spreadsheets which are then stored in GitHub.  

`Excel` was chosen as a primary file format to store textual records as it is useful for:

1. Tabular data (lists, tables ... )
1. Built in Authenticaion ( Optional Password protection )
1. Graph Visulizations
1. Pivot tables
1. Numerous other Excel features such as ...?


`GitHub as a datastore` was chosen as it has the following properties:

1. Secure and Availible 
1. Private or Public visibility
1. Version control
1. Free 
1. Permanent 
1. Owned and backed by Microsoft



## Under the hood
This API is made possible by leveraging the following OpenSource PowerShell Modules

1. [ImportExcel](https://github.com/dfinke/ImportExcel), authored by Douglas Finke
1. [PSAdvantage](https://github.com/dfinke/PSAdvantage), authored by Douglas Finke
1. [Pode](https://github.com/Badgerati/Pode.Web), authored by Matthew Kelly (aka Badgerati)




### Draft if a ever presentation

## What you will learn
1. How to create, update and read records in Excel spreadsheets, using the `ImportExcel` PowerShell module.  
1. Use Microsoft Excel password protection feature to secure your records.
1. How to save and retrieve records using the PowerShell module, `PSAdvantage` to and from a GitHub repository.
1. Use the PowerShell `Pode` Module to create a RESTful API 


1. How to manage your data by following along a demo using a simple webfront end (tbd - REACT ...)
