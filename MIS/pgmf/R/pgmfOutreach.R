#CREATE TABLE public.tbloutreach
#(
#  outreach_id integer NOT NULL DEFAULT nextval('tbloutreach_outreach_id_seq'::regclass),
#  outreach_indicator character varying(50) DEFAULT NULL::character varying,
#  unit character varying(20) DEFAULT NULL::character varying,
#  CONSTRAINT tbloutreach_pkey PRIMARY KEY (outreach_id)
#)
#WITH (
#  OIDS=FALSE
#);

pgmf.outreach <- function(name, param) {
   stmt <- ""
   err <- ""
   if (name == "pgmf.get.outreach.byid") {
      id <- param["id"]
      stmt <- sprintf("select outreach_id, outreach_indicator, unit from tbloutreach WHERE outreach_id='%s';", id)
      err <- paste("ERROR :: Outreach is not found for Outreach ID ", id)
   } else   if (name == "pgmf.get.outreach.byindicator") {
      code <- param["code"]
      stmt <- sprintf("select outreach_id, outreach_indicator, unit from tbloutreach WHERE outreach_indicator='%s';", code)
      err <- paste("ERROR :: Outreach is not found for Outreach Indicator ", code)
   } else   if (name == "pgmf.get.outreach.byunit") {
      code <- param["code"]
      stmt <- sprintf("select outreach_id, outreach_indicator, unit from tbloutreach WHERE unit='%s';", code)
      err <- paste("ERROR :: Outreach is not found for Unit ", code)
   } else   if (name == "pgmf.get.outreach.csv") {
      code <- param["code"]
      stmt <- sprintf("select outreach_id, outreach_indicator, unit from tbloutreach order by outreach_id;")
      err <- paste("ERROR :: Outreach is not found")
   }#end of if else nesting

   #rs <- pgmf.get.rows(stmt)
   #if (nrow(rs) == 0) print(err)
   rs <- paste('{"stmt" : "', stmt, '", "err" : "', err, '"}', sep="")
   rs <- fromJSON(rs)
   rs
}#end of pgmf.outreach <- function(name, param)

pgmf.set.outreach.csv <- function (df) {
   sql <- apply(df, 1, pgmf.outreach.format)
   sql
}#end of pgmf.set.outreach.csv <- function (df)

pgmf.outreach.format <- function(x) {
   outreach_id <- as.integer(x["outreach_id"])
   outreach_indicator <- x["outreach_indicator"]
   unit <- x["unit"]
   stmt<- sprintf("INSERT INTO tbloutreach(outreach_id, outreach_indicator, unit) VALUES (%d, '%s', '%s');", outreach_id, outreach_indicator, unit)
   stmt
}#end of pgmf.outreach.format

