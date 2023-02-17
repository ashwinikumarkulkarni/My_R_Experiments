rm(list = ls())
library(SuperExactTest)
library(ggplot2)

## READ DGE TABLES
a_ko_wt_dt <- read.table("DGE_PC_MASTGLM_PC_A_KO_X_WT_FULL_AVG_EXP.txt", sep = "\t", header = TRUE)
b_ko_wt_dt <- read.table("DGE_PC_MASTGLM_PC_B_KO_X_WT_FULL_AVG_EXP.txt", sep = "\t", header = TRUE)
a_dko_wt_dt <- read.table("DGE_PC_MASTGLM_PC_A_DKO_X_WT_FULL_AVG_EXP.txt", sep = "\t", header = TRUE)
b_dko_wt_dt <- read.table("DGE_PC_MASTGLM_PC_B_DKO_X_WT_FULL_AVG_EXP.txt", sep = "\t", header = TRUE)

## FILTER FOR FDR
a_ko_wt <- a_ko_wt_dt[a_ko_wt_dt$adj_p_value <= 0.05,]
b_ko_wt <- b_ko_wt_dt[b_ko_wt_dt$adj_p_value <= 0.05,]
a_dko_wt <- a_dko_wt_dt[a_dko_wt_dt$adj_p_value <= 0.05,]
b_dko_wt <- b_dko_wt_dt[b_dko_wt_dt$adj_p_value <= 0.05,]

## FILTER DGE TABLES
a_ko_wt_sig <- a_ko_wt[a_ko_wt$avg_logfc >= 0.26 | a_ko_wt$avg_logfc <= -0.26,]
b_ko_wt_sig <- b_ko_wt[b_ko_wt$avg_logfc >= 0.26 | b_ko_wt$avg_logfc <= -0.26,]
a_dko_wt_sig <- a_dko_wt[a_dko_wt$avg_logfc >= 0.26 | a_dko_wt$avg_logfc <= -0.26,]
b_dko_wt_sig <- b_dko_wt[b_dko_wt$avg_logfc >= 0.26 | b_dko_wt$avg_logfc <= -0.26,]


## UP GENES
a_ko_wt_sig_up <- row.names(a_ko_wt_sig[a_ko_wt_sig$avg_logfc > 0,])
b_ko_wt_sig_up <- row.names(b_ko_wt_sig[b_ko_wt_sig$avg_logfc > 0,])
a_dko_wt_sig_up <- row.names(a_dko_wt_sig[a_dko_wt_sig$avg_logfc > 0,])
b_dko_wt_sig_up <- row.names(b_dko_wt_sig[b_dko_wt_sig$avg_logfc > 0,])

## DOWN GENES
a_ko_wt_sig_dn <- row.names(a_ko_wt_sig[a_ko_wt_sig$avg_logfc < 0,])
b_ko_wt_sig_dn <- row.names(b_ko_wt_sig[b_ko_wt_sig$avg_logfc < 0,])
a_dko_wt_sig_dn <- row.names(a_dko_wt_sig[a_dko_wt_sig$avg_logfc < 0,])
b_dko_wt_sig_dn <- row.names(b_dko_wt_sig[b_dko_wt_sig$avg_logfc < 0,])


## Heatmap of DEGs
degLists <- list("PC_A_KO_X_WT_up" = a_ko_wt_sig_up,
				 "PC_A_DKO_X_WT_up" = a_dko_wt_sig_up,
				 "PC_A_KO_X_WT_dn" = a_ko_wt_sig_dn,
			  	 "PC_A_DKO_X_WT_dn" = a_dko_wt_sig_dn,
				 "PC_B_KO_X_WT_up" = b_ko_wt_sig_up,
				 "PC_B_DKO_X_WT_up" = b_dko_wt_sig_up,
				 "PC_B_KO_X_WT_dn" = b_ko_wt_sig_dn,
				 "PC_B_DKO_X_WT_dn" = b_dko_wt_sig_dn
				 )

res <- supertest(degLists, n = mean(nrow(a_ko_wt_dt), nrow(b_dko_wt_dt), nrow(a_dko_wt_dt), nrow(b_dko_wt_dt)))
resTab <- as.data.frame(summary(res)$Table)

write.table(resTab, "DGE_PC_MASTGLM_PC_SUPER_EXACT_TEST.txt", row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

resTabSel <- resTab[resTab$Degree == 2, c(1, 3, 5, 6)]


