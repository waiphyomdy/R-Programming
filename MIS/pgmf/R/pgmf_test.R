library(RPostgreSQL)
library(pgmf)
#source("pgmf.R")

dsn.str <- '{"dbname" : "pgmfMIS", "host" : "192.168.1.21", "port" : 5432, "user" : "postgres", "password" : "postgres"}'
drv <- dbDriver("PostgreSQL")

pgmf.get.connection <- function (dsn) {
   dsn <- fromJSON(dsn)
   con <- dbConnect(drv, dbname=dsn["dbname"], host=dsn["host"], port=dsn["port"], user=dsn["user"], password=dsn["password"])
   con
}# end of pgmf.get.connection <- function (dsn)

pgmf.get.rows <- function (stmt) {
   con <- pgmf.get.connection(dsn.str)
   rs = dbSendQuery(con, stmt)
   st = fetch(rs,n=-1)
   dbDisconnect(con)
   st 
}#end of pgmf.get.rows <- function (stmt)

test <- function() {
   testProject()
   #testProjecttsp()
   #testProduct()
   #testOutreach()
   #testSector()
   #testPortfolio()
   #testStaff()
   #testTransactOutreach()
   #testTransactLoan()
   #testTransactSaving()
   #testTransactStaff()
   #testTransactLoanUtilization()
   #testTransactFinancial()
   #testTransactRepayment()
   #testTransactCollection()
   testTransactLoanportfolioQuality
}#end of test <- function()

testTransactLoanportfolioQuality <- function() {
   name <- "pgmf.transact.loanportfolioquality.byid"
   param <- '{"id" : "1"}'
   rs <- pgmf(name, fromJSON(param))
   rs <- pgmf.get.rows(rs$stmt)
   print(rs)

   name <- "pgmf.transact.loanportfolioquality.byreportdate"
   param <- '{"code" : "2015-01-31"}'
   rs <- pgmf(name, fromJSON(param))
   rs <- pgmf.get.rows(rs$stmt)
   print(rs)

   name <- "pgmf.transact.loanportfolioquality.byportfolioid"
   param <- '{"id" : "1"}'
   rs <- pgmf(name, fromJSON(param))
   rs <- pgmf.get.rows(rs$stmt)
   print(rs)

   name <- "pgmf.transact.loanportfolioquality.byprojectid"
   param <- '{"id" : "56"}'
   rs <- pgmf(name, fromJSON(param))
   rs <- pgmf.get.rows(rs$stmt)
   print(rs)

   #name <- "pgmf.transact.loanportfolioquality.byinsertdate"
   #param <- '{"code" : "2015-01-31"}'
   #rs <- pgmf(name, fromJSON(param))
   #print(rs)

   name <- "pgmf.get.transact.loanportfolioquality.csv"
   param <- '{"" : ""}'
   rs <- pgmf(name, fromJSON(param))
   csv <- pgmf.get.rows(rs$stmt)
   #print(csv)

   name <- "pgmf.set.transact.loanportfolioquality.csv"
   param <- '{"" : ""}'
   rs <- pgmf(name, csv)
   print(rs)
}#end of testTransactLoanportfolioQuality <- function()

testTransactCollection <- function() {
   name <- "pgmf.transact.collection.byid"
   param <- '{"id" : "1"}'
   rs <- pgmf(name, fromJSON(param))
   rs <- pgmf.get.rows(rs$stmt)
   print(rs)

   name <- "pgmf.transact.collection.byreportdate"
   param <- '{"code" : "2015-01-31"}'
   rs <- pgmf(name, fromJSON(param))
   rs <- pgmf.get.rows(rs$stmt)
   print(rs)

   name <- "pgmf.transact.collection.byprojectid"
   param <- '{"id" : "56"}'
   rs <- pgmf(name, fromJSON(param))
   rs <- pgmf.get.rows(rs$stmt)
   print(rs)

   #name <- "pgmf.transact.collection.byinsertdate"
   #param <- '{"code" : "2015-01-31"}'
   #rs <- pgmf(name, fromJSON(param))
   #print(rs)

   name <- "pgmf.get.transact.collection.csv"
   param <- '{"" : ""}'
   rs <- pgmf(name, fromJSON(param))
   csv <- pgmf.get.rows(rs$stmt)
   #print(csv)

   name <- "pgmf.set.transact.collection.csv"
   param <- '{"" : ""}'
   rs <- pgmf(name, csv)
   print(rs)
}#end of testTransactCollection <- function()

