require 'numru/lapack'
require 'sinatra'

get '/' do
  jobz = "V"
  range = "I"
  uplo = "U"
  a = NArray[[1,2],[2,3]]
  vl =  vu = 0 # not be used in this example
  il = 1
  iu = 2
  abstol = 0.0

  m, w, z, isuppz, work, iwork, info, a = NumRu::Lapack.dsyevr(jobz, range, uplo, a, vl, vu, il, iu, abstol)
  "Hello ruby lapack #{[m,w,z,isuppz,work,iwork,info,a].inspect}"
end
