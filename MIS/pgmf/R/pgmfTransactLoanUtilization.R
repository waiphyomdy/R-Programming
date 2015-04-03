#CREATE TABLE public.tbltransact_loanutilization_branchwise
#(
#  transactid integer NOT NULL DEFAULT nextval('tbltransact_loanutilization_branchwise_transactid_seq'::regclass),
#  openinglu_num integer NOT NULL DEFAULT 0,
#  increaselu_num integer NOT NULL DEFAULT 0,
#  decreaselu_num integer NOT NULL DEFAULT 0,
#  closinglu_num integer NOT NULL DEFAULT 0,
#  openinglu_amt double precision NOT NULL DEFAULT 0,
#  increaselu_amt double precision NOT NULL DEFAULT 0,
#  decreaselu_amt double precision NOT NULL DEFAULT 0,
#  closinglu_amt double precision NOT NULL DEFAULT 0,
#  reporting_date date,
#  sectorid_fk integer NOT NULL DEFAULT 0,
#  pro_id_fk integer NOT NULL DEFAULT 0,
#  insert_date timestamp without time zone,
#  CONSTRAINT tbltransact_loanutilization_branchwise_pkey PRIMARY KEY (transactid),
#  CONSTRAINT tbltransact_loan_branchwise_proid_fk_sectorid_fk_fkey FOREIGN KEY (sectorid_fk)
#      REFERENCES public.tblsector (sectorid) MATCH SIMPLE
#      ON UPDATE NO ACTION ON DELETE NO ACTION,
#  CONSTRAINT tbltransact_loanutilization_branchwise_pro_id_fk_fkey FOREIGN KEY (pro_id_fk)
#      REFERENCES public.tblproject (pro_id) MATCH SIMPLE
#      ON UPDATE NO ACTION ON DELETE NO ACTION
#)
#WITH (
#  OIDS=FALSE
#);

pgmf.transact.loanutilization <- function(name, param) {
   stmt <- ""
   err <- ""
   if (name == "pgmf.transact.loanutilization.byid") {
      id <- param["id"]
      stmt <- sprintf("SELECT transactid, openinglu_num, increaselu_num, decreaselu_num, closinglu_num, openinglu_amt, increaselu_amt, decreaselu_amt, closinglu_amt, reporting_date, sectorid_fk, pro_id_fk, insert_date FROM tbltransact_loanutilization_branchwise WHERE transactid='%s';", id)
      err <- paste("ERROR :: Transact Loan Utilization is not found for transactStaffID '%s'", id)
   } else   if (name == "pgmf.transact.loanutilization.byreportdate") {
      code <- param["code"]
      stmt <- sprintf("SELECT transactid, openinglu_num, increaselu_num, decreaselu_num, closinglu_num, openinglu_amt, increaselu_amt, decreaselu_amt, closinglu_amt, reporting_date, sectorid_fk, pro_id_fk, insert_date FROM tbltransact_loanutilization_branchwise WHERE reporting_date='%s';", code)
      err <- paste("ERROR :: Transact Loan Utilization is not found for Reporting Date '%s'", code)
   } else   if (name == "pgmf.transact.loanutilization.bysectorid") {
      id <- param["id"]
      stmt <- sprintf("SELECT transactid, openinglu_num, increaselu_num, decreaselu_num, closinglu_num, openinglu_amt, increaselu_amt, decreaselu_amt, closinglu_amt, reporting_date, sectorid_fk, pro_id_fk, insert_date FROM tbltransact_loanutilization_branchwise WHERE sectorid_fk='%s';", id)
      err <- paste("ERROR :: Transact Loan Utilization is not found for Staff ID '%s'", id)
   } else   if (name == "pgmf.transact.loanutilization.byprojectid") {
      id <- param["id"]
      stmt <- sprintf("SELECT transactid, openinglu_num, increaselu_num, decreaselu_num, closinglu_num, openinglu_amt, increaselu_amt, decreaselu_amt, closinglu_amt, reporting_date, sectorid_fk, pro_id_fk, insert_date FROM tbltransact_loanutilization_branchwise WHERE pro_id_fk='%s';", id)
      err <- paste("ERROR :: Transact Loan Utilization is not found for Project ID '%s'", id)
   } else   if (name == "pgmf.transact.loanutilization.byinsertdate") {
      code <- param["code"]
      stmt <- sprintf("SELECT transactid, openinglu_num, increaselu_num, decreaselu_num, closinglu_num, openinglu_amt, increaselu_amt, decreaselu_amt, closinglu_amt, reporting_date, sectorid_fk, pro_id_fk, insert_date FROM tbltransact_loanutilization_branchwise WHERE insert_date='%s';", code)
      err <- paste("ERROR :: Transact Loan Utilization is not found for Insert Date '%s'", code)
   } else   if (name == "pgmf.get.transact.loanutilization.csv") {
      stmt <- sprintf("SELECT transactid, openinglu_num, increaselu_num, decreaselu_num, closinglu_num, openinglu_amt, increaselu_amt, decreaselu_amt, closinglu_amt, reporting_date, sectorid_fk, pro_id_fk, insert_date FROM tbltransact_loanutilization_branchwise;")
      err <- paste("ERROR :: Transact Loan Utilization is not found")
   }#end of if else nesting

   #rs <- pgmf.get.rows(stmt)
   #if (nrow(rs) == 0) print(err)
   rs <- paste('{"stmt" : "', stmt, '", "err" : "', err, '"}', sep="")
   rs <- fromJSON(rs)
   rs
}#end of pgmf.transact.loanutilization <- function(name, param)

pgmf.set.transact.loanutilization.csv <- function (df) {
   sql <- apply(df, 1, pgmf.transact.loanutilization.format)
   sql
}#end of pgmf.set.transact.loanutilization.csv <- function (df)

pgmf.transact.loanutilization.format <- function(x) {
   transactid <- as.integer(x["transactid"])
   openinglu_num <- as.integer(x["openinglu_num"])
   increaselu_num <- as.integer(x["increaselu_num"])
   decreaselu_num <- as.integer(x["decreaselu_num"])
   closinglu_num <- as.integer(x["closinglu_num"])

   openinglu_amt <- as.integer(x["openinglu_amt"])
   increaselu_amt <- as.integer(x["increaselu_amt"])
   decreaselu_amt <- as.integer(x["decreaselu_amt"])
   closinglu_amt <- as.integer(x["closinglu_amt"])

   reporting_date <- x["reporting_date"]
   sectorid_fk <- as.integer(x["sectorid_fk"])
   pro_id_fk <- as.integer(x["pro_id_fk"])
   insert_date <- x["insert_date"]
   stmt<- sprintf("INSERT INTO tbltransact_loanutilization_branchwise(transactid, openinglu_num, increaselu_num, decreaselu_num, closinglu_num, openinglu_amt, increaselu_amt, decreaselu_amt, closinglu_amt, reporting_date, sectorid_fk, pro_id_fk, insert_date) VALUES (%d, %d, %d, %d, %d, %.2f, %.2f, %.2f, %.2f, '%s', %d, %d, '%s');", transactid, openinglu_num, increaselu_num, decreaselu_num, closinglu_num, openinglu_amt, increaselu_amt, decreaselu_amt, closinglu_amt, reporting_date, sectorid_fk, pro_id_fk, insert_date)
   stmt
}#end of pgmf.transact.loanutilization.format