testTransactRepayment <- function() {
   name <- "pgmf.transact.repayment.byid"
   param <- '{"id" : "1"}'
   rs <- pgmf(name, fromJSON(param))
   rs <- pgmf.get.rows(rs$stmt)
   print(rs)

   name <- "pgmf.transact.repayment.byreportdate"
   param <- '{"code" : "2015-01-31"}'
   rs <- pgmf(name, fromJSON(param))
   rs <- pgmf.get.rows(rs$stmt)
   print(rs)

   name <- "pgmf.transact.repayment.byprojectid"
   param <- '{"id" : "56"}'
   rs <- pgmf(name, fromJSON(param))
   rs <- pgmf.get.rows(rs$stmt)
   print(rs)

   #name <- "pgmf.transact.repayment.byinsertdate"
   #param <- '{"code" : "2015-01-31"}'
   #rs <- pgmf(name, fromJSON(param))
   #print(rs)

   name <- "pgmf.get.transact.repayment.csv"
   param <- '{"" : ""}'
   rs <- pgmf(name, fromJSON(param))
   csv <- pgmf.get.rows(rs$stmt)
   #print(csv)

   name <- "pgmf.set.transact.repayment.csv"
   param <- '{"" : ""}'
   rs <- pgmf(name, csv)
   print(rs)
}#end of testTransactRepayment <- function()

testTransactFinancial <- function() {
   name <- "pgmf.transact.financial.byid"
   param <- '{"id" : "1"}'
   rs <- pgmf(name, fromJSON(param))
   rs <- pgmf.get.rows(rs$stmt)
   print(rs)

   name <- "pgmf.transact.financial.byreportdate"
   param <- '{"code" : "2015-01-31"}'
   rs <- pgmf(name, fromJSON(param))
   rs <- pgmf.get.rows(rs$stmt)
   print(rs)

   name <- "pgmf.transact.financial.byprojectid"
   param <- '{"id" : "56"}'
   rs <- pgmf(name, fromJSON(param))
   rs <- pgmf.get.rows(rs$stmt)
   print(rs)

   #name <- "pgmf.transact.financial.byinsertdate"
   #param <- '{"code" : "2015-01-31"}'
   #rs <- pgmf(name, fromJSON(param))
   #print(rs)

   name <- "pgmf.get.transact.financial.csv"
   param <- '{"" : ""}'
   rs <- pgmf(name, fromJSON(param))
   csv <- pgmf.get.rows(rs$stmt)
   #print(csv)

   name <- "pgmf.set.transact.financial.csv"
   param <- '{"" : ""}'
   rs <- pgmf(name, csv)
   print(rs)
}#end of testTransactFinancial <- function()

testTransactLoanUtilization <- function() {
   name <- "pgmf.transact.loanutilization.byid"
   param <- '{"id" : "1"}'
   rs <- pgmf(name, fromJSON(param))
   rs <- pgmf.get.rows(rs$stmt)
   print(rs)

   name <- "pgmf.transact.loanutilization.byreportdate"
   param <- '{"code" : "2015-01-31"}'
   rs <- pgmf(name, fromJSON(param))
   rs <- pgmf.get.rows(rs$stmt)
   print(rs)

   name <- "pgmf.transact.loanutilization.bysectorid"
   param <- '{"id" : "1"}'
   rs <- pgmf(name, fromJSON(param))
   rs <- pgmf.get.rows(rs$stmt)
   print(rs)

   name <- "pgmf.transact.loanutilization.byprojectid"
   param <- '{"id" : "56"}'
   rs <- pgmf(name, fromJSON(param))
   rs <- pgmf.get.rows(rs$stmt)
   print(rs)

   #name <- "pgmf.transact.loanutilization.byinsertdate"
   #param <- '{"code" : "2015-01-31"}'
   #rs <- pgmf(name, fromJSON(param))
   #print(rs)

   name <- "pgmf.get.transact.loanutilization.csv"
   param <- '{"" : ""}'
   rs <- pgmf(name, fromJSON(param))
   csv <- pgmf.get.rows(rs$stmt)
   #print(csv)

   name <- "pgmf.set.transact.loanutilization.csv"
   param <- '{"" : ""}'
   rs <- pgmf(name, csv)
   print(rs)
}#end of testTransactLoanUtilization <- function()

