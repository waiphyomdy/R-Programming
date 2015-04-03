library(xlsx)
library(jsonlite)

#source("pgmfProject.R")
#source("pgmfProjecttsp.R")
#source("pgmfProduct.R")
#source("pgmfOutreach.R")
#source("pgmfSector.R")
#source("pgmfPortfolio.R")
#source("pgmfStaff.R")
#source("pgmfTransactOutreach.R")
#source("pgmfTransactLoan.R")
#source("pgmfTransactSaving.R")
#source("pgmfTransactStaff.R")
#source("pgmfTransactLoanUtilization.R")
#source("pgmfTransactFinancial.R")
#source("pgmfTransactRepayment.R")
#source("pgmfTransactCollection.R")
#source("pgmfTransactLoanportfolioQuality.R")

pgmf <- function(name, param) {
   if (name == "pgmf.get.project.byid") {
      rs <- pgmf.project(name, param)
      return(rs)
   } else if (name == "pgmf.get.project.bycode") {
      rs <- pgmf.project(name, param)
      return(rs)
   } else if (name == "pgmf.get.project.byname") {
      rs <- pgmf.project(name, param)
      return(rs)
   } else if (name == "pgmf.get.project.csv") {
      rs <- pgmf.project(name, param)
      return(rs)
   } else if (name == "pgmf.set.project.csv") {
      rs <- pgmf.set.project.csv(param)
      return(rs)

   } else if (name == "pgmf.get.projecttsp.byid") {
      rs <- pgmf.projecttsp(name, param)
      return(rs)
   } else if (name == "pgmf.get.projecttsp.byprojectid") {
      rs <- pgmf.projecttsp(name, param)
      return(rs)
   } else if (name == "pgmf.get.projecttsp.bytownshipid") {
      rs <- pgmf.projecttsp(name, param)
      return(rs)
   } else if (name == "pgmf.get.projecttsp.csv") {
      rs <- pgmf.projecttsp(name, param)
      return(rs)
   } else if (name == "pgmf.set.projecttsp.csv") {
      rs <- pgmf.set.projecttsp.csv(param)
      return(rs)

   } else if (name == "pgmf.get.product.byid") {
      rs <- pgmf.product(name, param)
      return(rs)
   } else if (name == "pgmf.get.product.bycode") {
      rs <- pgmf.product(name, param)
      return(rs)
   } else if (name == "pgmf.get.product.byname") {
      rs <- pgmf.product(name, param)
      return(rs)
   } else if (name == "pgmf.get.product.bycat") {
      rs <- pgmf.product(name, param)
      return(rs)
   } else if (name == "pgmf.get.product.csv") {
      rs <- pgmf.product(name, param)
      return(rs)
   } else if (name == "pgmf.set.product.csv") {
      rs <- pgmf.set.product.csv(param)
      return(rs)
   } else if (name == "pgmf.get.outreach.byid") {
      rs <- pgmf.outreach(name, param)
      return(rs)
   } else if (name == "pgmf.get.outreach.byindicator") {
      rs <- pgmf.outreach(name, param)
      return(rs)
   } else if (name == "pgmf.get.outreach.byunit") {
      rs <- pgmf.outreach(name, param)
      return(rs)
   } else if (name == "pgmf.get.outreach.csv") {
      rs <- pgmf.outreach(name, param)
      return(rs)
   } else if (name == "pgmf.set.outreach.csv") {
      rs <- pgmf.set.outreach.csv(param)
      return(rs)
   } else if (name == "pgmf.get.sector.byid") {
      rs <- pgmf.sector(name, param)
      return(rs)
   } else if (name == "pgmf.get.sector.bysector") {
      rs <- pgmf.sector(name, param)
      return(rs)
   } else if (name == "pgmf.get.sector.csv") {
      rs <- pgmf.sector(name, param)
      return(rs)
   } else if (name == "pgmf.set.sector.csv") {
      rs <- pgmf.set.sector.csv(param)
      return(rs)
   } else if (name == "pgmf.get.portfolio.byid") {
      rs <- pgmf.portfolio(name, param)
      return(rs)
   } else if (name == "pgmf.get.portfolio.byportfolio") {
      rs <- pgmf.portfolio(name, param)
      return(rs)
   } else if (name == "pgmf.get.portfolio.csv") {
      rs <- pgmf.portfolio(name, param)
      return(rs)
   } else if (name == "pgmf.set.portfolio.csv") {
      rs <- pgmf.set.portfolio.csv(param)
      return(rs)
   } else if (name == "pgmf.get.staff.byid") {
      rs <- pgmf.staff(name, param)
      return(rs)
   } else if (name == "pgmf.get.staff.bycat") {
      rs <- pgmf.staff(name, param)
      return(rs)
   } else if (name == "pgmf.get.staff.csv") {
      rs <- pgmf.staff(name, param)
      return(rs)
   } else if (name == "pgmf.set.staff.csv") {
      rs <- pgmf.set.staff.csv(param)
      return(rs)
   } else if (name == "pgmf.transact.outreach.byid") {
      rs <- pgmf.transact.outreach(name, param)
      return(rs)
   } else if (name == "pgmf.transact.outreach.byreportdate") {
      rs <- pgmf.transact.outreach(name, param)
      return(rs)
   } else if (name == "pgmf.transact.outreach.byprojectid") {
      rs <- pgmf.transact.outreach(name, param)
      return(rs)
   } else if (name == "pgmf.transact.outreach.byoutreachid") {
      rs <- pgmf.transact.outreach(name, param)
      return(rs)
   } else if (name == "pgmf.transact.outreach.byinsertdate") {
      rs <- pgmf.transact.outreach(name, param)
      return(rs)
   } else if (name == "pgmf.get.transact.outreach.csv") {
      rs <- pgmf.transact.outreach(name, param)
      return(rs)
   } else if (name == "pgmf.set.transact.outreach.csv") {
      rs <- pgmf.set.transact.outreach.csv(param)
      return(rs)
   } else if (name == "pgmf.transact.loan.byid") {
      rs <- pgmf.transact.loan(name, param)
      return(rs)
   } else if (name == "pgmf.transact.loan.byreportdate") {
      rs <- pgmf.transact.loan(name, param)
      return(rs)
   } else if (name == "pgmf.transact.loan.byproductid") {
      rs <- pgmf.transact.loan(name, param)
      return(rs)
   } else if (name == "pgmf.transact.loan.byprojectid") {
      rs <- pgmf.transact.loan(name, param)
      return(rs)
   } else if (name == "pgmf.transact.loan.byinsertdate") {
      rs <- pgmf.transact.loan(name, param)
      return(rs)
   } else if (name == "pgmf.get.transact.loan.csv") {
      rs <- pgmf.transact.loan(name, param)
      return(rs)
   } else if (name == "pgmf.set.transact.loan.csv") {
      rs <- pgmf.set.transact.loan.csv(param)
      return(rs)
   } else if (name == "pgmf.transact.saving.byid") {
      rs <- pgmf.transact.saving(name, param)
      return(rs)
   } else if (name == "pgmf.transact.saving.byreportdate") {
      rs <- pgmf.transact.saving(name, param)
      return(rs)
   } else if (name == "pgmf.transact.saving.byproductid") {
      rs <- pgmf.transact.saving(name, param)
      return(rs)
   } else if (name == "pgmf.transact.saving.byprojectid") {
      rs <- pgmf.transact.saving(name, param)
      return(rs)
   } else if (name == "pgmf.transact.saving.byinsertdate") {
      rs <- pgmf.transact.saving(name, param)
      return(rs)
   } else if (name == "pgmf.get.transact.saving.csv") {
      rs <- pgmf.transact.saving(name, param)
      return(rs)
   } else if (name == "pgmf.set.transact.saving.csv") {
      rs <- pgmf.set.transact.saving.csv(param)
      return(rs)
   } else if (name == "pgmf.transact.staff.byid") {
      rs <- pgmf.transact.staff(name, param)
      return(rs)
   } else if (name == "pgmf.transact.staff.byreportdate") {
      rs <- pgmf.transact.staff(name, param)
      return(rs)
   } else if (name == "pgmf.transact.staff.bystaffid") {
      rs <- pgmf.transact.staff(name, param)
      return(rs)
   } else if (name == "pgmf.transact.staff.byprojectid") {
      rs <- pgmf.transact.staff(name, param)
      return(rs)
   } else if (name == "pgmf.transact.staff.byinsertdate") {
      rs <- pgmf.transact.staff(name, param)
      return(rs)
   } else if (name == "pgmf.get.transact.staff.csv") {
      rs <- pgmf.transact.staff(name, param)
      return(rs)
   } else if (name == "pgmf.set.transact.staff.csv") {
      rs <- pgmf.set.transact.staff.csv(param)
      return(rs)
   } else if (name == "pgmf.transact.loanutilization.byid") {
      rs <- pgmf.transact.loanutilization(name, param)
      return(rs)
   } else if (name == "pgmf.transact.loanutilization.byreportdate") {
      rs <- pgmf.transact.loanutilization(name, param)
      return(rs)
   } else if (name == "pgmf.transact.loanutilization.bysectorid") {
      rs <- pgmf.transact.loanutilization(name, param)
      return(rs)
   } else if (name == "pgmf.transact.loanutilization.byprojectid") {
      rs <- pgmf.transact.loanutilization(name, param)
      return(rs)
   } else if (name == "pgmf.transact.loanutilization.byinsertdate") {
      rs <- pgmf.transact.loanutilization(name, param)
      return(rs)
   } else if (name == "pgmf.get.transact.loanutilization.csv") {
      rs <- pgmf.transact.loanutilization(name, param)
      return(rs)
   } else if (name == "pgmf.set.transact.loanutilization.csv") {
      rs <- pgmf.set.transact.loanutilization.csv(param)
      return(rs)
   } else if (name == "pgmf.transact.financial.byid") {
      rs <- pgmf.transact.financial(name, param)
      return(rs)
   } else if (name == "pgmf.transact.financial.byreportdate") {
      rs <- pgmf.transact.financial(name, param)
      return(rs)
   } else if (name == "pgmf.transact.financial.byprojectid") {
      rs <- pgmf.transact.financial(name, param)
      return(rs)
   } else if (name == "pgmf.transact.financial.byinsertdate") {
      rs <- pgmf.transact.financial(name, param)
      return(rs)
   } else if (name == "pgmf.get.transact.financial.csv") {
      rs <- pgmf.transact.financial(name, param)
      return(rs)
   } else if (name == "pgmf.set.transact.financial.csv") {
      rs <- pgmf.set.transact.financial.csv(param)
      return(rs)
   } else if (name == "pgmf.transact.repayment.byid") {
      rs <- pgmf.transact.repayment(name, param)
      return(rs)
   } else if (name == "pgmf.transact.repayment.byreportdate") {
      rs <- pgmf.transact.repayment(name, param)
      return(rs)
   } else if (name == "pgmf.transact.repayment.byprojectid") {
      rs <- pgmf.transact.repayment(name, param)
      return(rs)
   } else if (name == "pgmf.transact.repayment.byinsertdate") {
      rs <- pgmf.transact.repayment(name, param)
      return(rs)
   } else if (name == "pgmf.get.transact.repayment.csv") {
      rs <- pgmf.transact.repayment(name, param)
      return(rs)
   } else if (name == "pgmf.set.transact.repayment.csv") {
      rs <- pgmf.set.transact.repayment.csv(param)
      return(rs)
   } else if (name == "pgmf.transact.collection.byid") {
      rs <- pgmf.transact.collection(name, param)
      return(rs)
   } else if (name == "pgmf.transact.collection.byreportdate") {
      rs <- pgmf.transact.collection(name, param)
      return(rs)
   } else if (name == "pgmf.transact.collection.byprojectid") {
      rs <- pgmf.transact.collection(name, param)
      return(rs)
   } else if (name == "pgmf.transact.collection.byinsertdate") {
      rs <- pgmf.transact.collection(name, param)
      return(rs)
   } else if (name == "pgmf.get.transact.collection.csv") {
      rs <- pgmf.transact.collection(name, param)
      return(rs)
   } else if (name == "pgmf.set.transact.collection.csv") {
      rs <- pgmf.set.transact.collection.csv(param)
      return(rs)
   } else if (name == "pgmf.transact.loanportfolioquality.byid") {
      rs <- pgmf.transact.loanportfolioquality(name, param)
      return(rs)
   } else if (name == "pgmf.transact.loanportfolioquality.byreportdate") {
      rs <- pgmf.transact.loanportfolioquality(name, param)
      return(rs)
   } else if (name == "pgmf.transact.loanportfolioquality.byportfolioid") {
      rs <- pgmf.transact.loanportfolioquality(name, param)
      return(rs)
   } else if (name == "pgmf.transact.loanportfolioquality.byprojectid") {
      rs <- pgmf.transact.loanportfolioquality(name, param)
      return(rs)
   } else if (name == "pgmf.transact.loanportfolioquality.byinsertdate") {
      rs <- pgmf.transact.loanportfolioquality(name, param)
      return(rs)
   } else if (name == "pgmf.get.transact.loanportfolioquality.csv") {
      rs <- pgmf.transact.loanportfolioquality(name, param)
      return(rs)
   } else if (name == "pgmf.set.transact.loanportfolioquality.csv") {
      rs <- pgmf.set.transact.loanportfolioquality.csv(param)
      return(rs)

   }#end of if else nesting
}#end of  pgmf <- function(name, param)

