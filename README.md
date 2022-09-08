# Wrapper_scaleway

Wrapper that will permit us an easier search on Scaleway


## How does it work ?

thor scw_osp list : Will list you all servers that are available on scaleway

thor scw_osp get [ID|NAME|IP] : Will search for you the right server you're searching

WARNING : For the get you need to use the following format : thor scw_osp get ID:[id]
Otherwise it will print you an error.
