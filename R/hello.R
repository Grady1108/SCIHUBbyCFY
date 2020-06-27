# Hello, world!
#
# This is an example function named 'hello'
# which prints 'Hello, world!'.
#
# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Install Package:           'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'

SCI <- function(doi) {
  library(rvest)
  library(stringr)
  library(xml2)
  web <- paste0("https://sci-hub.tw/", doi)
  web_info <- read_html(web, encoding = "UTF-8")
  web_target <- html_nodes(web_info, "#pdf")
  mypdf <- html_attr(web_target, name = "src")
  download.file(mypdf, "doi.pdf", mode = "wb")
  #鏀瑰悕
  title <- html_nodes(web_info, "#citation")
  TITLE <- html_text(title)
  TITLE <- str_replace_all(TITLE, "/", "")
  TITLE <- str_replace_all(TITLE, ":", "")
  TITLE <- str_replace_all(TITLE, "<", "")
  TITLE <- str_replace_all(TITLE, ">", "")
  TITLE <- gsub("?", "", TITLE, fixed = TRUE)
  TITLE <- str_sub(TITLE, 1, 235)
  file.rename("doi.pdf", paste0(TITLE, ".pdf"))
}

