# Colocando como working directory
setwd("~/A2")

# Carregando pacotes
library(tidyverse)
library(stringr)

# Abrindo os arquivos B2 e excluindo primeira linha
linhas1A2 <- readLines("L001A2.txt", encoding = "utf-8") %>%
  str_remove_all("^\\<BLE.*\\>")
linhas2A2 <- readLines("L005A2.txt", encoding = "utf-8") %>%
  str_remove_all("^\\<BLE.*\\>")
linhas3A2 <- readLines("L007A2.txt", encoding = "utf-8") %>%
  str_remove_all("^\\<BLE.*\\>")
linhas4A2 <- readLines("L008A2.txt", encoding = "utf-8") %>%
  str_remove_all("^\\<BLE.*\\>")
linhas5A2 <- readLines("L012A2.txt", encoding = "utf-8") %>%
  str_remove_all("^\\<BLE.*\\>")

#Juntando os arquivos
linhasA2 <- c(linhas1A2, linhas2A2, linhas3A2, linhas4A2, linhas5A2)

#Excluindo <name of ...>
A2_apr <- linhasA2 %>% str_replace_all("\\<name*\\>", "NAME") %>% 
  str_replace_all("\\<name of the interviewee\\>", "NAME") %>%
  str_replace_all("\\<name of interviewee\\>", "NAME") %>%
  str_replace_all("\\<name of.*\\>", "NAME") %>%
  str_replace_all("\\<name of city\\>", "CITY") %>%
  str_replace_all("\\<hometown of the interviewee\\>", "CITY")

# Excluindo pontos, dois pontos, chaves
A2_apr_limpo1 <- A2_apr %>%
  str_replace_all("\\.", "") %>%
  str_replace_all("\\..", "") %>%
  str_replace_all("\\...", "") %>%
  str_replace_all("\\:", "") %>%
  str_replace_all("\\{", "") %>%
  str_replace_all("\\}", "")

# Excluindo <nv>, foreign, <[Ov/]>, <hh>
A2_apr_limpo2 <- A2_apr_limpo1 %>%
  str_replace_all("\\<nv\\>[^\\/]*\\<\\/nv\\>", "") %>%
  str_replace_all("\\<nv\\>[^\\/]*\\<nv\\/\\>" , "") %>%
  str_remove_all("\\<foreign\\>") %>%
  str_remove_all("\\<\\/foreign\\>") %>%
  str_remove_all("\\<\\/foreing\\>") %>%
  str_remove_all("\\<foreign language\\>") %>%
  str_remove_all("\\<foreign language\\/\\>") %>%
  str_remove_all("\\<foreign language\\>") %>%
  str_remove_all("\\<foreign\\/\\>") %>%
  str_remove_all("\\<\\[Ov\\/\\]\\>") %>%
  str_remove_all("\\<\\[Ov\\]\\>") %>%
  str_remove_all("\\<\\[Ov\\/\\>") %>%
  str_remove_all("\\[[^\\]]*\\]") %>%
  str_remove_all("\\<hh\\>") %>% 
  str_replace_all("\\<unclear\\>", "00")

# Excluindo filler sounds e outros sinais
A2_apr_limpo3 <- A2_apr_limpo2 %>%
  str_replace_all("\\(er\\)", "") %>%
  str_replace_all("\\(em\\)", "") %>%
  str_replace_all("\\(eh\\)", "") %>%
  str_replace_all("\\(mm\\)", "") %>%
  str_replace_all("\\(oh\\)", "") %>%
  str_replace_all("\\(hmhm\\)", "") %>% 
  str_replace_all("\\(hm\\)", "") %>%
  str_replace_all("\\(uh-huh\\)", "") %>%
  str_remove_all("\\<FD\\>") %>%
  str_remove_all("\\<\\/FD\\>") %>%
  str_remove_all("\\<PD\\>") %>%
  str_remove_all("\\<\\/PD\\>") %>%
  str_remove_all("\\<PN XX\\> \\<PN XX\\>") %>%
  str_remove_all("\\<PN XX\\>\\<PN XX\\>") %>%
  str_remove_all("\\<PNXX\\>") %>%
  str_remove_all("\\<PD XX\\>\\<PD XX\\>")

#Tirando os simbolos de turnos e simbolos residuais
A2_apr_limpo4 = A2_apr_limpo3 %>% str_remove_all("\\<L0.*\\>") %>%
  str_remove_all("\\<INT\\>") %>%
  str_remove_all("\\<Ov\\/\\>") %>%
  str_remove_all("\\<Ov\\/\\]\\>") %>%
  str_remove_all("\\(hum-um\\)") %>%
  str_replace_all("\\<first name of interviewee\\>", "NAME") %>%
  str_remove_all("\\+") %>%
  str_replace_all("OH", "") %>%
  str_remove_all("\\<PN[0-9]+[:alpha:]+\\>")

#remover espaços em branco extras e linhas em branco
A2_apr_limpo5 <- A2_apr_limpo4 %>%
  str_remove_all("\\n") %>% 
  str_remove_all("^ +$") %>%
  str_replace_all(" +"," ") %>%
  str_remove_all("^ ") %>%
  str_remove_all(" $")

A2_apr_limpo5 <- A2_apr_limpo5[A2_apr_limpo5!=""]

#Arquivo com todos os turnos (exportando)
writeLines(A2_apr_limpo5, "A2_all.txt", useBytes = T)

A2_apr_limpo5






