#CREATE TABLE public.tbltransact_outreach_branchwise
#(
#  transactid integer NOT NULL DEFAULT nextval('tbltransact_outreach_branchwise_transactid_seq'::regclass),
#  opening integer NOT NULL DEFAULT 0,
#  increase integer NOT NULL DEFAULT 0,
#  decrease integer NOT NULL DEFAULT 0,
#  closing integer NOT NULL DEFAULT 0,
#  reporting_date date,
#  pro_id_fk integer NOT NULL DEFAULT 0,
#  outreach_id_fk integer,
#  insert_date timestamp without time zone,
#  CONSTRAINT tbltransact_outreach_branchwise_pkey PRIMARY KEY (transactid),
#  CONSTRAINT tbltransact_outreach_branchwise_outreachid_fk_fkey FOREIGN KEY (outreach_id_fk)
#      REFERENCES public.tbloutreach (outreach_id) MATCH SIMPLE
#      ON UPDATE NO ACTION ON DELETE NO ACTION,
#  CONSTRAINT tbltransact_outreach_branchwise_pro_id_fk_fkey FOREIGN KEY (pro_id_fk)
#      REFERENCES public.tblproject (pro_id) MATCH SIMPLE
#      ON UPDATE NO ACTION ON DELETE NO ACTION
#)
#WITH (
#  OIDS=FALSE
#);

pgmf.transact.outreach <- function(name, param) {
   stmt <- ""
   err <- ""
   if (name == "pgmf.transact.outreach.byid") {
      id <- param["id"]
      stmt <- sprintf("SELECT transactid, opening, increase, decrease, closing, reporting_date, pro_id_fk, outreach_id_fk, insert_date FROM tbltransact_outreach_branchwise WHERE transactid='%s';", id)
      err <- paste("ERROR :: Transact Outreach is not found for transactID '%s'", id)
   } else   if (name == "pgmf.transact.outreach.byreportdate") {
      code <- param["code"]
      stmt <- sprintf("SELECT transactid, opening, increase, decrease, closing, reporting_date, pro_id_fk, outreach_id_fk, insert_date FROM tbltransact_outreach_branchwise WHERE reporting_date='%s';", code)
      err <- paste("ERROR :: Transact Outreach is not found for Reporting Date '%s'", code)
   } else   if (name == "pgmf.transact.outreach.byprojectid") {
      id <- param["id"]
      stmt <- sprintf("SELECT transactid, opening, increase, decrease, closing, reporting_date, pro_id_fk, outreach_id_fk, insert_date FROM tbltransact_outreach_branchwise WHERE pro_id_fk='%s';", id)
      err <- paste("ERROR :: Transact Outreach is not found for Project ID '%s'", id)
   } else   if (name == "pgmf.transact.outreach.byoutreachid") {
      id <- param["id"]
      stmt <- sprintf("SELECT transactid, opening, increase, decrease, closing, reporting_date, pro_id_fk, outreach_id_fk, insert_date FROM tbltransact_outreach_branchwise WHERE outreach_id_fk='%s';", id)
      err <- paste("ERROR :: Transact Outreach is not found for Outreach ID '%s'", id)
   } else   if (name == "pgmf.transact.outreach.byinsertdate") {
      code <- param["code"]
      stmt <- sprintf("SELECT transactid, opening, increase, decrease, closing, reporting_date, pro_id_fk, outreach_id_fk, insert_date FROM tbltransact_outreach_branchwise WHERE insert_date='%s';", code)
      err <- paste("ERROR :: Transact Outreach is not found for Insert Date '%s'", code)
   } else   if (name == "pgmf.get.transact.outreach.csv") {
      stmt <- sprintf("SELECT transactid, opening, increase, decrease, closing, reporting_date, pro_id_fk, outreach_id_fk, insert_date FROM tbltransact_outreach_branchwise;")
      err <- paste("ERROR :: Transact Outreach is not found")
   }#end of if else nesting

   #rs <- pgmf.get.rows(stmt)
   #if (nrow(rs) == 0) print(err)
   rs <- paste('{"stmt" : "', stmt, '", "err" : "', err, '"}', sep="")
   rs <- fromJSON(rs)
   rs
}#end of pgmf.transact.outreach <- function(name, param)

pgmf.set.transact.outreach.csv <- function (df) {
   sql <- apply(df, 1, pgmf.transact.outreach.format)
   sql
}#end of pgmf.set.transact.outreach.csv <- function (df)

pgmf.transact.outreach.format <- function(x) {
   #transactid <- as.integer(x["transactid"])
   opening <- as.integer(x["opening"])
   increase <- as.integer(x["increase"])
   decrease <- as.integer(x["decrease"])
   closing <- as.integer(x["closing"])
   reporting_date <- x["reporting_date"]
   pro_id_fk <- as.integer(x["pro_id_fk"])
   outreach_id_fk <- as.integer(x["outreach_id_fk"])
   insert_date <- x["insert_date"]
   stmt<- sprintf("INSERT INTO tbltransact_outreach_branchwise(opening, increase, decrease, closing, reporting_date, pro_id_fk, outreach_id_fk, insert_date) VALUES (%d, %d, %d, %d, '%s', %d, %d, '%s');", opening, increase, decrease, closing, reporting_date, pro_id_fk, outreach_id_fk, insert_date)
   stmt
}#end of pgmf.transact.outreach.format