testTransactStaff <- function() {
   name <- "pgmf.transact.staff.byid"
   param <- '{"id" : "1"}'
   rs <- pgmf(name, fromJSON(param))
   rs <- pgmf.get.rows(rs$stmt)
   print(rs)

   name <- "pgmf.transact.staff.byreportdate"
   param <- '{"code" : "2015-01-31"}'
   rs <- pgmf(name, fromJSON(param))
   rs <- pgmf.get.rows(rs$stmt)
   print(rs)

   name <- "pgmf.transact.staff.bystaffid"
   param <- '{"id" : "1"}'
   rs <- pgmf(name, fromJSON(param))
   rs <- pgmf.get.rows(rs$stmt)
   print(rs)

   name <- "pgmf.transact.staff.byprojectid"
   param <- '{"id" : "56"}'
   rs <- pgmf(name, fromJSON(param))
   rs <- pgmf.get.rows(rs$stmt)
   print(rs)

   #name <- "pgmf.transact.staff.byinsertdate"
   #param <- '{"code" : "2015-01-31"}'
   #rs <- pgmf(name, fromJSON(param))
   #print(rs)

   name <- "pgmf.get.transact.staff.csv"
   param <- '{"" : ""}'
   rs <- pgmf(name, fromJSON(param))
   csv <- pgmf.get.rows(rs$stmt)
   #print(csv)

   name <- "pgmf.set.transact.staff.csv"
   param <- '{"" : ""}'
   rs <- pgmf(name, csv)
   print(rs)
}#end of testTransactStaff <- function()

testTransactSaving <- function() {
   name <- "pgmf.transact.saving.byid"
   param <- '{"id" : "1197"}'
   rs <- pgmf(name, fromJSON(param))
   rs <- pgmf.get.rows(rs$stmt)
   print(rs)

   name <- "pgmf.transact.saving.byreportdate"
   param <- '{"code" : "2015-01-31"}'
   rs <- pgmf(name, fromJSON(param))
   rs <- pgmf.get.rows(rs$stmt)
   print(rs)

   name <- "pgmf.transact.saving.byproductid"
   param <- '{"id" : "1"}'
   rs <- pgmf(name, fromJSON(param))
   rs <- pgmf.get.rows(rs$stmt)
   print(rs)

   name <- "pgmf.transact.saving.byprojectid"
   param <- '{"id" : "56"}'
   rs <- pgmf(name, fromJSON(param))
   rs <- pgmf.get.rows(rs$stmt)
   print(rs)

   #name <- "pgmf.transact.saving.byinsertdate"
   #param <- '{"code" : "2015-01-31"}'
   #rs <- pgmf(name, fromJSON(param))
   #print(rs)

   name <- "pgmf.get.transact.saving.csv"
   param <- '{"" : ""}'
   rs <- pgmf(name, fromJSON(param))
   csv <- pgmf.get.rows(rs$stmt)
   #print(csv)

   name <- "pgmf.set.transact.saving.csv"
   param <- '{"" : ""}'
   rs <- pgmf(name, csv)
   print(rs)
}#end of testTransactSaving <- function()

testTransactLoan <- function() {
   name <- "pgmf.transact.loan.byid"
   param <- '{"id" : "8460"}'
   rs <- pgmf(name, fromJSON(param))
   rs <- pgmf.get.rows(rs$stmt)
   print(rs)

   name <- "pgmf.transact.loan.byreportdate"
   param <- '{"code" : "2015-01-31"}'
   rs <- pgmf(name, fromJSON(param))
   rs <- pgmf.get.rows(rs$stmt)
   print(rs)

   name <- "pgmf.transact.loan.byproductid"
   param <- '{"id" : "4"}'
   rs <- pgmf(name, fromJSON(param))
   rs <- pgmf.get.rows(rs$stmt)
   print(rs)

   name <- "pgmf.transact.loan.byprojectid"
   param <- '{"id" : "170"}'
   rs <- pgmf(name, fromJSON(param))
   rs <- pgmf.get.rows(rs$stmt)
   print(rs)

   #name <- "pgmf.transact.loan.byinsertdate"
   #param <- '{"code" : "2015-01-31"}'
   #rs <- pgmf(name, fromJSON(param))
   #print(rs)

   name <- "pgmf.get.transact.loan.csv"
   param <- '{"" : ""}'
   rs <- pgmf(name, fromJSON(param))
   csv <- pgmf.get.rows(rs$stmt)
   #print(csv)

   name <- "pgmf.set.transact.loan.csv"
   param <- '{"" : ""}'
   rs <- pgmf(name, csv)
   print(rs)
}#end of testTransactLoan <- function()

