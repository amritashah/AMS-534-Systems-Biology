library(ShortRead)
library(tidyverse)

sBasedir = "/Users/tmaccart/Documents/stonybrook/courses/AMS-534/spring.2023/r.sessions/datasets/"
sFilename = paste( c(sBasedir,"MiSeq_Ecoli_10Ksubset.fastq.gz"), collapse="" )
rTest = readFastq(sFilename)

print(rTest)
print( quality(rTest) )
print( head(sread(rTest)) )

quals <- as( quality( rTest ), "matrix")
tibQuals = tibble(seqStep=1:ncol(quals),meanQual=colMeans(quals), sd=apply(quals,2,sd) )
p1 = ggplot(tibQuals, aes(x=seqStep, y=meanQual)) +
  geom_errorbar(aes(ymin=meanQual-sd, ymax=meanQual+sd), width=.1) +
  geom_line() +
  geom_point()
plot(p1)

sFilename = paste( c(sBasedir,"AE004437.ffn"), collapse="" )
myseq1 <- readDNAStringSet(sFilename)
myseq1[grep("phosphoesterase", names(myseq1))] # Retrieves all sequences containing the term "phosphodiesterase" in their name field.
myseq2 <- myseq1[grep("^ATGCTT", sapply(as.list(myseq1), toString))] # Retrieves all sequences starting with "ATGCTT".
writeXStringSet(myseq2, file="myseq2.txt", format="fasta", width=80) # Writes sequences to file in FASTA format.

data(phiX174Phage) # Imports six versions of the complete genome for bacteriophage phi X174 as DNAStringSet object.
mymm <- which(rowSums(t(consensusMatrix(phiX174Phage))[,1:4] == 6)!=1) # Creates a consensus matrix and returns the mismatch (SNP) positions.
DNAStringSet(phiX174Phage, start=mymm[1], end=mymm[1]+10) # Prints the sequence sections for the first SNP region in the phiX174Phage sequences.
consensusString(DNAStringSet(phiX174Phage, start=mymm[1], end=mymm[1]+10)) # Prints the consensus sequence for the corresponding SNP region.

mysnp <- t(consensusMatrix(phiX174Phage))[mymm,1:4];
rownames(mysnp) <- paste("SNP", mymm, sep="_"); mysnp # Returns the consensus matrix data only for the SNP positions.

mysnp2 <- lapply(seq(along=mymm), function(x) sapply(as.list(DNAStringSet(phiX174Phage, start=mymm[x], end=mymm[x])), toString))
mysnp2 <- as.data.frame(mysnp2)
colnames(mysnp2) <- paste("SNP", mymm, sep="_"); mysnp2 # Returns all SNPs in a data frame and names them according to their positions.

#############################################
## Reverse and Complement of DNA Sequences ##
#############################################
reverseComplement(myseq1) # Returns reverse and complement for may BioC object types including XString, XStringView and XStringSet.

##########################################
## Translate DNA into Protein Sequences ##
##########################################
translate(myseq1[1]) # Translates a single ORF and returns result as AAStringSet object.
translate(myseq1) # Translates all ORFs in myseq1. 
