within_connectivity=function(g,s,method,nrep){
  wc=igraph::ecount(igraph::induced_subgraph(g,s))
  if (method=="rand_seeds"){
    pval=0
    dist=vector()
    for (i in 1:nrep){
      rs=sample(igraph::vcount(g),length(s))
      dist[i]=igraph::ecount(igraph::induced_subgraph(g,rs))
      pval=pval+1*(dist[i]>wc)+0.5*(dist[i]==wc)
    }
    pval=pval/nrep
  } else if (method=="rand_edges"){
    pval=0
    dist=vector()
    degseq=degree(g)
    for (i in 1:nrep){
      rg=igraph::sample_degseq(degseq,method="vl")
      dist[i]=igraph::ecount(igraph::induced_subgraph(rg,s))
      pval=pval+1*(dist[i]>wc)+0.5*(dist[i]==wc)
    }
    pval=pval/nrep
  } else if (method=="hyper"){
    ntot=igraph::vcount(g)*(igraph::vcount(g)-1)/2
    m=igraph::ecount(g)
    n=ntot-m
    k=length(s)*(length(s)-1)/2
    pval=phyper(wc-1,m,n,k,lower.tail=F)
    dist=vector()
  }
  list(wc=wc,p=pval,dist=dist)
}