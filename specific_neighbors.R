specific_neighbors=function(g,s){
  
  bigadj=as_adjacency_matrix(g,names=F)
  neib=rowSums(as.matrix(bigadj[,s]))
  gdegree=rowSums(as.matrix(bigadj[,]))
  multineibtab=data.frame(id=(1:length(neib)),neib=neib,degree=gdegree,stringsAsFactors=F)
  n1=length(s)
  ntot=vcount(g)-1
  
  multineibtab$p=-log10(phyper(multineibtab$neib,n1,ntot-n1,multineibtab$degree,lower.tail=F))
  multineibtab$r=rank(multineibtab$p)/vcount(g)
  multineibtab
}

