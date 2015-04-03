#CREATE TABLE public.tblloanportfolioquality
#(
#  loanportfolioquality_id integer NOT NULL DEFAULT nextval('tblloanportfolioquality_loanportfolioquality_id_seq'::regclass),
#  loanportfolioquality character varying(100) DEFAULT NULL::character varying,
#  CONSTRAINT tblloanportfolioquality_pkey PRIMARY KEY (loanportfolioquality_id)
#)
#WITH (
#  OIDS=FALSE
#);

pgmf.portfolio <- function(name, param) {
   stmt <- ""
   err <- ""
   if (name == "pgmf.get.portfolio.byid") {
      id <- param["id"]
      stmt <- sprintf("select loanportfolioquality_id, loanportfolioquality from tblloanportfolioquality WHERE loanportfolioquality_id='%s';", id)
      err <- paste("ERROR :: Portfolio is not found for Portfolio ID ", id)
   } else   if (name == "pgmf.get.portfolio.byportfolio") {
      code <- param["code"]
      stmt <- sprintf("select loanportfolioquality_id, loanportfolioquality from tblloanportfolioquality WHERE loanportfolioquality='%s';", code)
      err <- paste("ERROR :: Portfolio is not found for Portfolio '%s'", code)
   } else   if (name == "pgmf.get.portfolio.csv") {
      stmt <- sprintf("select loanportfolioquality_id, loanportfolioquality from tblloanportfolioquality;")
      err <- paste("ERROR :: Portfolio is not found")
   }#end of if else nesting

   #rs <- pgmf.get.rows(stmt)
   #if (nrow(rs) == 0) print(err)
   rs <- paste('{"stmt" : "', stmt, '", "err" : "', err, '"}', sep="")
   rs <- fromJSON(rs)
   rs
}#end of pgmf.portfolio <- function(name, param)

pgmf.set.portfolio.csv <- function (df) {
   sql <- apply(df, 1, pgmf.portfolio.format)
   sql
}#end of pgmf.set.portfolio.csv <- function (df)

pgmf.portfolio.format <- function(x) {
   loanportfolioquality_id <- as.integer(x["loanportfolioquality_id"])
   loanportfolioquality <- x["loanportfolioquality"]
   stmt<- sprintf("INSERT INTO tblloanportfolioquality(loanportfolioquality_id, loanportfolioquality) VALUES (%d, '%s');", loanportfolioquality_id, loanportfolioquality)
   stmt
}#end of pgmf.portfolio.format
