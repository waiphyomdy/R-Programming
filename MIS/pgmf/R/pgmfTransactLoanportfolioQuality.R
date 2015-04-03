#CREATE TABLE public.tbltransact_loanportfolioquality_branchwise
#(
#  transactid integer NOT NULL DEFAULT nextval('tbltransact_loanportfolioquality_branchwise_transactid_seq'::regclass),
#  opening_borrower_num integer NOT NULL DEFAULT 0,
#  increase_borrower_num integer NOT NULL DEFAULT 0,
#  decrease_borrower_num integer NOT NULL DEFAULT 0,
#  closing_borrower_num integer NOT NULL DEFAULT 0,
#  openingloanportfolio_amt double precision NOT NULL DEFAULT 0,
#  increaseloanportfolio_amt double precision NOT NULL DEFAULT 0,
#  decreaseloanportfolio_amt double precision NOT NULL DEFAULT 0,
#  closingloanportfolio_amt double precision NOT NULL DEFAULT 0,
#  reporting_date date,
#  loanportfolioquality_id_fk integer NOT NULL DEFAULT 0,
#  pro_id_fk integer NOT NULL DEFAULT 0,
#  insert_date timestamp without time zone,
#  CONSTRAINT tbltransact_loanportfolioquality_branchwise_pkey PRIMARY KEY (transactid),
#  CONSTRAINT tbltransact_loanportfolioquality_branchwise_loanportfolioqualit FOREIGN KEY (loanportfolioquality_id_fk)
#      REFERENCES public.tblloanportfolioquality (loanportfolioquality_id) MATCH SIMPLE
#      ON UPDATE NO ACTION ON DELETE NO ACTION,
#  CONSTRAINT tbltransact_loanportfolioquality_branchwise_pro_id_fk_fkey FOREIGN KEY (pro_id_fk)
#      REFERENCES public.tblproject (pro_id) MATCH SIMPLE
#      ON UPDATE NO ACTION ON DELETE NO ACTION
#)
#WITH (
#  OIDS=FALSE
#);

pgmf.transact.loanportfolioquality <- function(name, param) {
   stmt <- ""
   err <- ""
   if (name == "pgmf.transact.loanportfolioquality.byid") {
      id <- param["id"]
      stmt <- sprintf("SELECT transactid, opening_borrower_num, increase_borrower_num, decrease_borrower_num, closing_borrower_num, openingloanportfolio_amt, increaseloanportfolio_amt, decreaseloanportfolio_amt, closingloanportfolio_amt, reporting_date, loanportfolioquality_id_fk, pro_id_fk, insert_date FROM tbltransact_loanportfolioquality_branchwise WHERE transactid='%s';", id)
      err <- paste("ERROR :: Transact Loanportfolio Quality is not found for transactID '%s'", id)
   } else   if (name == "pgmf.transact.loanportfolioquality.byreportdate") {
      code <- param["code"]
      stmt <- sprintf("SELECT transactid, opening_borrower_num, increase_borrower_num, decrease_borrower_num, closing_borrower_num, openingloanportfolio_amt, increaseloanportfolio_amt, decreaseloanportfolio_amt, closingloanportfolio_amt, reporting_date, loanportfolioquality_id_fk, pro_id_fk, insert_date FROM tbltransact_loanportfolioquality_branchwise WHERE reporting_date='%s';", code)
      err <- paste("ERROR :: Transact Loanportfolio Quality is not found for Reporting Date '%s'", code)
   } else   if (name == "pgmf.transact.loanportfolioquality.byportfolioid") {
      id <- param["id"]
      stmt <- sprintf("SELECT transactid, opening_borrower_num, increase_borrower_num, decrease_borrower_num, closing_borrower_num, openingloanportfolio_amt, increaseloanportfolio_amt, decreaseloanportfolio_amt, closingloanportfolio_amt, reporting_date, loanportfolioquality_id_fk, pro_id_fk, insert_date FROM tbltransact_loanportfolioquality_branchwise WHERE loanportfolioquality_id_fk='%s';", id)
      err <- paste("ERROR :: Transact Loanportfolio Quality is not found for Loanportfolio Quality ID '%s'", id)
   } else   if (name == "pgmf.transact.loanportfolioquality.byprojectid") {
      id <- param["id"]
      stmt <- sprintf("SELECT transactid, opening_borrower_num, increase_borrower_num, decrease_borrower_num, closing_borrower_num, openingloanportfolio_amt, increaseloanportfolio_amt, decreaseloanportfolio_amt, closingloanportfolio_amt, reporting_date, loanportfolioquality_id_fk, pro_id_fk, insert_date FROM tbltransact_loanportfolioquality_branchwise WHERE pro_id_fk='%s';", id)
      err <- paste("ERROR :: Transact Loanportfolio Quality is not found for Project ID '%s'", id)
   } else   if (name == "pgmf.transact.loanportfolioquality.byinsertdate") {
      code <- param["code"]
      stmt <- sprintf("SELECT transactid, opening_borrower_num, increase_borrower_num, decrease_borrower_num, closing_borrower_num, openingloanportfolio_amt, increaseloanportfolio_amt, decreaseloanportfolio_amt, closingloanportfolio_amt, reporting_date, loanportfolioquality_id_fk, pro_id_fk, insert_date FROM tbltransact_loanportfolioquality_branchwise WHERE insert_date='%s';", code)
      err <- paste("ERROR :: Transact Loanportfolio Quality is not found for Insert Date '%s'", code)
   } else   if (name == "pgmf.get.transact.loanportfolioquality.csv") {
      stmt <- sprintf("SELECT transactid, opening_borrower_num, increase_borrower_num, decrease_borrower_num, closing_borrower_num, openingloanportfolio_amt, increaseloanportfolio_amt, decreaseloanportfolio_amt, closingloanportfolio_amt, reporting_date, loanportfolioquality_id_fk, pro_id_fk, insert_date FROM tbltransact_loanportfolioquality_branchwise;")
      err <- paste("ERROR :: Transact Loanportfolio Quality is not found")
   }#end of if else nesting

   #rs <- pgmf.get.rows(stmt)
   #if (nrow(rs) == 0) print(err)
   rs <- paste('{"stmt" : "', stmt, '", "err" : "', err, '"}', sep="")
   rs <- fromJSON(rs)
   rs
}#end of pgmf.transact.loanportfolioquality <- function(name, param)

