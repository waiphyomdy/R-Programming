#CREATE TABLE public.tblproduct
#(
#  prodid integer NOT NULL DEFAULT nextval('tblproduct_prodid_seq'::regclass),
#  prod_code character varying(10) DEFAULT NULL::character varying,
#  prod_name character varying(50) DEFAULT NULL::character varying,
#  procat text,
#  CONSTRAINT tblproduct_pkey PRIMARY KEY (prodid)
#)
#WITH (
#  OIDS=FALSE
#);

pgmf.product <- function(name, param) {
   stmt <- ""
   err <- ""
   if (name == "pgmf.get.product.byid") {
      id <- param["id"]
      stmt <- sprintf("select prodid, prod_code, prod_name, procat from tblproduct WHERE prodid='%s';", id)
      err <- paste("ERROR :: Product is not found for Product ID ", id)
   } else   if (name == "pgmf.get.product.bycode") {
      code <- param["code"]
      stmt <- sprintf("select prodid, prod_code, prod_name, procat from tblproduct WHERE prod_code='%s';", code)
      err <- paste("ERROR :: Product is not found for Product Code ", code)
   } else   if (name == "pgmf.get.product.byname") {
      name <- param["name"]
      stmt <- sprintf("select prodid, prod_code, prod_name, procat from tblproduct WHERE prod_name='%s';", name)
      err <- paste("ERROR :: Product is not found for Product Name ", name)
   } else   if (name == "pgmf.get.product.bycat") {
      name <- param["name"]
      stmt <- sprintf("select prodid, prod_code, prod_name, procat from tblproduct WHERE procat='%s';", name)
      err <- paste("ERROR :: Product is not found for Product Category ", name)
   } else   if (name == "pgmf.get.product.csv") {
      code <- param["code"]
      stmt <- sprintf("select prodid, prod_code, prod_name, procat from tblproduct order by prodid;")
      err <- paste("ERROR :: Product is not found")
   }#end of if else nesting

   #rs <- pgmf.get.rows(stmt)
   #if (nrow(rs) == 0) print(err)
   rs <- paste('{"stmt" : "', stmt, '", "err" : "', err, '"}', sep="")
   rs <- fromJSON(rs)
   rs
}#end of pgmf.product <- function(name, param)

pgmf.set.product.csv <- function (df) {
   sql <- apply(df, 1, pgmf.product.format)
   sql
}#end of pgmf.set.product.csv <- function (df)

pgmf.product.format <- function(x) {
   prodid <- as.integer(x["prodid"])
   prod_code <- x["prod_code"]
   prod_name <- x["prod_name"]
   procat <- x["procat"]
   stmt<- sprintf("INSERT INTO tblproduct(prodid, prod_code, prod_name, procat) VALUES (%d, '%s', '%s', '%s');", prodid, prod_code, prod_name, procat)
   stmt
}#end of pgmf.product.format

