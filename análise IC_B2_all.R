# Colocando como working directory
setwd("~/B2")

# Carregando pacotes
library(tidyverse)
library(stringr)

# Abrindo os arquivos B2
linhas1B2 <- readLines("L002B2.txt", encoding = "utf-8") %>%
  str_remove_all("^\\<BLE.*\\>")
linhas2B2 <- readLines("L004B2.txt", encoding = "utf-8") %>%
  str_remove_all("^\\<BLE.*\\>")
linhas3B2 <- readLines("L007B2.txt", encoding = "utf-8") %>%
  str_remove_all("^\\<BLE.*\\>")
linhas4B2 <- readLines("L008B2.txt", encoding = "utf-8") %>%
  str_remove_all("^\\<BLE.*\\>")
linhas5B2 <- readLines("L015B2.txt", encoding = "utf-8") %>%
  str_remove_all("^\\<BLE.*\\>")

#Juntando os arquivos
linhasB2 <- c(linhas1B2, linhas2B2, linhas3B2, linhas4B2, linhas5B2)

#Excluindo <name of ...>
B2_all1 <- linhasB2_all %>% str_replace_all("\\<name*\\>", "NAME") %>% 
  str_replace_all("\\<name of the interviewee\\>", "NAME") %>%
  str_replace_all("\\<name of interviewee\\>", "NAME") %>%
  str_replace_all("\\<name of.*\\>", "NAME") %>%
  str_replace_all("\\<name of city\\>", "CITY") %>%
  str_replace_all("\\<hometown of the interviewee\\>", "CITY")

# Excluindo pontos, dois pontos, chaves
B2_all2 <- B2_all1 %>%
  str_replace_all("\\.", "") %>%
  str_replace_all("\\..", "") %>%
  str_replace_all("\\...", "") %>%
  str_replace_all("\\:", "") %>%
  str_replace_all("\\{", "") %>%
  str_replace_all("\\}", "")

# Excluindo <nv>, foreign, <[Ov/]>, <hh>
B2_all3 <- B2_all2 %>%
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
B2_all4 <- B2_all3 %>%
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
B2_all5 = B2_all4 %>% str_remove_all("\\<L0.*\\>") %>%
  str_remove_all("\\<INT\\>") %>%
  str_remove_all("\\<Ov\\/\\>") %>%
  str_remove_all("\\<Ov\\/\\]\\>") %>%
  str_remove_all("\\(hum-um\\)") %>%
  str_replace_all("\\<first name of interviewee\\>", "NAME") %>%
  str_remove_all("\\+") %>%
  str_replace_all("OH", "") %>%
  str_remove_all("\\<PN[0-9]+[:alpha:]+\\>")

#remover espaços em branco extras e linhas em branco
B2_all6 <- B2_all5 %>%
  str_remove_all("\\n") %>% 
  str_remove_all("^ +$") %>%
  str_replace_all(" +"," ") %>%
  str_remove_all("^ ") %>%
  str_remove_all(" $")
  

B2_all7 <- B2_all6[B2_all6!=""]

#Exportando em txt
writeLines(B2_all7, "B2_all.txt", useBytes = T)


