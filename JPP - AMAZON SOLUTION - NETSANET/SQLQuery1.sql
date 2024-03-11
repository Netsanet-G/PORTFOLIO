@[User::CategoryOLTPDataFileGenerate]  :-  @[User::OLTPFilesGenerate]+"\\Category_"+ @[User::DateTime]+".csv"

@[User::OLTPFilesGenerate]  :- @[$Project::OLTPFilesGenerate] :- E:\SQL_CLASSES\Senait\SQL\Wondemu_Project\AmazonDWSolution\Stuff\OLTPFilesGenerate

 @[User::DateTime]  :- 20231211 18 31


 @[User::CategoryOLTPDataFileGenerate] :- 
 E:\SQL_CLASSES\Senait\SQL\Wondemu_Project\AmazonDWSolution\Stuff\OLTPFilesGenerate\Category_20231211 18 31.csv