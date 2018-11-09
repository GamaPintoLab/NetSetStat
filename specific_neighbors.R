specific_neighbors=function(g,s){
  
  bigadj=as_adjacency_matrix(g,names=F,sparse=F)
  neib=rowSums(as.matrix(bigadj[,s]))
  
  
  multineibtab$neib=neib #3
  multineibtab$degree=degree(g) #9
  n1=length(s)
  ntot=vcount(g)-1
  
  multineibtab$p=-log10(phyper(multineibtab$neib,n1,ntot-n1,multineibtab$degree,lower.tail=F))
  multineibtab$r=rank(multineibtab$p_wt)/vcount(g)
  multineibtab
}

