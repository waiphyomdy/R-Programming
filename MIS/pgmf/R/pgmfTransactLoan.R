#CREATE TABLE public.tbltransact_loan_branchwise
#(
#  transactid integer NOT NULL DEFAULT nextval('tbltransact_loan_branchwise_transactid_seq'::regclass),
#  openingld_num integer NOT NULL DEFAULT 0,
#  increaseld_num integer NOT NULL DEFAULT 0,
#  decreaseld_num integer NOT NULL DEFAULT 0,
#  closingld_num integer NOT NULL DEFAULT 0,
#  openingld_amt integer NOT NULL DEFAULT 0,
#  increaseld_amt integer NOT NULL DEFAULT 0,
#  decreaseld_amt integer NOT NULL DEFAULT 0,
#  closingld_amt integer NOT NULL DEFAULT 0,
#  openinglo_num integer NOT NULL DEFAULT 0,
# increaselo_num integer NOT NULL DEFAULT 0,
#  decreaselo_num integer NOT NULL DEFAULT 0,
#  closinglo_num integer NOT NULL DEFAULT 0,
#  openinglo_amt integer NOT NULL DEFAULT 0,
#  increaselo_amt integer NOT NULL DEFAULT 0,
#  decreaselo_amt integer NOT NULL DEFAULT 0,
#  closinglo_amt integer NOT NULL DEFAULT 0,
#  reporting_date date,
#  proid_fk integer NOT NULL DEFAULT 0,
#  pro_id_fk integer NOT NULL DEFAULT 0,
#  loan_cycle character varying(30),
#  insert_date timestamp without time zone,
#  CONSTRAINT tbltransact_loan_branchwise_pkey PRIMARY KEY (transactid),
#  CONSTRAINT tbltransact_loan_branchwise_pro_id_fk_fkey FOREIGN KEY (pro_id_fk)
#      REFERENCES public.tblproject (pro_id) MATCH SIMPLE
#      ON UPDATE NO ACTION ON DELETE NO ACTION,
#  CONSTRAINT tbltransact_loan_branchwise_proid_fk_fkey FOREIGN KEY (proid_fk)
#      REFERENCES public.tblproduct (prodid) MATCH SIMPLE
#      ON UPDATE NO ACTION ON DELETE NO ACTION
#)
#WITH (
#  OIDS=FALSE
#);

pgmf.transact.loan <- function(name, param) {
   stmt <- ""
   err <- ""
   if (name == "pgmf.transact.loan.byid") {
      id <- param["id"]
      stmt <- sprintf("SELECT transactid, openingld_num, increaseld_num, decreaseld_num, closingld_num, openingld_amt, increaseld_amt, decreaseld_amt, closingld_amt, openinglo_num, increaselo_num, decreaselo_num, closinglo_num, openinglo_amt, increaselo_amt, decreaselo_amt, closinglo_amt, reporting_date, proid_fk, pro_id_fk, loan_cycle, insert_date FROM tbltransact_loan_branchwise WHERE transactid='%s';", id)
      err <- paste("ERROR :: Transact Loan is not found for transactID '%s'", id)
   } else   if (name == "pgmf.transact.loan.byreportdate") {
      code <- param["code"]
      stmt <- sprintf("SELECT transactid, openingld_num, increaseld_num, decreaseld_num, closingld_num, openingld_amt, increaseld_amt, decreaseld_amt, closingld_amt, openinglo_num, increaselo_num, decreaselo_num, closinglo_num, openinglo_amt, increaselo_amt, decreaselo_amt, closinglo_amt, reporting_date, proid_fk, pro_id_fk, loan_cycle, insert_date FROM tbltransact_loan_branchwise WHERE reporting_date='%s';", code)
      err <- paste("ERROR :: Transact Outreach is not found for Reporting Date '%s'", code)
   } else   if (name == "pgmf.transact.loan.byproductid") {
      id <- param["id"]
      stmt <- sprintf("SELECT transactid, openingld_num, increaseld_num, decreaseld_num, closingld_num, openingld_amt, increaseld_amt, decreaseld_amt, closingld_amt, openinglo_num, increaselo_num, decreaselo_num, closinglo_num, openinglo_amt, increaselo_amt, decreaselo_amt, closinglo_amt, reporting_date, proid_fk, pro_id_fk, loan_cycle, insert_date FROM tbltransact_loan_branchwise WHERE proid_fk='%s';", id)
      err <- paste("ERROR :: Transact Outreach is not found for Product ID '%s'", id)
   } else   if (name == "pgmf.transact.loan.byprojectid") {
      id <- param["id"]
      stmt <- sprintf("SELECT transactid, openingld_num, increaseld_num, decreaseld_num, closingld_num, openingld_amt, increaseld_amt, decreaseld_amt, closingld_amt, openinglo_num, increaselo_num, decreaselo_num, closinglo_num, openinglo_amt, increaselo_amt, decreaselo_amt, closinglo_amt, reporting_date, proid_fk, pro_id_fk, loan_cycle, insert_date FROM tbltransact_loan_branchwise WHERE pro_id_fk='%s';", id)
      err <- paste("ERROR :: Transact Outreach is not found for Project ID '%s'", id)
   } else   if (name == "pgmf.transact.loan.byinsertdate") {
      code <- param["code"]
      stmt <- sprintf("SELECT transactid, openingld_num, increaseld_num, decreaseld_num, closingld_num, openingld_amt, increaseld_amt, decreaseld_amt, closingld_amt, openinglo_num, increaselo_num, decreaselo_num, closinglo_num, openinglo_amt, increaselo_amt, decreaselo_amt, closinglo_amt, reporting_date, proid_fk, pro_id_fk, loan_cycle, insert_date FROM tbltransact_loan_branchwise WHERE insert_date='%s';", code)
      err <- paste("ERROR :: Transact Outreach is not found for Insert Date '%s'", code)
   } else   if (name == "pgmf.get.transact.loan.csv") {
      stmt <- sprintf("SELECT transactid, openingld_num, increaseld_num, decreaseld_num, closingld_num, openingld_amt, increaseld_amt, decreaseld_amt, closingld_amt, openinglo_num, increaselo_num, decreaselo_num, closinglo_num, openinglo_amt, increaselo_amt, decreaselo_amt, closinglo_amt, reporting_date, proid_fk, pro_id_fk, loan_cycle, insert_date FROM tbltransact_loan_branchwise;")
      err <- paste("ERROR :: Transact Loan is not found")
   }#end of if else nesting

   #rs <- pgmf.get.rows(stmt)
   #if (nrow(rs) == 0) print(err)
   rs <- paste('{"stmt" : "', stmt, '", "err" : "', err, '"}', sep="")
   rs <- fromJSON(rs)
   rs
}#end of pgmf.transact.loan <- function(name, param)

