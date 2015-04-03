#CREATE TABLE public.tblproject
#(
#  pro_id integer NOT NULL DEFAULT nextval('tblproject_pro_id_seq'::regclass),
#  pro_code character varying(20) DEFAULT NULL::character varying,
#  pro_name character varying(50) DEFAULT NULL::character varying,
#  pro_desc text DEFAULT NULL::character varying,
#  CONSTRAINT tblproject_pkey PRIMARY KEY (pro_id)
#)
#WITH (
#  OIDS=FALSE
#);

pgmf.project <- function(name, param) {
   stmt <- ""
   err <- ""
   if (name == "pgmf.get.project.byid") {
      id <- param["id"]
      stmt <- sprintf("select pro_id, pro_code, pro_name, pro_desc from tblproject WHERE pro_id='%s';", id)
      err <- paste("ERROR :: Project is not found for Project ID ", id)
   } else   if (name == "pgmf.get.project.bycode") {
      code <- param["code"]
      stmt <- sprintf("select pro_id, pro_code, pro_name, pro_desc from tblproject WHERE pro_code='%s';", code)
      err <- paste("ERROR :: Project is not found for Project Code ", code)
   } else   if (name == "pgmf.get.project.byname") {
      name <- param["name"]
      stmt <- sprintf("select pro_id, pro_code, pro_name, pro_desc from tblproject WHERE pro_name='%s';", name)
      err <- paste("ERROR :: Project is not found for Project Name ", name)
   } else   if (name == "pgmf.get.project.csv") {
      stmt <- sprintf("select pro_id, pro_code, pro_name, pro_desc from tblproject order by pro_id;")
      err <- paste("ERROR :: Project is not found")
   }#end of if else nesting

   #rs <- pgmf.get.rows(stmt)
   #if (nrow(rs) == 0) print(err)
   rs <- paste('{"stmt" : "', stmt, '", "err" : "', err, '"}', sep="")
   rs <- fromJSON(rs)
   rs
}#end of pgmf.project <- function(name, param)

pgmf.set.project.csv <- function (df) {
   sql <- apply(df, 1, pgmf.project.format)
   sql
}#end of pgmf.set.project.csv <- function (df)

pgmf.project.format <- function(x) {
   pro_id <- as.integer(x["pro_id"])
   pro_code <- x["pro_code"]
   pro_name <- x["pro_name"]
   pro_desc <- x["pro_desc"]
   stmt<- sprintf("INSERT INTO tblproject(pro_id, pro_code, pro_name, pro_desc) VALUES (%d, '%s', '%s', '%s');", pro_id, pro_code, pro_name, pro_desc)
   stmt
}#end of pgmf.project.format

