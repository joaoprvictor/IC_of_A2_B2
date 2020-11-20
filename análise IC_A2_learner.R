# Colocando como working directory
setwd("~/A2")

# Carregando pacotes
library(tidyverse)
library(stringr)

# Abrindo os arquivos B2
linhas1A2 <- readLines("L001A2.txt", encoding = "utf-8")
linhas2A2 <- readLines("L005A2.txt", encoding = "utf-8")
linhas3A2 <- readLines("L007A2.txt", encoding = "utf-8")
linhas4A2 <- readLines("L008A2.txt", encoding = "utf-8")
linhas5A2 <- readLines("L012A2.txt", encoding = "utf-8")

#Juntando os arquivos
linhasA2 <- c(linhas1A2, linhas2A2, linhas3A2, linhas4A2, linhas5A2)

#Excluindo turnos do entrevistador
linhasA2_apr <- linhasA2 %>% str_subset("^\\<[^I]")

#Excluindo <name of ...>
A2_1 <- linhasA2_apr %>% str_replace_all("\\<name*\\>", "NAME") %>% 
  str_replace_all("\\<name of the interviewee\\>", "NAME") %>%
  str_replace_all("\\<name of interviewee\\>", "NAME") %>%
  str_replace_all("\\<name of.*\\>", "NAME") %>%
  str_replace_all("\\<name of city\\>", "CITY") %>%
  str_replace_all("\\<hometown of the interviewee\\>", "CITY")

# Excluindo pontos, dois pontos, chaves
A2_2 <- A2_1 %>%
  str_replace_all("\\.", "") %>%
  str_replace_all("\\..", "") %>%
  str_replace_all("\\...", "") %>%
  str_replace_all("\\:", "") %>%
  str_replace_all("\\{", "") %>%
  str_replace_all("\\}", "")

# Excluindo <nv>, foreign, <[Ov/]>, <hh>
A2_3 <- A2_2 %>%
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
A2_4 <- A2_3 %>%
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
A2_5 = A2_4 %>% str_remove_all("\\<L0.*\\>") %>%
  str_remove_all("\\<INT\\>") %>%
  str_remove_all("\\<Ov\\/\\>") %>%
  str_remove_all("\\<Ov\\/\\]\\>") %>%
  str_remove_all("\\(hum-um\\)") %>%
  str_replace_all("\\<first name of interviewee\\>", "NAME") %>%
  str_remove_all("\\+") %>%
  str_replace_all("OH", "") %>%
  str_remove_all("\\<PN[0-9]+[:alpha:]+\\>")

#remover espaços em branco extras e linhas em branco
A2_6 <- A2_5 %>%
  str_remove_all("\\n") %>% 
  str_remove_all("^ +$") %>%
  str_replace_all(" +"," ") %>%
  str_remove_all("^ ") %>%
  str_remove_all(" $")

A2_6 <- A2_6[A2_6!=""]

#Exportando em txt
writeLines(A2_6, "learner_A2.txt", useBytes = T)
