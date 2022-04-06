###################### BOTANY 563 in class testing

# install.packages("adegenet", dependencies = TRUE)
# install.packages("phangorn", dependencies = TRUE)
# install.packages("protr")

library(ape)
library(adegenet)
library(phangorn)

################################### DISTANCE BASED METHODS ###################################

###################### Neighbor Joining Method ######################

#####################DNA example
dna <- fasta2DNAbin("http://adegenet.r-forge.r-project.org/files/usflu.fasta")
#calculate distances
D <- dist.dna(dna, model="TN93")

#classical neighbor joining algorithm
#bionj is the improved version
tre <- nj(D)
tre <- ladderize(tre)

plot(tre, cex=.4)
title("A simple NJ tree")

##################### Protein, my data
aa_alignment <- read.phyDat("dsrC_PlumeViruses_uniprot_mafft.faa", format = "fasta",
                            type = "AA")
#calculate distance
aa <- as.AAbin(aa_alignment) #create AAbin object
D_aa <- dist.aa(aa)

tre_aa <- nj(D_aa)
tre_aa <- ladderize(tre_aa)

plot(tre_aa, cex=.2)
title("A simple NJ tree")

###################### Maximum Parsimony Method ######################

#####################DNA example
dna2 <- as.phyDat(dna)

#build a distance tree to use a starting tree for parsimony
#model raw is p distances directly, not using model of evolution
tre.ini <- nj(dist.dna(dna,model="raw")) 
parsimony(tre.ini, dna2)

tre.pars <- optim.parsimony(tre.ini, dna2)
plot(tre.pars, cex=0.4)

##################### Protein, my data

aa2 <- as.phyDat.AAbin(aa)

tre.ini_aa <- nj(dist.aa(aa))
parsimony(tre.ini_aa, aa2)

tre.pars_aa <- optim.parsimony(tre.ini_aa, aa2)
plot(tre.pars_aa, cex=0.2)

####Experimenting with writing tree files and trying to plot trees side by side

#write tree file in newick format
ape::write.tree(tre_aa, file = "distanceNJ_tree_dsrC_PlumeViruses.nwk")
ape::write.tree(tre.pars_aa, file = "parsimony_tree_dsrC_PlumeViruses.nwk")


# if (!require("BiocManager", quietly = TRUE))
#   install.packages("BiocManager")
# 
# BiocManager::install("treeio")
# BiocManager::install("ggtree")
# library("treeio")
# library("ggtree")
# 
# nwk <- system.file("parsimony_tree_test.nwk", package="treeio")
# tree <- read.tree(nwk)
# 
# ggplot(tree, aes(x, y)) + geom_tree() + theme_tree()

# cophyloplot(tre, tre.pars, assoc = NULL, space = 25, font = .01)
# dev.off()