testTransactOutreach <- function() {
   name <- "pgmf.transact.outreach.byid"
   param <- '{"id" : "9385"}'
   rs <- pgmf(name, fromJSON(param))
   rs <- pgmf.get.rows(rs$stmt)
   print(rs)

   name <- "pgmf.transact.outreach.byreportdate"
   param <- '{"code" : "2015-01-31"}'
   rs <- pgmf(name, fromJSON(param))
   rs <- pgmf.get.rows(rs$stmt)
   print(rs)

   name <- "pgmf.transact.outreach.byprojectid"
   param <- '{"id" : "56"}'
   rs <- pgmf(name, fromJSON(param))
   rs <- pgmf.get.rows(rs$stmt)
   print(rs)

   name <- "pgmf.transact.outreach.byoutreachid"
   param <- '{"id" : "8"}'
   rs <- pgmf(name, fromJSON(param))
   rs <- pgmf.get.rows(rs$stmt)
   print(rs)

   #name <- "pgmf.transact.outreach.byinsertdate"
   #param <- '{"code" : "2015-01-31"}'
   #rs <- pgmf(name, fromJSON(param))
   #print(rs)

   name <- "pgmf.get.transact.outreach.csv"
   param <- '{"" : ""}'
   rs <- pgmf(name, fromJSON(param))
   csv <- pgmf.get.rows(rs$stmt)
   #print(csv)

   name <- "pgmf.set.transact.outreach.csv"
   param <- '{"" : ""}'
   rs <- pgmf(name, csv)
   print(rs)
}#end of testTransactOutreach <- function()

testStaff <- function() {
   name <- "pgmf.get.staff.byid"
   param <- '{"id" : "1"}'
   rs <- pgmf(name, fromJSON(param))
   rs <- pgmf.get.rows(rs$stmt)
   print(rs)

   name <- "pgmf.get.staff.bycat"
   param <- '{"code" : "Portfolio at risk (PAR) > 1 day"}'
   rs <- pgmf(name, fromJSON(param))
   rs <- pgmf.get.rows(rs$stmt)
   print(rs)

   name <- "pgmf.get.staff.csv"
   param <- '{"" : ""}'
   rs <- pgmf(name, fromJSON(param))
   csv <- pgmf.get.rows(rs$stmt)
   #print(csv)

   name <- "pgmf.set.staff.csv"
   param <- '{"" : ""}'
   rs <- pgmf(name, csv)
   print(rs)
}#end of testStaff <- function()

testPortfolio <- function() {
   name <- "pgmf.get.portfolio.byid"
   param <- '{"id" : "1"}'
   rs <- pgmf(name, fromJSON(param))
   rs <- pgmf.get.rows(rs$stmt)
   print(rs)

   name <- "pgmf.get.portfolio.byportfolio"
   param <- '{"code" : "Portfolio at risk (PAR) > 1 day"}'
   rs <- pgmf(name, fromJSON(param))
   rs <- pgmf.get.rows(rs$stmt)
   print(rs)

   name <- "pgmf.get.portfolio.csv"
   param <- '{"" : ""}'
   rs <- pgmf(name, fromJSON(param))
   csv <- pgmf.get.rows(rs$stmt)
   #print(csv)

   name <- "pgmf.set.portfolio.csv"
   param <- '{"" : ""}'
   rs <- pgmf(name, csv)
   print(rs)
}#end of testPortfolio <- function()

testSector <- function() {
   name <- "pgmf.get.sector.byid"
   param <- '{"id" : "1"}'
   rs <- pgmf(name, fromJSON(param))
   rs <- pgmf.get.rows(rs$stmt)
   print(rs)

   name <- "pgmf.get.sector.bysector"
   param <- '{"code" : "Agriculture"}'
   rs <- pgmf(name, fromJSON(param))
   rs <- pgmf.get.rows(rs$stmt)
   print(rs)

   name <- "pgmf.get.sector.csv"
   param <- '{"" : ""}'
   rs <- pgmf(name, fromJSON(param))
   csv <- pgmf.get.rows(rs$stmt)
   #print(csv)

   name <- "pgmf.set.sector.csv"
   param <- '{"" : ""}'
   rs <- pgmf(name, csv)
   print(rs)
}#end of testSector <- function()