pgmf.set.transact.loan.csv <- function (df) {
   sql <- apply(df, 1, pgmf.transact.loan.format)
   sql
}#end of pgmf.set.transact.loan.csv <- function (df)

pgmf.transact.loan.format <- function(x) {
   #transactid <- as.integer(x["transactid"])
   openingld_num <- as.integer(x["openingld_num"])
   increaseld_num <- as.integer(x["increaseld_num"])
   decreaseld_num <- as.integer(x["decreaseld_num"])
   closingld_num <- as.integer(x["closingld_num"])
   openingld_amt <- as.numeric(x["openingld_amt"])
   increaseld_amt <- as.numeric(x["increaseld_amt"])
   decreaseld_amt <- as.numeric(x["decreaseld_amt"])
   closingld_amt <- as.numeric(x["closingld_amt"])

   openinglo_num <- as.integer(x["openinglo_num"])
   increaselo_num <- as.integer(x["increaselo_num"])
   decreaselo_num <- as.integer(x["decreaselo_num"])
   closinglo_num <- as.integer(x["closinglo_num"])
   openinglo_amt <- as.numeric(x["openinglo_amt"])
   increaselo_amt <- as.numeric(x["increaselo_amt"])
   decreaselo_amt <- as.numeric(x["decreaselo_amt"])
   closinglo_amt <- as.numeric(x["closinglo_amt"])

   reporting_date <- x["reporting_date"]
   proid_fk <- as.integer(x["proid_fk"])
   pro_id_fk <- as.integer(x["pro_id_fk"])
   loan_cycle <- x["loan_cycle"]
   insert_date <- x["insert_date"]
   stmt<- sprintf("INSERT INTO tbltransact_loan_branchwise(openingld_num, increaseld_num, decreaseld_num, closingld_num, openingld_amt, increaseld_amt, decreaseld_amt, closingld_amt, openinglo_num, increaselo_num, decreaselo_num, closinglo_num, openinglo_amt, increaselo_amt, decreaselo_amt, closinglo_amt, reporting_date, proid_fk, pro_id_fk, loan_cycle, insert_date) VALUES (%d, %d, %d, %d, %.2f, %.2f, %.2f, %.2f, %d, %d, %d, %d, %.2f, %.2f, %.2f, %.2f, '%s', %d, %d, '%s', '%s');", openingld_num, increaseld_num, decreaseld_num, closingld_num, openingld_amt, increaseld_amt, decreaseld_amt, closingld_amt, openinglo_num, increaselo_num, decreaselo_num, closinglo_num, openinglo_amt, increaselo_amt, decreaselo_amt, closinglo_amt, reporting_date, proid_fk, pro_id_fk, loan_cycle, insert_date)
   stmt
}#end of pgmf.transact.loan.format
