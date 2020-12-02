# China Embassy in DK --------------------
library(dplyr)
library(stringr)
library(ggplot2)
library(rebus)
library(purrr)

extract_content <- function(url = ...){
  content <- url %>% xml2::read_html() %>% 
    rvest::html_nodes(css ="p") %>% rvest::html_text() %>% str_remove_all(BLANK) %>% 
    str_subset("") %>% str_c(collapse = TRUE)
  return(content)
}
html <- xml2::read_html("https://www.fmprc.gov.cn/ce/cedk/chn/lsfw/")

page <- tibble(title = rvest::html_nodes(html, css = ".newsList a") %>% rvest::html_text() %>% 
                 as.character() %>% str_replace_all(BLANK, ""),
               time = rvest::html_nodes(html,css = ".newsList span") %>% rvest::html_text() %>% 
                 as.character() %>% str_remove_all("\\(|\\)") %>% as.Date(),
               url = rvest::html_nodes(html, css = ".newsList a") %>% as.character() %>% 
                 str_extract('(?<=href=")[:graph:]{1,}(?=\")')) %>% 
  mutate(url = url %>% str_replace(START %R% DOT, "https://www.fmprc.gov.cn/ce/cedk/chn/lsfw")) %>% 
  dplyr::arrange(desc(time)) 

content <- page$url %>% map_chr(extract_content)
  mutate(content = extract_content(url))



page_content_preview <- page_content %>% mutate(content = content %>% str_remove_all("TRUE") %>% str_sub(1, 120))

test <- knitr::kable(page_content_preview, format = "pipe")
write(test, "README.md")
