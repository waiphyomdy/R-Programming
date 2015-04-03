#CREATE TABLE public.tbltransact_saving_branchwise
#(
#  transactid integer NOT NULL DEFAULT nextval('tbltransact_saving_branchwise_transactid_seq'::regclass),
#  opening_num integer NOT NULL DEFAULT 0,
#  increase_num integer NOT NULL DEFAULT 0,
#  decrease_num integer NOT NULL DEFAULT 0,
#  closing_num integer NOT NULL DEFAULT 0,
#  opening_amt integer NOT NULL DEFAULT 0,
#  increase_amt integer NOT NULL DEFAULT 0,
#  decrease_amt integer NOT NULL DEFAULT 0,
# closing_amt integer NOT NULL DEFAULT 0,
#  reporting_date date,
#  prodid_fk integer NOT NULL,
#  pro_id_fk integer NOT NULL,
#  insert_date timestamp without time zone,
#  CONSTRAINT tbltransact_saving_branchwise_pkey PRIMARY KEY (transactid),
#  CONSTRAINT tbltransact_saving_branchwise_pro_id_fk_fkey FOREIGN KEY (pro_id_fk)
#      REFERENCES public.tblproject (pro_id) MATCH SIMPLE
#      ON UPDATE NO ACTION ON DELETE NO ACTION,
#  CONSTRAINT tbltransact_saving_branchwise_prodid_fk_fkey FOREIGN KEY (prodid_fk)
#      REFERENCES public.tblproduct (prodid) MATCH SIMPLE
#      ON UPDATE NO ACTION ON DELETE NO ACTION
#)
#WITH (
#  OIDS=FALSE
#);

pgmf.transact.saving <- function(name, param) {
   stmt <- ""
   err <- ""
   if (name == "pgmf.transact.saving.byid") {
      id <- param["id"]
      stmt <- sprintf("SELECT transactid, opening_num, increase_num, decrease_num, closing_num, opening_amt, increase_amt, decrease_amt, closing_amt, reporting_date, prodid_fk, pro_id_fk, insert_date FROM tbltransact_saving_branchwise WHERE transactid='%s';", id)
      err <- paste("ERROR :: Transact Saving is not found for transactID '%s'", id)
   } else   if (name == "pgmf.transact.saving.byreportdate") {
      code <- param["code"]
      stmt <- sprintf("SELECT transactid, opening_num, increase_num, decrease_num, closing_num, opening_amt, increase_amt, decrease_amt, closing_amt, reporting_date, prodid_fk, pro_id_fk, insert_date FROM tbltransact_saving_branchwise WHERE reporting_date='%s';", code)
      err <- paste("ERROR :: Transact Saving is not found for Reporting Date '%s'", code)
   } else   if (name == "pgmf.transact.saving.byproductid") {
      id <- param["id"]
      stmt <- sprintf("SELECT transactid, opening_num, increase_num, decrease_num, closing_num, opening_amt, increase_amt, decrease_amt, closing_amt, reporting_date, prodid_fk, pro_id_fk, insert_date FROM tbltransact_saving_branchwise WHERE prodid_fk='%s';", id)
      err <- paste("ERROR :: Transact Saving is not found for Product ID '%s'", id)
   } else   if (name == "pgmf.transact.saving.byprojectid") {
      id <- param["id"]
      stmt <- sprintf("SELECT transactid, opening_num, increase_num, decrease_num, closing_num, opening_amt, increase_amt, decrease_amt, closing_amt, reporting_date, prodid_fk, pro_id_fk, insert_date FROM tbltransact_saving_branchwise WHERE pro_id_fk='%s';", id)
      err <- paste("ERROR :: Transact Saving is not found for Project ID '%s'", id)
   } else   if (name == "pgmf.transact.saving.byinsertdate") {
      code <- param["code"]
      stmt <- sprintf("SELECT transactid, opening_num, increase_num, decrease_num, closing_num, opening_amt, increase_amt, decrease_amt, closing_amt, reporting_date, prodid_fk, pro_id_fk, insert_date FROM tbltransact_saving_branchwise WHERE insert_date='%s';", code)
      err <- paste("ERROR :: Transact Saving is not found for Insert Date '%s'", code)
   } else   if (name == "pgmf.get.transact.saving.csv") {
      stmt <- sprintf("SELECT transactid, opening_num, increase_num, decrease_num, closing_num, opening_amt, increase_amt, decrease_amt, closing_amt, reporting_date, prodid_fk, pro_id_fk, insert_date FROM tbltransact_saving_branchwise;")
      err <- paste("ERROR :: Transact Saving is not found")
   }#end of if else nesting

   #rs <- pgmf.get.rows(stmt)
   #if (nrow(rs) == 0) print(err)
   rs <- paste('{"stmt" : "', stmt, '", "err" : "', err, '"}', sep="")
   rs <- fromJSON(rs)
   rs
}#end of pgmf.transact.saving <- function(name, param)

pgmf.set.transact.saving.csv <- function (df) {
   sql <- apply(df, 1, pgmf.transact.saving.format)
   sql
}#end of pgmf.set.transact.saving.csv <- function (df)

pgmf.transact.saving.format <- function(x) {
   #transactid <- as.integer(x["transactid"])
   opening_num <- as.integer(x["opening_num"])
   increase_num <- as.integer(x["increase_num"])
   decrease_num <- as.integer(x["decrease_num"])
   closing_num <- as.integer(x["closing_num"])
   opening_amt <- as.numeric(x["opening_amt"])
   increase_amt <- as.numeric(x["increase_amt"])
   decrease_amt <- as.numeric(x["decrease_amt"])
   closing_amt <- as.numeric(x["closing_amt"])

   reporting_date <- x["reporting_date"]
   proid_fk <- as.integer(x["prodid_fk"])
   pro_id_fk <- as.integer(x["pro_id_fk"])
   insert_date <- x["insert_date"]
   stmt<- sprintf("INSERT INTO tbltransact_saving_branchwise(opening_num, increase_num, decrease_num, closing_num, opening_amt, increase_amt, decrease_amt, closing_amt, reporting_date, prodid_fk, pro_id_fk, insert_date) VALUES (%d, %d, %d, %d, %.2f, %.2f, %.2f, %.2f, '%s', %d, %d, '%s');", opening_num, increase_num, decrease_num, closing_num, opening_amt, increase_amt, decrease_amt, closing_amt, reporting_date, proid_fk, pro_id_fk, insert_date)
   stmt
}#end of pgmf.transact.saving.format