pgmf.set.transact.loanportfolioquality.csv <- function (df) {
   sql <- apply(df, 1, pgmf.transact.loanportfolioquality.format)
   sql
}#end of pgmf.set.transact.loanportfolioquality.csv <- function (df)

pgmf.transact.loanportfolioquality.format <- function(x) {
   transactid <- as.integer(x["transactid"])
   opening_borrower_num <- as.integer(x["opening_borrower_num"])
   increase_borrower_num <- as.integer(x["increase_borrower_num"])
   decrease_borrower_num <- as.integer(x["decrease_borrower_num"])
   closing_borrower_num <- as.integer(x["closing_borrower_num"])

   openingloanportfolio_amt <- as.numeric(x["openingloanportfolio_amt"])
   increaseloanportfolio_amt <- as.numeric(x["increaseloanportfolio_amt"])
   decreaseloanportfolio_amt <- as.numeric(x["decreaseloanportfolio_amt"])
   closingloanportfolio_amt <- as.numeric(x["closingloanportfolio_amt"])

   reporting_date <- x["reporting_date"]
   loanportfolioquality_id_fk <- as.integer(x["loanportfolioquality_id_fk"])
   pro_id_fk <- as.integer(x["pro_id_fk"])
   insert_date <- x["insert_date"]
   stmt<- sprintf("INSERT INTO tbltransact_loanportfolioquality_branchwise(transactid, opening_borrower_num, increase_borrower_num, decrease_borrower_num, closing_borrower_num, openingloanportfolio_amt, increaseloanportfolio_amt, decreaseloanportfolio_amt, closingloanportfolio_amt, reporting_date, loanportfolioquality_id_fk, pro_id_fk, insert_date) VALUES (%d, %d, %d, %d, %d, %.2f, %.2f, %.2f, %.2f, '%s', %d, %d, '%s');", transactid, opening_borrower_num, increase_borrower_num, decrease_borrower_num, closing_borrower_num, openingloanportfolio_amt, increaseloanportfolio_amt, decreaseloanportfolio_amt, closingloanportfolio_amt, reporting_date, loanportfolioquality_id_fk, pro_id_fk, insert_date)
   stmt
}#end of pgmf.transact.loanportfolioquality.format