testOutreach <- function() {
   name <- "pgmf.get.outreach.byid"
   param <- '{"id" : "1"}'
   rs <- pgmf(name, fromJSON(param))
   rs <- pgmf.get.rows(rs$stmt)
   print(rs)

   name <- "pgmf.get.outreach.byindicator"
   param <- '{"code" : "Village Tracts"}'
   rs <- pgmf(name, fromJSON(param))
   rs <- pgmf.get.rows(rs$stmt)
   print(rs)

   name <- "pgmf.get.outreach.byunit"
   param <- '{"name" : "Number"}'
   rs <- pgmf(name, fromJSON(param))
   rs <- pgmf.get.rows(rs$stmt)
   print(rs)

   name <- "pgmf.get.outreach.csv"
   param <- '{"" : ""}'
   rs <- pgmf(name, fromJSON(param))
   csv <- pgmf.get.rows(rs$stmt)
   #print(csv)

   name <- "pgmf.set.outreach.csv"
   param <- '{"" : ""}'
   rs <- pgmf(name, csv)
   print(rs)
}#end of testOutreach <- function()

testProduct <- function() {
   name <- "pgmf.get.product.byid"
   param <- '{"id" : "1"}'
   rs <- pgmf(name, fromJSON(param))
   rs <- pgmf.get.rows(rs$stmt)
   print(rs)

   name <- "pgmf.get.product.bycode"
   param <- '{"code" : "101"}'
   rs <- pgmf(name, fromJSON(param))
   rs <- pgmf.get.rows(rs$stmt)
   print(rs)

   name <- "pgmf.get.product.byname"
   param <- '{"name" : "Compulsory Saving"}'
   rs <- pgmf(name, fromJSON(param))
   rs <- pgmf.get.rows(rs$stmt)
   print(rs)

   name <- "pgmf.get.product.bycat"
   param <- '{"name" : "Saving"}'
   rs <- pgmf(name, fromJSON(param))
   rs <- pgmf.get.rows(rs$stmt)
   print(rs)

   name <- "pgmf.get.product.csv"
   param <- '{"" : ""}'
   rs <- pgmf(name, fromJSON(param))
   csv <- pgmf.get.rows(rs$stmt)
   #print(csv)

   name <- "pgmf.set.product.csv"
   param <- '{"" : ""}'
   rs <- pgmf(name, csv)
   print(rs)
}#end of testProduct <- function()

testProjecttsp <- function() {
   name <- "pgmf.get.projecttsp.byid"
   param <- '{"id" : "1"}'
   rs <- pgmf(name, fromJSON(param))
   rs <- pgmf.get.rows(rs$stmt)
   print(rs)

   name <- "pgmf.get.projecttsp.byprojectid"
   param <- '{"id" : "1"}'
   rs <- pgmf(name, fromJSON(param))
   rs <- pgmf.get.rows(rs$stmt)
   print(rs)

   name <- "pgmf.get.projecttsp.bytownshipid"
   param <- '{"id" : "1"}'
   rs <- pgmf(name, fromJSON(param))
   rs <- pgmf.get.rows(rs$stmt)
   print(rs)

   name <- "pgmf.get.projecttsp.csv"
   param <- '{"" : ""}'
   rs <- pgmf(name, fromJSON(param))
   csv <- pgmf.get.rows(rs$stmt)
   #print(csv)

   name <- "pgmf.set.projecttsp.csv"
   param <- '{"" : ""}'
   rs <- pgmf(name, csv)
   print(rs)
}#end of testProjecttsp <- function()

testProject <- function() {
   name <- "pgmf.get.project.byid"
   param <- '{"id" : "1"}'
   rs <- pgmf(name, fromJSON(param))
   rs <- pgmf.get.rows(rs$stmt)
   print(rs)

   name <- "pgmf.get.project.bycode"
   param <- '{"code" : "TWG"}'
   rs <- pgmf(name, fromJSON(param))
   rs <- pgmf.get.rows(rs$stmt)
   print(rs)

   name <- "pgmf.get.project.byname"
   param <- '{"name" : "Taungdwingyi HUB Office"}'
   rs <- pgmf(name, fromJSON(param))
   rs <- pgmf.get.rows(rs$stmt)
   print(rs)

   name <- "pgmf.get.project.csv"
   param <- '{"" : ""}'
   rs <- pgmf(name, fromJSON(param))
   csv <- pgmf.get.rows(rs$stmt)
   #print(csv)

   name <- "pgmf.set.project.csv"
   param <- '{"" : ""}'
   rs <- pgmf(name, csv)
   print(rs)
}#end of testProject <- function()

