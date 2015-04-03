#CREATE TABLE public.tbltransact_financial_branchwise
#(
#  transactid integer NOT NULL DEFAULT nextval('tbltransact_financial_branchwise_transactid_seq'::regclass),
#  openingrevenue_amt double precision NOT NULL DEFAULT 0,
#  increaserevenue_amt double precision NOT NULL DEFAULT 0,
#  decreaserevenue_amt double precision NOT NULL DEFAULT 0,
#  closingrevenue_amt double precision NOT NULL DEFAULT 0,
#  openingexpenditure_amt double precision NOT NULL DEFAULT 0,
#  increaseexpenditure_amt double precision NOT NULL DEFAULT 0,
#  decreaseexpenditure_amt double precision NOT NULL DEFAULT 0,
#  closingexpenditure_amt double precision NOT NULL DEFAULT 0,
#  reporting_date date,
#  pro_id_fk integer NOT NULL,
#  insert_date timestamp without time zone,
#  CONSTRAINT tbltransact_financial_branchwise_pkey PRIMARY KEY (transactid),
#  CONSTRAINT tbltransact_financial_branchwise_pro_id_fk_fkey FOREIGN KEY (pro_id_fk)
#      REFERENCES public.tblproject (pro_id) MATCH SIMPLE
#      ON UPDATE NO ACTION ON DELETE NO ACTION
#)
#WITH (
#  OIDS=FALSE
#);

pgmf.transact.financial <- function(name, param) {
   stmt <- ""
   err <- ""
   if (name == "pgmf.transact.financial.byid") {
      id <- param["id"]
      stmt <- sprintf("SELECT transactid, openingrevenue_amt, increaserevenue_amt, decreaserevenue_amt, closingrevenue_amt, openingexpenditure_amt, increaseexpenditure_amt, decreaseexpenditure_amt, closingexpenditure_amt, reporting_date, pro_id_fk, insert_date FROM tbltransact_financial_branchwise WHERE transactid='%s';", id)
      err <- paste("ERROR :: Transact Financial is not found for transactID '%s'", id)
   } else   if (name == "pgmf.transact.financial.byreportdate") {
      code <- param["code"]
      stmt <- sprintf("SELECT transactid, openingrevenue_amt, increaserevenue_amt, decreaserevenue_amt, closingrevenue_amt, openingexpenditure_amt, increaseexpenditure_amt, decreaseexpenditure_amt, closingexpenditure_amt, reporting_date, pro_id_fk, insert_date FROM tbltransact_financial_branchwise WHERE reporting_date='%s';", code)
      err <- paste("ERROR :: Transact Financial is not found for Reporting Date '%s'", code)
   } else   if (name == "pgmf.transact.financial.byprojectid") {
      id <- param["id"]
      stmt <- sprintf("SELECT transactid, openingrevenue_amt, increaserevenue_amt, decreaserevenue_amt, closingrevenue_amt, openingexpenditure_amt, increaseexpenditure_amt, decreaseexpenditure_amt, closingexpenditure_amt, reporting_date, pro_id_fk, insert_date FROM tbltransact_financial_branchwise WHERE pro_id_fk='%s';", id)
      err <- paste("ERROR :: Transact Financial is not found for Project ID '%s'", id)
   } else   if (name == "pgmf.transact.financial.byinsertdate") {
      code <- param["code"]
      stmt <- sprintf("SELECT transactid, openingrevenue_amt, increaserevenue_amt, decreaserevenue_amt, closingrevenue_amt, openingexpenditure_amt, increaseexpenditure_amt, decreaseexpenditure_amt, closingexpenditure_amt, reporting_date, pro_id_fk, insert_date FROM tbltransact_financial_branchwise WHERE insert_date='%s';", code)
      err <- paste("ERROR :: Transact Loan Utilization is not found for Insert Date '%s'", code)
   } else   if (name == "pgmf.get.transact.financial.csv") {
      stmt <- sprintf("SELECT transactid, openingrevenue_amt, increaserevenue_amt, decreaserevenue_amt, closingrevenue_amt, openingexpenditure_amt, increaseexpenditure_amt, decreaseexpenditure_amt, closingexpenditure_amt, reporting_date, pro_id_fk, insert_date FROM tbltransact_financial_branchwise;")
      err <- paste("ERROR :: Transact Financial is not found")
   }#end of if else nesting

   #rs <- pgmf.get.rows(stmt)
   #if (nrow(rs) == 0) print(err)
   rs <- paste('{"stmt" : "', stmt, '", "err" : "', err, '"}', sep="")
   rs <- fromJSON(rs)
   rs
}#end of pgmf.transact.financial <- function(name, param)

pgmf.set.transact.financial.csv <- function (df) {
   sql <- apply(df, 1, pgmf.transact.financial.format)
   sql
}#end of pgmf.set.transact.financial.csv <- function (df)

pgmf.transact.financial.format <- function(x) {
   transactid <- as.integer(x["transactid"])
   openingrevenue_amt <- as.integer(x["openingrevenue_amt"])
   increaserevenue_amt <- as.integer(x["increaserevenue_amt"])
   decreaserevenue_amt <- as.integer(x["decreaserevenue_amt"])
   closingrevenue_amt <- as.integer(x["closingrevenue_amt"])

   openingexpenditure_amt <- as.integer(x["openingexpenditure_amt"])
   increaseexpenditure_amt <- as.integer(x["increaseexpenditure_amt"])
   decreaseexpenditure_amt <- as.integer(x["decreaseexpenditure_amt"])
   closingexpenditure_amt <- as.integer(x["closingexpenditure_amt"])

   reporting_date <- x["reporting_date"]
   sectorid_fk <- as.integer(x["sectorid_fk"])
   pro_id_fk <- as.integer(x["pro_id_fk"])
   insert_date <- x["insert_date"]
   stmt<- sprintf("INSERT INTO tbltransact_financial_branchwise(transactid, openingrevenue_amt, increaserevenue_amt, decreaserevenue_amt, closingrevenue_amt, openingexpenditure_amt, increaseexpenditure_amt, decreaseexpenditure_amt, closingexpenditure_amt, reporting_date, pro_id_fk, insert_date) VALUES (%d, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f, '%s', %d, '%s');", transactid, openingrevenue_amt, increaserevenue_amt, decreaserevenue_amt, closingrevenue_amt, openingexpenditure_amt, increaseexpenditure_amt, decreaseexpenditure_amt, closingexpenditure_amt, reporting_date, pro_id_fk, insert_date)
   stmt
}#end of pgmf.transact.financial.format
